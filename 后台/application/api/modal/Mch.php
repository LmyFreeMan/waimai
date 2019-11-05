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

class Mch extends Model
{
    public function getMch()
    {
        $modal = new Mch();
        $rs = $modal->field('id,image,name,desc,request_price,send_price,contact,usetime')->select();
        return $rs;
    }

    public function getMchDetail($mchid)
    {
        $modal = new Mch();
        $rs = $modal->where('id', $mchid)->field('city,addr,licence_images')->find();
        return $rs;
    }
}