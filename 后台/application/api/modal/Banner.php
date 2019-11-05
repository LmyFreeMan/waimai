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

class Banner extends Model
{
    public function getBanner()
    {
        $modal = new Banner();
        $rs = $modal->order('createtime desc')->limit(5)->select();
        return $rs;
    }
}