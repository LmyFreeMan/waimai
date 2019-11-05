var app = getApp()
Page({
  data: {
    imgurl: app.globalData.imgurl,
    isHideLoadMore: false,
    page: 1,
    list: [],
    nomore: false,
    order_status: app.globalData.order_status,
    tabid: 4,
  },

  onLoad: function() {
    if (!app.globalData.cache['weInfo'].senderid) {
      wx.navigateBack({})
    }
  },
  onShow: function() {
    var that = this;
    that.setData({
      list: [],
      nomore: false,
      page: 1,
    })
    this.getOrder(that.data.tabid, 1)
  },
  onPullDownRefresh: function() {
    wx.showNavigationBarLoading() //在标题栏中显示加载
    this.setData({
      list: [],
      nomore: false,
      page: 1,
    })
    this.getOrder(this.data.tabid, 1)
  },
  onReachBottom: function() {
    if (this.data.nomore) {
      app.showToast('没有更多了！')
      return false;
    }
    var page = this.data.page + 1
    this.setData({
      isHideLoadMore: true,
      page: page
    })
    this.getOrder(this.data.tabid, page)
  },


  getOrder: function(status, page) {
    var that = this;
    app.showLoadToast('数据获取中')
    wx.request({
      url: app.createUrl('order', 'getforsender'),
      header: {
        'content-type': 'application/json'
      },
      data: {
        senderid: app.globalData.cache['weInfo'].senderid,
        status: status,
        page: page,
      },
      method: app.globalData.is_dug ? 'GET' : 'POST',
      success: function(res) {
        var res = res.data
        var list = that.data.list
        if (res.code == 1 && res.data) {
          if (res.data.length > 0) {
            for (var i = 0; i < res.data.length; i++) {
              res.data[i].order = JSON.parse(res.data[i].order)
            }
            that.setData({
              list: list.concat(res.data),
            })
            wx.hideToast()
          } else {
            that.setData({
              nomore: true,
            })
            app.showToast('没有更多了！')
          }
        } else {
          app.showToast(res.msg)
        }
      },
      fail: function() {
        app.showToast('网络错误')
      },
      complete: function() {
        wx.hideNavigationBarLoading() //完成停止加载
        wx.stopPullDownRefresh() //停止下拉刷新
        that.setData({
          isHideLoadMore: false
        })
      }
    })
  },
  toDetail: function(e) {
    wx.navigateTo({
      url: '/pages/sender/detail/detail?data=' + JSON.stringify(e.currentTarget.dataset.data),
    })
  },


  switchTap: function(e) {
    if (e.currentTarget.id != this.data.tabid) {
      this.setData({
        tabid: e.currentTarget.id
      })
      wx.showNavigationBarLoading() //在标题栏中显示加载
      this.setData({
        list: [],
        nomore: false,
        page: 1,
      })
      this.getOrder(e.currentTarget.id, 1)
    }
  }
})