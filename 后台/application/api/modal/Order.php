<?php
/**
 * Created by PhpStorm.
 * User: JamesLiu
 * Date: 2018/8/27
 * Time: 14:50
 * Email: JamesLiu_storm@foxmail.com
 */

namespace app\api\modal;


use think\Model;

class Order extends Model
{
    public function getOrder($userid, $page)
    {
        $modal = new Order();
        $rs = $modal->where('o.userid', $userid)
            ->alias('o')
            ->limit(($page - 1) * 10, 10)
            ->join('elm_address a', 'o.addressid=a.id')
            ->join('elm_mch m', 'o.mchid=m.id')
            ->join('elm_sender s', 'o.senderid=s.id')
            ->field("o.*,FROM_UNIXTIME(o.createtime, '%Y-%m-%d %H:%i') as createtime,FROM_UNIXTIME(o.paytime, '%Y-%m-%d %H:%i') as paytime,FROM_UNIXTIME(o.gettime, '%Y-%m-%d %H:%i') as gettime,FROM_UNIXTIME(o.sendtime, '%Y-%m-%d %H:%i') as sendtime,FROM_UNIXTIME(o.finishtime, '%Y-%m-%d %H:%i') as finishtime,FROM_UNIXTIME(o.canceltime, '%Y-%m-%d %H:%i') as canceltime,a.linkman,a.mobile,a.address,m.name as mch_name,m.image as mch_image,m.contact as mch_contact,s.name as sendername,s.phone as senderphone")
            ->order('createtime desc')
            ->select();
        return $rs;
    }

    public function getPayMsg($orderid)
    {
        $modal = new Order();
        $rs = $modal->where('o.id', $orderid)
            ->alias('o')
            ->join('elm_member m', 'o.userid=m.id')
            ->field("o.*,FROM_UNIXTIME(o.createtime, '%Y-%m-%d %H:%i') as createtime,FROM_UNIXTIME(o.paytime, '%Y-%m-%d %H:%i') as paytime,FROM_UNIXTIME(o.gettime, '%Y-%m-%d %H:%i') as gettime,FROM_UNIXTIME(o.sendtime, '%Y-%m-%d %H:%i') as sendtime,FROM_UNIXTIME(o.finishtime, '%Y-%m-%d %H:%i') as finishtime,FROM_UNIXTIME(o.canceltime, '%Y-%m-%d %H:%i') as canceltime,m.openid")
            ->find();
        return $rs;
    }

    public function getForsender($senderid, $status, $page)
    {
        $modal = new Order();
        $rs = $modal->where('o.senderid', $senderid)
            ->where('o.status', $status)
            ->alias('o')
            ->limit(($page - 1) * 10, 10)
            ->join('elm_address a', 'o.addressid=a.id')
            ->join('elm_mch m', 'o.mchid=m.id')
            ->join('elm_sender s', 'o.senderid=s.id')
            ->field("o.*,FROM_UNIXTIME(o.createtime, '%Y-%m-%d %H:%i') as createtime,FROM_UNIXTIME(o.paytime, '%Y-%m-%d %H:%i') as paytime,FROM_UNIXTIME(o.gettime, '%Y-%m-%d %H:%i') as gettime,FROM_UNIXTIME(o.sendtime, '%Y-%m-%d %H:%i') as sendtime,FROM_UNIXTIME(o.finishtime, '%Y-%m-%d %H:%i') as finishtime,FROM_UNIXTIME(o.canceltime, '%Y-%m-%d %H:%i') as canceltime,a.linkman,a.mobile,a.address,m.name as mch_name,m.image as mch_image,m.contact as mch_contact,s.name as sendername,s.phone as senderphone")
            ->order('createtime desc')
            ->select();
        return $rs;
    }
}