<?php
/**
 * Created by PhpStorm.
 * User: JamesLiu
 * Date: 2018/8/23
 * Time: 15:27
 * Email: JamesLiu_storm@foxmail.com
 */

namespace app\api\controller;


use app\common\controller\Api;
use think\Config;
use think\Db;

class Wechatmini extends Api
{
    // 无需登录的接口,*表示全部
    protected $noNeedLogin = ['*'];
    // 无需鉴权的接口,*表示全部
    protected $noNeedRight = ['*'];
    protected $request_type = 'post';

    protected $appid = '';
    protected $appsecret = '';
    protected $mch_id = '';
    protected $mch_key = '';


    protected $openid;            //openid
    protected $out_trade_no;      //商户订单号
    protected $body;              //商品描述
    protected $total_fee;         //总金额


    public function _initialize()
    {
        $this->request_type = config('request');
        $this->appid = config('appid');
        $this->appsecret = config('appsecret');
        $this->mch_id = config('mch_id');
        $this->mch_key = config('mch_key');
    }

    /**
     * 获取openid
     *
     * @ApiTitle    (获取openid)
     * @ApiSummary  (根据code获取openid)
     */

    public function getOpenid()
    {
        if ($this->request_type == 'get') {
            if (!input('?get.code')) {
                $this->error('缺少参数code');
            }
        } else {
            if (!input('?post.code')) {
                $this->error('缺少参数code');
            }
        }
        $code = $this->request->param()['code'];
        $url = "https://api.weixin.qq.com/sns/jscode2session?appid={$this->appid}&secret={$this->appsecret}&js_code=$code&grant_type=authorization_code";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        $out = curl_exec($ch);
        curl_close($ch);
        $jsondecode = json_decode($out, true); //对JSON格式的字符串进行编码
        $this->success('success', $jsondecode);
    }


    /**
     * 微信小程序数据解密
     * @desc 小程序可以通过各种前端接口获取微信提供的开放数据。 考虑到开发者服务器也需要获取这些开放数据，微信会对这些数据做签名和加密处理。 开发者后台拿到开放数据后可以对数据进行校验签名和解密，来保证数据不被篡改。
     * @return array
     * @return int ret 状态码：200表示数据获取成功,其他错误码可参考小程序错误码说明
     * @return array data 返回解密后的数据
     * @return string msg 错误提示信息
     */
    public function WXBizDataCrypt($sessionKey, $encryptedData, $iv)
    {
        if (!$encryptedData) {
            $this->error('待解密数据不允许为空');
        }
        if (!$iv) {
            $this->error('加密算法的初始向量不允许为空');
        }
        if (strlen($sessionKey) != 24) {
            $this->error('IllegalAesKey');
        }
        $aesKey = base64_decode($sessionKey);
        if (strlen($iv) != 24) {
            $this->error('IllegalIv');
        }
        $aesIV = base64_decode($iv);
        $aesCipher = base64_decode($encryptedData);
        $result = openssl_decrypt($aesCipher, "AES-128-CBC", $aesKey, 1, $aesIV);
        $dataObj = json_decode($result, true);
        if ($dataObj == NULL) {
            $this->error('IllegalBuffer');
        }
        if ($dataObj['watermark']['appid'] != $this->appid) {
            $this->error('IllegalBuffer');
        }
        return $dataObj;
    }

    public function WxPay($openid, $total_fee, $body, $out_trade_no)
    {
        if (!$this->mch_id) {
            $this->error('请配置商户号');
        }
        if (!$this->mch_key) {
            $this->error('请配置支付秘钥');
        }
        if (!$openid) {
            $this->error('openid不能为空');
        }
        if ($total_fee < 0.01) {
            $total_fee = '0.01';
//            $this->error('付款金额最低0.01');
        }
        if (!$total_fee) {
            $this->error('付款金额不能为空');
        }
        if (!$body) {
            $body = '商品充值';
        }
        $this->out_trade_no = $out_trade_no;
        $this->openid = $openid;
        $this->body = $body;
        $this->total_fee = $total_fee;
//        统一下单接口
        $res = $this->weixinapp();
        return $res;
    }


