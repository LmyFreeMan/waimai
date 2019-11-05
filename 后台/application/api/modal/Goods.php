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

class Goods extends Model
{
    public function getMchGoods($mchid)
    {
        $modal = new Goods();
        $rs = $modal->where('g.mch_id', $mchid)
            ->alias('g')
            ->join('elm_goodcat c', 'g.goodcat_id=c.id')
            ->field('g.goodcat_id as cat_id,c.name as cat_name,g.id as good_id,g.name,g.image,g.desc,g.price,g.sales')
            ->order('c.weigh desc')
            ->select();
        return $rs;
    }
}