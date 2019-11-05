<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/10/27 0027
 * Time: 2:10
 */

namespace app\api\controller;

use app\common\controller\Api;

class Sendmodalmsg extends Api
{
    protected $noNeedLogin = ['*'];
    protected $noNeedRight = ['*'];

    public function toGzh($touser, $template_id_p, $url, $sendArr)
    {
        $url_p = 'https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=' . $this->getAccessToken();
        $post_data_p = array(
            "touser" => "{$touser}",
            "template_id" => "{$template_id_p}",
            "url" => "{$url}",
            "data" => $sendArr);
        $post_data_p = json_encode($post_data_p);
        $timeout = 5;
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_URL, $url_p);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data_p);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout);
        curl_exec($ch);
        curl_close($ch);
    }

    public function getAccessToken()
    {
        //公众号配置，获取access_token
        $appid_p = 'wx318f281b245c0594';
        $appsecret_p = '341f019a9a49b4cccff77f5814b1601b';
        $token_url_p = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={$appid_p}&secret={$appsecret_p}";
        $access_token_p = '';
        $file_p = file_get_contents("https://api.jmideas.cn/access_token_p.json", true);
        $result_p = json_decode($file_p, true);
        if (time() > $result_p['expires']) {
            //进行access_token更新
            $data = array();
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $token_url_p);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            $out = curl_exec($ch);
            curl_close($ch);
            $data['access_token'] = json_decode($out, true)['access_token'];
            $data['expires'] = time() + 7000;
            $jsonStr = json_encode($data);
            $jsonStr_url = 'https://api.jmideas.cn/togzhtoken.php?jsonStr=' . $jsonStr;
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $jsonStr_url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_exec($ch);
            curl_close($ch);
            $this->success('success', $jsonStr);
            $access_token_p = $data['access_token'];
        } else {
            $access_token_p = $result_p['access_token'];
        }
        return $access_token_p;
    }
}
