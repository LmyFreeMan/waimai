var app = getApp();
Page({
  data: {
    cb: '',
  },
  onLoad: function(e) {

  },

  onShow: function() {
    this.getAddress()
  },

  getAddress() {
    var that = this
    app.showLoadToast('数据获取中')
    wx.request({
      url: app.createUrl('address', 'get'),
      header: {
        'content-type': 'application/json'
      },
      data: {
        userid: app.globalData.cache['weInfo'].id,
      },
      method: app.globalData.is_dug ? 'GET' : 'POST',
      success: function(res) {
        var res = res.data
        if (res.code == 1 && res.data) {
          that.setData({
            list: res.data
          })
          wx.hideToast()
        } else {
          app.showToast(res.msg)
        }
      },
      fail: function() {
        app.showToast('网络错误')
      },
    })
  },

  onDelete(e) {
    var that = this
    wx.showModal({
      title: '提示',
      content: '是否删除地址' + e.currentTarget.dataset.address,
      confirmColor: '#0097fe',
      success: function(res) {
        if (res.confirm) {
          that.deleteAddress(e.currentTarget.id);
        }
      }
    })
  },

  deleteAddress(id) {
    var that = this
    app.showLoadToast('删除中')
    wx.request({
      url: app.createUrl('address', 'delete'),
      header: {
        'content-type': 'application/json'
      },
      data: {
        id: id,
        userid: app.globalData.cache['weInfo'].id,
      },
      method: app.globalData.is_dug ? 'GET' : 'POST',
      success: function(res) {
        var res = res.data
        if (res.code == 1 && res.data) {
          that.setData({
            list: res.data
          })
          wx.hideToast()
        } else {
          app.showToast(res.msg)
        }
      },
      fail: function() {
        app.showToast('网络错误')
      },
    })
  },
  onSelect: function(e) {
    app.saveCache('address', e.currentTarget.dataset.address);
    app.globalData.cache['address'] = e.currentTarget.dataset.address
    wx.navigateBack({})
  },
})