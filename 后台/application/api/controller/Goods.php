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
use app\api\modal\Goods as modal_goods;

/**
 * 商品接口
 */
class Goods extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    protected $request_type = 'post';

    public function _initialize()
    {
        $this->request_type = config('request');
    }

    /**
     * 根据商户号获取店铺商品
     *
     * @ApiTitle    (根据商户号获取店铺商品)
     * @ApiSummary  (根据商户号获取店铺商品)
     * @ApiMethod   (POST)
     */

    public function getMchGoods()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.mchid')) {
                $this->error('缺少参数商户id');
            }
        } else {
            if (!input('?post.mchid')) {
                $this->error('缺少参数商户id');
            }
        }
        $mchid = $this->request->param()['mchid'];
        $modal_goods = new modal_goods();
        $goods = $modal_goods->getMchGoods($mchid);
        $result = array();
        foreach ($goods as $key => $value) {
            $result[$value['cat_id']]['cat_name'] = $value['cat_name'];
//            $result[$value['cat_id']]['type'] = $value['cat_id'];
            $result[$value['cat_id']]['foods'][] = $value;
        }
        if ($result) {
            $this->success('返回成功', $result);
        } else {
            $this->success('数据获取失败');
        }
    }


}