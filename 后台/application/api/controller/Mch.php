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
use app\api\modal\Mch as modal_mch;

/**
 * 店铺接口
 */
class Mch extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    protected $request_type = 'post';

    public function _initialize()
    {
        $this->request_type = config('request');
    }

    /**
     * 获取店铺信息
     *
     * @ApiTitle    (获取店铺信息)
     * @ApiSummary  (获取店铺信息)
     * @ApiMethod   (POST)
     */

    public function getMch()
    {
        $modal = new modal_mch();
        $rs = $modal->getMch();
        if ($rs) {
            foreach ($rs as $key => &$value) {
                $value['count'] = db('order')->where('mchid', $value['id'])->where('status', 5)->count('id');
            }
            $this->success('返回成功', $rs);
        } else {
            $this->success('数据获取失败');
        }
    }

    /**
     * 获取店铺商家信息
     *
     * @ApiTitle    (获取店铺商家信息)
     * @ApiSummary  (获取店铺商家信息)
     * @ApiMethod   (POST)
     */

    public function getMchDetail()
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
        $modal = new modal_mch();
        $rs = $modal->getMchDetail($mchid);
        if ($rs) {
            $this->success('返回成功', $rs);
        } else {
            $this->success('数据获取失败');
        }
    }
}