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
use app\api\modal\Member as modal_member;

/**
 * 用户接口
 */
class Member extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    protected $request_type = 'post';

    public function _initialize()
    {
        $this->request_type = config('request');
    }

    /**
     * 注册会员
     *
     */
    public function register()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.openid')) {
                $this->error('缺少参数openid');
            }
            if (!input('?get.nickname')) {
                $this->error('缺少参数用户微信昵称');
            }
            if (!input('?get.image')) {
                $this->error('缺少参数用户头像链接');
            }
            if (!input('?get.gender')) {
                $this->error('缺少参数用户性别');
            }
        } else {
            if (!input('?post.id')) {
                $this->error('缺少参数openid');
            }
            if (!input('?post.nickname')) {
                $this->error('缺少参数用户微信昵称');
            }
            if (!input('?post.image')) {
                $this->error('缺少参数用户头像链接');
            }
            if (!input('?post.gender')) {
                $this->error('缺少参数用户性别');
            }
        }
        $openid = $this->request->param()['openid'];
        $nickname = $this->request->param()['nickname'];
        $image = $this->request->param()['image'];
        $gender = $this->request->param()['gender'];
        $ip = $this->request->ip();
        $nickname = $this->filterEmoji($nickname);
//      先判断该用户是否存在数据库
        $modal = new modal_member();
        $count = $modal->where('openid', $openid)->count('openid');
        if ($count == 0) {
            $data = [
                'openid' => $openid,
                'nickname' => $nickname,
                'image' => $image,
                'gender' => $gender,
                'logintime' => time(),
                'lastip' => $ip,
                'createtime' => time(),
                'updatetime' => time(),
            ];
            $modal->insert($data);
            $rs = $modal->where('id', $modal->getLastInsID())->field('id,openid,mobile,senderid')->find();
            $this->success('success', $rs);
        } else {
            $rs = $modal->where('openid', $openid)->field('id,openid,mobile,senderid')->find();
            $this->success('success', $rs);
        }
    }

    /**
     * 更新会员个人信息
     *
     * @param string $avatar 头像地址
     * @param string $username 用户名
     * @param string $nickname 昵称
     * @param string $bio 个人简介
     * @return modal_user
     */
    public function updateUserInfo()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.id')) {
                $this->error('缺少参数用户id');
            }
            if (!input('?get.nickname')) {
                $this->error('缺少参数用户微信昵称');
            }
            if (!input('?get.image')) {
                $this->error('缺少参数用户头像链接');
            }
            if (!input('?get.gender')) {
                $this->error('缺少参数用户性别');
            }
        } else {
            if (!input('?post.id')) {
                $this->error('缺少参数用户id');
            }
            if (!input('?post.nickname')) {
                $this->error('缺少参数用户微信昵称');
            }
            if (!input('?post.image')) {
                $this->error('缺少参数用户头像链接');
            }
            if (!input('?post.gender')) {
                $this->error('缺少参数用户性别');
            }
        }
        $id = $this->request->param()['id'];
        $nickname = $this->request->param()['nickname'];
        $image = $this->request->param()['image'];
        $sex = $this->request->param()['gender'];
        $ip = $this->request->ip();
        $nickname = $this->filterEmoji($nickname);
        $modal = new modal_member();
        $data = ['id' => $id, 'nickname' => $nickname, 'sex' => $sex, 'image' => $image, 'createtime' => time(), 'login_ip' => $ip, 'lastlogintime' => time()];
        $rs = $modal->update($data);
        return $rs;
    }

    /**
     * 用户绑定手机号
     *
     * @param string $phone 手机号
     * @return modal_user
     */
    public function bindPhone()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.id')) {
                $this->error('缺少参数用户id');
            }
            if (!input('?get.sessionKey')) {
                $this->error('缺少参数sessionKey');
            }
            if (!input('?get.encryptedData')) {
                $this->error('缺少参数encryptedData');
            }
            if (!input('?get.iv')) {
                $this->error('缺少参数iv');
            }
        } else {
            if (!input('?post.id')) {
                $this->error('缺少参数用户id');
            }
            if (!input('?post.sessionKey')) {
                $this->error('缺少参数sessionKey');
            }
            if (!input('?post.encryptedData')) {
                $this->error('缺少参数encryptedData');
            }
            if (!input('?post.iv')) {
                $this->error('缺少参数iv');
            }
        }
        $id = $this->request->param()['id'];
        $sessionKey = $this->request->param()['sessionKey'];
        $encryptedData = $this->request->param()['encryptedData'];
        $iv = $this->request->param()['iv'];
        $rs = (new Wechatmini)->WXBizDataCrypt($sessionKey, $encryptedData, $iv);
        $phone = $rs['purePhoneNumber'];
        $ip = $this->request->ip();
        $modal = new modal_user();
        $data = ['id' => $id, 'phone' => $phone, 'login_ip' => $ip, 'lastlogintime' => time()];
        $rs = $modal->update($data);
        $this->success('绑定成功', $rs);
    }

    private function filterEmoji($str)
    {
        $str = preg_replace_callback('/./u',
            function (array $match) {
                return strlen($match[0]) >= 4 ? '' : $match[0];
            },
            $str);
        return $str;
    }

}