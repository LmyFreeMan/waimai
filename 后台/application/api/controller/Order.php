<?php
/**
 * Created by PhpStorm.
 * User: JamesLiu
 * Date: 2018/8/27
 * Time: 14:07
 * Email: JamesLiu_storm@foxmail.com
 */


namespace app\api\controller;

use app\common\controller\Api;
use app\api\modal\Order as modal_order;
use app\admin\model\Mch as model_mch;
use app\admin\model\Address as modal_address;
use app\api\controller\Sms as api_sms;


/**
 * 用户收货地址接口
 */
class Order extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    protected $request_type = 'post';

    public function _initialize()
    {
        $this->request_type = config('request');
    }

    /**
     * 订单生成
     *
     */
    public function add()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.userid')) {
                $this->error('缺少参数用户id');
            }
            if (!input('?get.mchid')) {
                $this->error('缺少参数商户id');
            }
            if (!input('?get.addressid')) {
                $this->error('缺少参数地址id');
            }
            if (!input('?get.sendprice')) {
                $this->error('缺少参数配送费');
            }
            if (!input('?get.totalprice')) {
                $this->error('缺少参数总价');
            }
            if (!input('?get.order')) {
                $this->error('缺少参数订单信息');
            }
        } else {
            if (!input('?post.userid')) {
                $this->error('缺少参数用户id');
            }
            if (!input('?post.mchid')) {
                $this->error('缺少参数商户id');
            }
            if (!input('?post.addressid')) {
                $this->error('缺少参数地址id');
            }
            if (!input('?post.sendprice')) {
                $this->error('缺少参数配送费');
            }
            if (!input('?post.totalprice')) {
                $this->error('缺少参数总价');
            }
            if (!input('?post.order')) {
                $this->error('缺少参数订单信息');
            }
        }
        $userid = $this->request->param()['userid'];
        $mchid = $this->request->param()['mchid'];
        $addressid = $this->request->param()['addressid'];
        $sendprice = $this->request->param()['sendprice'];
        $totalprice = $this->request->param()['totalprice'];
        $order = $this->request->param()['order'];
        $modal = new modal_order();
        $data = [
            'userid' => $userid,
            'mchid' => $mchid,
            'addressid' => $addressid,
            'sendprice' => $sendprice,
            'totalprice' => $totalprice,
            'order' => $order,
            'senderid' => '1000',
            'createtime' => time(),
            'desc' => '订单待支付'
        ];
        $modal->insert($data);
        $rs = $modal->getLastInsID();
        $this->success('success', $rs);
    }


    /**
     * 订单支付信息获取
     *
     */
    public function wxPay()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.orderid')) {
                $this->error('缺少参数订单id');
            }
        } else {
            if (!input('?post.orderid')) {
                $this->error('缺少参数订单id');
            }
        }
        $orderid = $this->request->param()['orderid'];
        $modal = new modal_order();
        $payMsg = $modal->getPayMsg($orderid);
        if ($payMsg['status'] == 2) {
            $this->error('该订单已支付');
        }
        if ($payMsg['status'] != 1) {
            $this->error('订单状态错误');
        }
        $rs = (new Wechatmini)->WxPay($payMsg['openid'], $payMsg['totalprice'], $orderid . '外卖支付', $orderid);
        $this->success('success', $rs);
    }


    /**
     * 订单支付更新
     *
     */
    public function updatePay()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.orderid')) {
                $this->error('缺少参数订单id');
            }
            if (input('?get.formid')) {
                $formid = $this->request->param()['formid'];
            } else {
                $formid = '';
            }
        } else {
            if (!input('?post.orderid')) {
                $this->error('缺少参数订单id');
            }
            if (input('?post.formid')) {
                $formid = $this->request->param()['formid'];
            } else {
                $formid = '';
            }
        }
        $orderid = $this->request->param()['orderid'];
//        $data = [
//            'id' => $orderid,
//            'status' => 2,
//            'paytime' => time(),
//            'formid' => $formid,
//            'desc' => '订单已支付，等待商家接单'
//        ];
        $sender = db('sender')->field('id,phone')->select();
        $msg = db('order')->where('id', $orderid)->find();
        $model = new model_mch();
        $model->where('id', $msg['mchid'])->setInc('money', $msg['totalprice']);
        $sender_id = mt_rand(1, count($sender) - 1);
        $api_sms = new api_sms();
//        获取用户信息
        $address_msg = db('address')->where('id', $msg['addressid'])->find();
//        获取商家信息
        $mch_msg = db('mch')->where('id', $msg['mchid'])->find();
        $sender_TemplateParam = Array(
            "linkman" => $address_msg['linkman'],
            "phone" => $address_msg['mobile'],
            "addr" => $address_msg['address'],
            "shop" => $mch_msg['name'],
        );
        $mch_TemplateParam = Array(
            "order" => $orderid,
            "linkman" => $address_msg['linkman'],
            "phone" => $address_msg['mobile'],
        );
