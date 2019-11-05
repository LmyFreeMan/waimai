const app = getApp()
Page({
  data: {
    imgurl: app.globalData.imgurl,
    imgUrls: [
      '/images/banner.png',
    ],
    bannerList: {},
    mchList: {},
  },
  onLoad: function() {
    this.getBanner()
    this.getMch()
  },
  onShow: function() {
    var that = this;
    // 用户信息授权检测
    wx.getSetting({
      success(res) {
        if (!res.authSetting['scope.userInfo'] || !app.globalData.cache['weInfo']) {
          wx.switchTab({
            url: '/pages/my/my',
          })
        }
      }
    })
  },
  getBanner: function() {
    var that = this;
    wx.request({
      url: app.createUrl('banner', 'getbanner'),
      header: {
        'content-type': 'application/json'
      },
      data: {},
      method: app.globalData.is_dug ? 'GET' : 'POST',
      success: function(res) {
        var res = res.data
        if (res.code == 1 && res.data) {
          that.setData({
            bannerList: res.data
          })
        }
      },
      fail: function() {
        app.showToast('网络错误')
      },
    })
  },
  getMch: function() {
    var that = this;
    wx.request({
      url: app.createUrl('mch', 'getmch'),
      header: {
        'content-type': 'application/json'
      },
      data: {},
      method: app.globalData.is_dug ? 'GET' : 'POST',
      success: function(res) {
        var res = res.data
        if (res.code == 1 && res.data) {
          that.setData({
            mchList: res.data
          })
        } else {
          app.showToast(res.msg)
        }
      },
      fail: function() {
        app.showToast('网络错误')
      },
    })
  },
  toGood: function(e) {
    var data = JSON.stringify(e.currentTarget.dataset.data)
    wx.navigateTo({
      url: '/pages/goods/goods?data=' + data,
    })
  }
})