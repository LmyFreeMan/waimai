<?php

namespace app\admin\controller;

use app\admin\model\Order as modal_order;
use app\admin\model\Mch as modal_mch;
use app\common\controller\Backend;
use think\Config;

/**
 * 控制台
 *
 * @icon fa fa-dashboard
 * @remark 用于展示当前系统中的统计数据、统计报表及重要实时数据
 */
class Dashboard extends Backend
{

    /**
     * 查看
     */
    public function index()
    {
        $seventtime = \fast\Date::unixtime('day', -7);
        $paylist = $createlist = [];
        for ($i = 0; $i < 7; $i++) {
            $day = date("Y-m-d", $seventtime + ($i * 86400));
            $createlist[$day] = mt_rand(20, 200);
            $paylist[$day] = mt_rand(1, mt_rand(1, $createlist[$day]));
        }
        $hooks = config('addons.hooks');
        $uploadmode = isset($hooks['upload_config_init']) && $hooks['upload_config_init'] ? implode(',', $hooks['upload_config_init']) : 'local';
        $addonComposerCfg = ROOT_PATH . '/vendor/karsonzhang/fastadmin-addons/composer.json';
        Config::parse($addonComposerCfg, "json", "composer");
        $config = Config::get("composer");
        $addonVersion = isset($config['version']) ? $config['version'] : __('Unknown');
        $range = $this->getRange();
        $where['day'] = $range['day_b'] . ',' . $range['day_e'];
//        $where['week'] = $range['week_b'] . ',' . $range['week_e'];
//        $where['month'] = $range['month_b'] . ',' . $range['month_e'];
//        $where['year'] = $range['year_b'] . ',' . $range['year_e'];
        $modal_order = new modal_order();
        $modal_mch = new modal_mch();
        if ($this->auth->isSuperAdmin()) {
//            今日订单数
            $today_all = $modal_order->where('createtime', 'between', $where['day'])->count('id');
//            今日收益
            $today_money = $modal_order->where('createtime', 'between', $where['day'])->where('status', '>', 3)->sum('totalprice');
//            总订单数
            $all = $modal_order->count('id');
//            账户余额
            $balance = $modal_mch->sum('money');
//            今日待支付
            $today_dzf = $modal_order->where('status', '1')->where('createtime', 'between', $where['day'])->count('id');
//            今日配送中
            $today_psz = $modal_order->where('status', '4')->where('createtime', 'between', $where['day'])->count('id');
//            今日已完成
            $today_ywc = $modal_order->where('status', '5')->where('createtime', 'between', $where['day'])->count('id');
//            总待支付
            $dzf = $modal_order->where('status', '1')->count('id');
//            总配送中
            $psz = $modal_order->where('status', '4')->count('id');
//            总已完成
            $ywc = $modal_order->where('status', '5')->count('id');
        } else {
            $day = [];
            $userid = $this->auth->username;
//            今日订单数
            $today_all = $modal_order->where('mchid', $userid)->where('createtime', 'between', $where['day'])->count('id');
//            今日收益
            $today_money = $modal_order->where('mchid', $userid)->where('createtime', 'between', $where['day'])->where('status', '>', 3)->sum('totalprice');
//            总订单数
            $all = $modal_order->where('mchid', $userid)->count('id');
//            账户余额
            $balance = $modal_mch->where('id', $userid)->sum('money');
//            今日待支付
            $today_dzf = $modal_order->where('mchid', $userid)->where('status', '1')->where('createtime', 'between', $where['day'])->count('id');
//            今日配送中
            $today_psz = $modal_order->where('mchid', $userid)->where('status', '4')->where('createtime', 'between', $where['day'])->count('id');
//            今日已完成
            $today_ywc = $modal_order->where('mchid', $userid)->where('status', '5')->where('createtime', 'between', $where['day'])->count('id');
//            总待支付
            $dzf = $modal_order->where('mchid', $userid)->where('status', '1')->count('id');
//            总配送中
            $psz = $modal_order->where('mchid', $userid)->where('status', '4')->count('id');
//            总已完成
            $ywc = $modal_order->where('mchid', $userid)->where('status', '5')->count('id');
        }
        $this->view->assign([
            'totalall' => $today_all,
            'totalmoney' => $today_money,
            'all' => $all,
            'balance' => $balance,
            'todaydzf' => $today_dzf,
            'todaypsz' => $today_psz,
            'todayywc' => $today_ywc,
            'dzf' => $dzf,
            'psz' => $psz,
            'ywc' => $ywc,
            'paylist' => $paylist,
            'createlist' => $createlist,
            'addonversion' => $addonVersion,
            'uploadmode' => $uploadmode,
            'superadmin' => $this->auth->isSuperAdmin()
        ]);
        return $this->view->fetch();
    }

    private function getRange()
    {
        $now = time();
//        $time = strtotime('-6 day', $now);
        $range['day_b'] = strtotime(date('Y-m-d 00:00:00', $now));
        $range['day_e'] = strtotime(date('Y-m-d 23:59:59', $now));
//        $range['week_b'] = strtotime(date(date('Y-m-d 00:00:00', $time)));
//        $range['week_e'] = strtotime(date(date('Y-m-d 23:59:59', $now)));
//        $range['month_b'] = strtotime(date(date('Y-m-d 00:00:00', mktime(0, 0, 0, date('m', $now), '1', date('Y', $now)))));
//        $range['month_e'] = strtotime(date(date('Y-m-d 23:39:59', mktime(0, 0, 0, date('m', $now), date('t', $now), date('Y', $now)))));
//        $range['year_b'] = strtotime(date(date('Y-m-d 00:00:00', mktime(0, 0, 0, 1, 1, date('Y', $now)))));
//        $range['year_e'] = strtotime(date(date('Y-m-d 23:39:59', mktime(0, 0, 0, 12, 31, date('Y', $now)))));
        return $range;
    }
}
