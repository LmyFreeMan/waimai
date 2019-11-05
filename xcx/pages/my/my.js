var app = getApp();
Page({
  data: {
    showAuthorize: false,
    senderid: '',
  },
  onLoad: function(options) {},
  onShow: function() {
    var that = this;
    // 用户信息授权检测
    wx.getSetting({
      success(res) {
        if (!res.authSetting['scope.userInfo'] || !app.globalData.cache['weInfo']) {
          that.setData({
            showAuthorize: true
          })
        } else {
          that.setData({
            senderid: app.globalData.cache['weInfo'].senderid
          })
        }
      }
    })
  },

  getAuthorize: function(e) {
    var that = this;
    if (!e.detail.errMsg || e.detail.errMsg != "getUserInfo:ok") {
      app.showErrorModal('提示', '拒绝授权将不能正常使用')
      return;
    } else {
      app.showLoadToast('授权登陆中')
      app.getwxInfo().then(function(res) {
        console.log(res)
        //注册用户信息
        wx.request({
          url: app.createUrl('member', 'register'),
          header: {
            'content-type': 'application/json'
          },
          data: {
            openid: app.globalData.cache['openid'],
            nickname: res.nickName,
            image: res.avatarUrl,
            gender: res.gender
          },
          method: app.globalData.is_dug ? 'GET' : 'POST',
          success: function(res) {
            var res = res.data
            if (res.code == 1 && res.data) {
              app.saveCache('weInfo', res.data);
              that.setData({
                showAuthorize: false
              })
              wx.hideToast()
              that.onShow();
            } else {
              app.showToast(res.msg)
            }
          },
          fail: function() {
            app.showToast('网络错误')
          },
        })
      })
    }
  },
  clear: function() {
    var that = this
    wx.clearStorage({
      success: function() {
        app.showToast('清除成功')
        that.setData({
          showAuthorize: true
        })
      }
    })
  }
})