//        给配送员发送消息
        $api_sms->sendSms($sender[$sender_id]['phone'], 'SMS_149390365', $sender_TemplateParam);
//        给商户发送消息
        $api_sms->sendSms($mch_msg['contact'], 'SMS_149385476', $mch_TemplateParam);
        $data = [
            'id' => $orderid,
            'status' => 4,
            'paytime' => time(),
            'gettime' => time(),
            'sendtime' => time(),
            'formid' => $formid,
            'senderid' => $sender[$sender_id]['id'],
            'desc' => '您的订单正在配送中，请稍后'
        ];
        $modal = new modal_order();
        $rs = $modal->update($data);
        $this->success('success', $rs);
    }

    /**
     * 获取用户订单
     *
     */
    public function get()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.userid')) {
                $this->error('缺少参数用户id');
            }
            if (!input('?get.page')) {
                $page = 1;
            } else {
                $page = $this->request->param()['page'];
            }
        } else {
            if (!input('?post.userid')) {
                $this->error('缺少参数用户id');
            }
            if (!input('?post.page')) {
                $page = 1;
            } else {
                $page = $this->request->param()['page'];
            }
        }
        $userid = $this->request->param()['userid'];
        $modal = new modal_order();
        $rs = $modal->getOrder($userid, $page);
        $this->success('success', $rs);
    }

    /**
     * 删除地址（不是真正删除）
     *
     */
    public function delete()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.id')) {
                $this->error('缺少参数地址id');
            }
            if (!input('?get.userid')) {
                $this->error('缺少参数用户id');
            }
        } else {
            if (!input('?post.id')) {
                $this->error('缺少参数地址id');
            }
            if (!input('?post.userid')) {
                $this->error('缺少参数用户id');
            }
        }
        $id = $this->request->param()['id'];
        $userid = $this->request->param()['userid'];
        $modal = new modal_address();
        $modal->update(['id' => $id, 'type' => 0]);
        $rs = $modal->where('userid', $userid)->where('type', 1)->order('updatetime desc')->select();
        $this->success('success', $rs);
    }

    /**
     * 更新地址
     *
     */
    public function update()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.id')) {
                $this->error('缺少参数地址id');
            }
            if (!input('?get.userid')) {
                $this->error('缺少参数用户id');
            }
            if (!input('?get.linkman')) {
                $this->error('缺少参数联系人');
            }
            if (!input('?get.mobile')) {
                $this->error('缺少参数联系电话');
            }
            if (!input('?get.address')) {
                $this->error('缺少参数详细地址');
            }
        } else {
            if (!input('?post.id')) {
                $this->error('缺少参数地址id');
            }
            if (!input('?post.userid')) {
                $this->error('缺少参数用户id');
            }
            if (!input('?post.linkman')) {
                $this->error('缺少参数联系人');
            }
            if (!input('?post.mobile')) {
                $this->error('缺少参数联系电话');
            }
            if (!input('?post.address')) {
                $this->error('缺少参数详细地址');
            }
        }
        $id = $this->request->param()['id'];
        $userid = $this->request->param()['userid'];
        $linkman = $this->request->param()['linkman'];
        $mobile = $this->request->param()['mobile'];
        $address = $this->request->param()['address'];
        $modal = new modal_address();
        $data = [
            'id' => $id,
            'userid' => $userid,
            'linkman' => $linkman,
            'mobile' => $mobile,
            'address' => $address,
            'updatetime' => time(),
        ];
        $rs = $modal->update($data);
        $this->success('success', $rs);
    }


    /**
     * 获取配送员订单
     *
     */
    public function getForsender()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.senderid')) {
                $this->error('缺少参数配送员id');
            }
            if (!input('?get.status')) {
                $this->error('缺少参数status');
            }
            if (!input('?get.page')) {
                $page = 1;
            } else {
                $page = $this->request->param()['page'];
            }
        } else {
            if (!input('?post.senderid')) {
                $this->error('缺少参数配送员id');
            }
            if (!input('?post.status')) {
                $this->error('缺少参数status');
            }
            if (!input('?post.page')) {
                $page = 1;
            } else {
                $page = $this->request->param()['page'];
            }
        }
        $senderid = $this->request->param()['senderid'];
        $status = $this->request->param()['status'];
        $modal = new modal_order();
        $rs = $modal->getForsender($senderid, $status, $page);
        $this->success('success', $rs);
    }


    /**
     * 订单完成
     *
     */
    public function finishOrder()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.orderid')) {
                $this->error('缺少参数订单id');
            }
        } else {
            if (!input('?post.orderid')) {
                $this->error('缺少参数订单id');
            }
        }
        $orderid = $this->request->param()['orderid'];
        $data = [
            'id' => $orderid,
            'status' => 5,
            'finishtime' => time(),
            'desc' => '订单已完成，期待下次光临',
        ];
        $modal = new modal_order();
        $rs = $modal->update($data);
        $this->success('success', $rs);
    }

}