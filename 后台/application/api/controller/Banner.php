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
use app\api\modal\Banner as modal_banner;

/**
 * 轮播图接口
 */
class Banner extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    protected $request_type = 'post';

    public function _initialize()
    {
        $this->request_type = config('request');
    }

    /**
     * 获取首页轮播图
     *
     * @ApiTitle    (获取首页轮播图)
     * @ApiSummary  (获取首页轮播图)
     * @ApiMethod   (POST)
     */

    public function getBanner()
    {
        $modal = new modal_banner();
        $rs = $modal->getBanner();
        if ($rs) {
            $this->success('返回成功', $rs);
        }
    }

}