<?php

namespace app\admin\controller\general;

use app\admin\model\Admin;
use app\admin\model\Mch;
use app\common\controller\Backend;
use fast\Random;
use think\Session;

/**
 * 个人配置
 *
 * @icon fa fa-user
 */
class Profile extends Backend
{
    public function _initialize()
    {
        parent::_initialize();
        $model = model('Mch');
        $msg = $model
            ->where('id', $this->auth->username)
            ->find();
        $this->view->assign("mch", $msg);
        if ($this->auth->isSuperAdmin()) {
            $this->view->assign("superAdmin", '1');
        } else {
            $this->view->assign("superAdmin", '0');
        }
    }

    /**
     * 查看
     */
    public function index()
    {
        //设置过滤方法
        $this->request->filter(['strip_tags']);
        if ($this->request->isAjax()) {
            $model = model('AdminLog');
            list($where, $sort, $order, $offset, $limit) = $this->buildparams();
            $total = $model
                ->where($where)
                ->where('admin_id', $this->auth->id)
                ->order($sort, $order)
                ->count();

            $list = $model
                ->where($where)
                ->where('admin_id', $this->auth->id)
                ->order($sort, $order)
                ->limit($offset, $limit)
                ->select();
            $result = array("total" => $total, "rows" => $list);
            return json($result);
        }
        return $this->view->fetch();
    }

    /**
     * 更新个人信息
     */
    public function update()
    {
        if ($this->request->isPost()) {
            $params = $this->request->post("row/a");
            if ($this->auth->isSuperAdmin()) {
                $params = array_filter(array_intersect_key($params, array_flip(array('email', 'nickname', 'password'))));
                unset($v);
                if (isset($params['password'])) {
                    $params['salt'] = Random::alnum();
                    $params['password'] = md5(md5($params['password']) . $params['salt']);
                }
            } else {
                $params = array_filter(array_intersect_key($params, array_flip(array(
                    'email',
                    'nickname',
                    'password',
                    'image',
                    'licence_images',
                    'desc',
                    'request_price',
                    'send_price',
                    'contact',
                    'city',
                    'addr'
                ))));
                unset($v);
                if (isset($params['password'])) {
                    $params['salt'] = Random::alnum();
                    $params['password'] = md5(md5($params['password']) . $params['salt']);
                }
            }
            if ($params) {
                if ($this->auth->isSuperAdmin()) {
                    $params = $this->array_remove($params, 'image');
                    $admin = Admin::get($this->auth->id);
                    $admin->save($params);
                    //因为个人资料面板读取的Session显示，修改自己资料后同时更新Session
                    Session::set("admin", $admin->toArray());
                } else {
                    $a['email'] = $params['email'];
                    $a['nickname'] = $params['nickname'];
                    $a['avatar'] = $params['image'];
                    if (isset($params['password'])) {
                        $a['salt'] = $params['salt'];
                        $a['password'] = $params['password'];
                        $params = $this->array_remove($params, 'salt');
                        $params = $this->array_remove($params, 'password');
                    }
                    $params = $this->array_remove($params, 'avatar');
                    $admin = Admin::get($this->auth->id);
                    $admin->save($a);
                    //因为个人资料面板读取的Session显示，修改自己资料后同时更新Session
                    Session::set("admin", $admin->toArray());
                    $params['id'] = $this->auth->username;
                    $params['name'] = $params['nickname'];
                    $params['lat'] = '0';
                    $params['lng'] = '0';
                    $params = $this->array_remove($params, 'nickname');
                    $params = $this->array_remove($params, 'email');
                    $admin = Mch::get($this->auth->username);
                    $admin->save($params);
                }
                $this->success();
            }
            $this->error();
        }
        return;
    }

    private function array_remove($data, $key)
    {
        if (!array_key_exists($key, $data)) {
            return $data;
        }
        $keys = array_keys($data);
        $index = array_search($key, $keys);
        if ($index !== FALSE) {
            array_splice($data, $index, 1);
        }
        return $data;
    }
}
