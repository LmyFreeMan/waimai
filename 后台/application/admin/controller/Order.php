<?php

namespace app\admin\controller;

use app\common\controller\Backend;
use app\admin\model\Mch as model_mch;

/**
 * 订单管理
 *
 * @icon fa fa-circle-o
 */
class Order extends Backend
{

    /**
     * Order模型对象
     * @var \app\admin\model\Order
     */
    protected $model = null;

    public function _initialize()
    {
        parent::_initialize();
        $this->model = new \app\admin\model\Order;
        $this->view->assign("statusList", $this->model->getStatusList());
        if ($this->auth->isSuperAdmin()) {
            $this->view->assign("superAdmin", '1');
        } else {
            $this->view->assign("superAdmin", '0');
        }
    }

    /**
     * 默认生成的控制器所继承的父类中有index/add/edit/del/multi五个基础方法、destroy/restore/recyclebin三个回收站方法
     * 因此在当前控制器中可不用编写增删改查的代码,除非需要自己控制这部分逻辑
     * 需要将application/admin/library/traits/Backend.php中对应的方法复制到当前控制器,然后进行修改
     */

    /**
     * 查看
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags']);
        if ($this->request->isAjax()) {
            //如果发送的来源是Selectpage，则转发到Selectpage
            if ($this->request->request('keyField')) {
                return $this->selectpage();
            }
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            if ($this->auth->isSuperAdmin()) {
                $total = $this->model
                    ->where($where)
                    ->order($sort, $order)
                    ->count();
                $list = $this->model
                    ->alias('o')
                    ->where($where)
                    ->order($sort, $order)
                    ->limit($offset, $limit)
                    ->join('elm_address a', 'o.addressid=a.id')
                    ->join('elm_member m', 'o.userid=m.id')
                    ->join('elm_sender s', 'o.senderid=s.id')
                    ->field("o.*,a.linkman,a.mobile,a.address,m.nickname,s.name as sendername,s.phone as senderphone")
                    ->select();
            } else {
                $total = $this->model
                    ->where($where)
                    ->where('mchid', $this->auth->username)
                    ->order($sort, $order)
                    ->count();
                $list = $this->model
                    ->alias('o')
                    ->where($where)
                    ->where('mchid', $this->auth->username)
                    ->order($sort, $order)
                    ->limit($offset, $limit)
                    ->join('elm_address a', 'o.addressid=a.id')
                    ->join('elm_member m', 'o.userid=m.id')
                    ->join('elm_sender s', 'o.senderid=s.id')
                    ->field("o.*,a.linkman,a.mobile,a.address,m.nickname,s.name as sendername,s.phone as senderphone")
                    ->select();
            }
            $list = collection($list)->toArray();
            foreach ($list as $key => &$values) {
                $order_list = json_decode($values['order']);
                foreach ($order_list as $value) {
                    $num = $value->num;
                    $name = $value->name;
                    if (array_key_exists("list", $values)) {
                        $values['list'] = $values['list'] . ',' . $name . '*' . $num;
                    } else {
                        $values['list'] = $name . '*' . $num;
                    }
                }
            }
            $result = array("total" => $total, "rows" => $list);
            return json($result);
        }
        return $this->view->fetch();
    }


    /**
     * 编辑
     */
    public function edit($ids = NULL)
    {
        $row = $this->model->get($ids);
        if (!$row)
            $this->error(__('No Results were found'));
        $adminIds = $this->getDataLimitAdminIds();
        if (is_array($adminIds)) {
            if (!in_array($row[$this->dataLimitField], $adminIds)) {
                $this->error(__('You have no permission'));
            }
        }
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($params) {
                try {
                    $msg = json_decode($row->toJson(), true);
                    $status = $msg['status'];
                    if ($status == 1) {
                        $this->error('错误操作');
                    }
                    if ($params['status'] - 1 == $status || $params['status'] == 0) {
                        if ($params['status'] == 3) {
                            $params['gettime'] = time();
                            $params['desc'] = '商家已接单，等待制作配送';
                        }
                        if ($params['status'] == 4) {
                            $params['sendtime'] = time();
                            $params['desc'] = '您的订单正在配送中，请稍后';
                        }
                        if ($params['status'] == 5) {
                            //                            $model = new model_mch();
//                            $model->where('id', $msg['mchid'])->setInc('money', $msg['totalprice']);
                            $params['finishtime'] = time();
                            $params['desc'] = '订单已完成，期待下次光临';
                        }
                        if ($params['status'] == 0) {
                            $params['canceltime'] = time();
                            $params['desc'] = '您的订单已被取消';
                        }
                        //是否采用模型验证
                        if ($this->modelValidate) {
                            $name = basename(str_replace('\\', '/', get_class($this->model)));
                            $validate = is_bool($this->modelValidate) ? ($this->modelSceneValidate ? $name . '.edit' : true) : $this->modelValidate;
                            $row->validate($validate);
                        }
                        $result = $row->allowField(true)->save($params);
                        if ($result !== false) {
                            $this->success();
                        } else {
                            $this->error($row->getError());
                        }
                    } else {
                        $this->error('错误操作');
                    }
                } catch (\think\exception\PDOException $e) {
                    $this->error($e->getMessage());
                } catch (\think\Exception $e) {
                    $this->error($e->getMessage());
                }
            }
            $this->error(__('Parameter %s can not be empty', ''));
        }
        $this->view->assign("row", $row);
        return $this->view->fetch();
    }


}
