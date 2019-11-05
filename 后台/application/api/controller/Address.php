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
use app\api\modal\Address as modal_address;

/**
 * 用户收货地址接口
 */
class Address extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    protected $request_type = 'post';

    public function _initialize()
    {
        $this->request_type = config('request');
    }

    /**
     * 新增地址
     *
     */
    public function add()
    {
        if ($this->request_type == 'get') {
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
        $userid = $this->request->param()['userid'];
        $linkman = $this->request->param()['linkman'];
        $mobile = $this->request->param()['mobile'];
        $address = $this->request->param()['address'];
        $modal = new modal_address();
        $data = [
            'userid' => $userid,
            'linkman' => $linkman,
            'mobile' => $mobile,
            'address' => $address,
            'updatetime' => time(),
        ];
        $rs = $modal->insert($data);
        $this->success('success', $rs);
    }

    /**
     * 获取用户全部收货地址
     *
     */
    public function get()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.userid')) {
                $this->error('缺少参数用户id');
            }
        } else {
            if (!input('?post.userid')) {
                $this->error('缺少参数用户id');
            }
        }
        $userid = $this->request->param()['userid'];
        $modal = new modal_address();
        $rs = $modal->where('userid', $userid)->where('type', 1)->order('updatetime desc')->select();
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
        $modal->update(['id' => $id, 'status' => 0]);
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
}