//app.js
App({
  onLaunch: function() {
    this.getCache();
    this.getOpenid();
  },
  getOpenid: function() {
    var that = this
    wx.login({
      success: function(res) {
        if (res.code) {
          // 换取openid
          wx.request({
            url: that.createUrl('wechatmini', 'getopenid'),
            header: {
              'content-type': 'application/json'
            },
            data: {
              code: res.code
            },
            method: that.globalData.is_dug ? 'GET' : 'POST',
            success: function(res) {
              var res = res.data
              if (res.code == 1 && res.data.openid) {
                that.saveCache('openid', res.data.openid);
                that.globalData.session_key = res.data.session_key;
              } else {
                that.showToast(res.msg)
              }
            },
            fail: function() {
              that.showToast('网络错误')
            },
          })
        }
      }
    })
  },

  getwxInfo: function() {
    var that = this;
    return new Promise(function(resolve, reject) {
      wx.getSetting({
        success: res => {
          if (res.authSetting['scope.userInfo']) {
            wx.getUserInfo({
              success: function(res) {
                var wxInfo = res.userInfo
                resolve(wxInfo);
                // that.saveCache('wxInfo', wxInfo);
                // if (wxInfo.nickName != weInfo.nickname || wxInfo.avatarUrl != weInfo.image) {
                // that.updateUserinfo(weInfo.id, wxInfo.nickName, wxInfo.avatarUrl, wxInfo.gender)
                // }
              }
            })
          }
        }
      })
    })
  },

  getCache: function() {
    var that = this;
    try {
      var data = wx.getStorageInfoSync();
      if (data && data.keys.length) {
        data.keys.forEach(function(key) {
          var value = wx.getStorageSync(key);
          if (value) {
            that.globalData.cache[key] = value;
          }
        });
      }
    } catch (e) {
      console.warn('获取缓存失败');
    }
  },

  //保存缓存
  saveCache: function(key, value) {
    var that = this;
    if (!key || !value) {
      return;
    }
    that.globalData.cache[key] = value;
    wx.setStorage({
      key: key,
      data: value
    });
  },


  // 显示消息提示框
  showToast: function(title, icon, duration) {
    wx.showToast({
      title: title || '网络错误',
      icon: icon || 'none',
      duration: duration || 1000
    })
  },

  //错误提示弹窗
  showErrorModal: function(title, content) {
    wx.showModal({
      title: title || '提示',
      content: content || '未知错误',
      showCancel: false,
      confirmColor: "#0097fe",
    });
  },

  //加载提示弹窗
  showLoadToast: function(title, duration) {
    wx.showToast({
      title: title || '加载中',
      icon: 'loading',
      mask: true,
      duration: duration || 15000
    });
  },
  createUrl: function(c, a) {
    return this.globalData._server + c + '/' + a
  },
  globalData: {
    _server: 'https://chat.jmideas.cn/api/',
    imgurl: "https://chat.jmideas.cn",
    is_dug: true,
    session_key: '',
    cache: [],
    order_status: [
      '订单已取消',
      '待支付',
      '待接单',
      '待配送',
      '订单配送中',
      '订单已完成',
    ]
  }
})