    /**
     * 获取小程序码
     * @desc 通过该接口生成的小程序码，永久有效，数量暂无限制。用户扫描该码进入小程序后，开发者需在对应页面获取的码中 scene 字段的值，再做处理逻辑。使用如下代码可以获取到二维码中的 scene 字段的值。调试阶段可以使用开发工具的条件编译自定义参数 scene=xxxx 进行模拟，开发工具模拟时的 scene 的参数值需要进行 urlencode
     * @return void
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\Exception
     */
    public function getWxa()
    {
        $page = '';
        if ($this->request_type == 'get') {
            if (!input('?get.scene')) {
                $this->error('缺少参数scene');
            }
            if (input('?get.page')) {
                $page = $this->request->param()['page'];
            }
        } else {
            if (!input('?post.scene')) {
                $this->error('缺少参数code');
            }
            if (input('?get.page')) {
                $page = $this->request->param()['page'];
            }
        }
        header('content-type:image/jpeg');
        $scene = $this->request->param()['scene'];
        $post_data = array(
            "scene" => $scene,
            "page" => $page
        );
        $access_token = $this->getAccessToken()['access_token'];
        $wxa_url = "https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token=" . $access_token;
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_HEADER, 0);
        curl_setopt($ch, CURLOPT_URL, $wxa_url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($post_data));
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
        $rs = curl_exec($ch);
        curl_close($ch);
        print_r($rs);
    }


    /**
     * 获取access_token
     * @desc 获取access_token，由于微信对access_token获取次数有限制，此方法将token存服务器，需要时直接取服务器token，过期自动更新token
     * @return array|false|\PDOStatement|string|\think\Model
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\Exception
     */
    public function getAccessToken()
    {
        $token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid={$this->appid}&secret={$this->appsecret}";
        $result = Db::name('access_token')->find();
        if (($result == null) || (time() > $result['expires'])) {
            $contions = $result['expires'];
            //进行access_token更新
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $token_url);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            $out = curl_exec($ch);
            curl_close($ch);
            $jsondecode = json_decode($out, true);
            if ($jsondecode['access_token']) {
                $result['access_token'] = $jsondecode['access_token'];
                $result['expires'] = time() + 7000;
                Db::name('access_token')->where('expires', $contions)->update(['access_token' => $result['access_token'], 'expires' => $result['expires']]);
            } else {
                $this->error($jsondecode['errmsg']);
            }
        }
        return $result;
    }

    //统一下单接口
    private function unifiedorder()
    {
        $url = 'https://api.mch.weixin.qq.com/pay/unifiedorder';
        $parameters = array(
            'appid' => $this->appid, //小程序ID
            'mch_id' => $this->mch_id, //商户号
            'nonce_str' => $this->createNoncestr(), //随机字符串
            'body' => $this->body,//商品描述
            'out_trade_no' => $this->out_trade_no,//商户订单号
            'total_fee' => floatval($this->total_fee * 100),//总金额 单位 分
            'spbill_create_ip' => $_SERVER['REMOTE_ADDR'], //终端IP
            'notify_url' => 'http://www.weixin.qq.com/wxpay/pay.php', //通知地址  确保外网能正常访问
            'openid' => $this->openid, //用户id
            'trade_type' => 'JSAPI'//交易类型
        );
        //统一下单签名
        $parameters['sign'] = $this->getSign($parameters);
        $xmlData = $this->arrayToXml($parameters);
        $xml = $this->postXmlCurl($xmlData, $url, 60);
        $return = $this->xmlToArray($xml);
        if ($return['return_code'] == 'FAIL') {
            $this->error($return['return_msg']);
        }
        return $return;
    }

    private static function postXmlCurl($xml, $url, $second = 30)
    {
        $ch = curl_init();
        //设置超时
        curl_setopt($ch, CURLOPT_TIMEOUT, $second);
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, FALSE); //严格校验
        //设置header
        curl_setopt($ch, CURLOPT_HEADER, FALSE);
        //要求结果为字符串且输出到屏幕上
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, TRUE);
        //post提交方式
        curl_setopt($ch, CURLOPT_POST, TRUE);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $xml);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 20);
        curl_setopt($ch, CURLOPT_TIMEOUT, 40);
        set_time_limit(0);
        //运行curl
        $data = curl_exec($ch);
        //返回结果
        if ($data) {
            curl_close($ch);
            return $data;
        } else {
            $error = curl_errno($ch);
            curl_close($ch);
        }
    }

    //数组转换成xml
    private function arrayToXml($arr)
    {
        $xml = "<root>";
        foreach ($arr as $key => $val) {
            if (is_array($val)) {
                $xml .= "<" . $key . ">" . $this->arrayToXml($val) . "</" . $key . ">";
            } else {
                $xml .= "<" . $key . ">" . $val . "</" . $key . ">";
            }
        }
        $xml .= "</root>";
        return $xml;
    }

    //xml转换成数组
    private function xmlToArray($xml)
    {
        //禁止引用外部xml实体
        libxml_disable_entity_loader(true);
        $xmlstring = simplexml_load_string($xml, 'SimpleXMLElement', LIBXML_NOCDATA);
        $val = json_decode(json_encode($xmlstring), true);
        return $val;
    }

    //微信小程序接口
    private function weixinapp()
    {
        //统一下单接口
        $unifiedorder = $this->unifiedorder();
        $parameters = array(
            'appId' => $this->appid, //小程序ID
            'timeStamp' => '' . time() . '', //时间戳
            'nonceStr' => $this->createNoncestr(), //随机串
            'package' => 'prepay_id=' . $unifiedorder['prepay_id'], //数据包
            'signType' => 'MD5'//签名方式
        );
        //签名
        $parameters['paySign'] = $this->getSign($parameters);
        return $parameters;
    }

    //作用：产生随机字符串，不长于32位
    private function createNoncestr($length = 32)
    {
        $chars = "abcdefghijklmnopqrstuvwxyz0123456789";
        $str = "";
        for ($i = 0; $i < $length; $i++) {
            $str .= substr($chars, mt_rand(0, strlen($chars) - 1), 1);
        }
        return $str;
    }

    //作用：生成签名
    private function getSign($Obj)
    {
        foreach ($Obj as $k => $v) {
            $Parameters[$k] = $v;
        }
        //签名步骤一：按字典序排序参数
        ksort($Parameters);
        $String = $this->formatBizQueryParaMap($Parameters, false);
        //签名步骤二：在string后加入KEY
        $String = $String . "&key=" . $this->mch_key;
        //签名步骤三：MD5加密
        $String = md5($String);
        //签名步骤四：所有字符转为大写
        $result_ = strtoupper($String);
        return $result_;
    }

    ///作用：格式化参数，签名过程需要使用
    private function formatBizQueryParaMap($paraMap, $urlencode)
    {
        $buff = "";
        ksort($paraMap);
        foreach ($paraMap as $k => $v) {
            if ($urlencode) {
                $v = urlencode($v);
            }
            $buff .= $k . "=" . $v . "&";
        }
        if (strlen($buff) > 0) {
            $reqPar = substr($buff, 0, strlen($buff) - 1);
        }
        return $reqPar;
    }
}