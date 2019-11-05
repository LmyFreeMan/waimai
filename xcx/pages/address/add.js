var app = getApp()
Page({
  data: {
    id: '',
    linkMan: '',
    mobile: '',
    address: '',
  },
  onLoad: function(e) {
    this.setData({
      id: e.id,
      linkMan: e.linkman,
      mobile: e.mobile,
      address: e.address,
    })
  },
  bindSave: function(e) {
    var that = this;
    var linkMan = e.detail.value.linkMan;
    var address = e.detail.value.address;
    var mobile = e.detail.value.mobile;
    if (linkMan == "") {
      app.showToast('请填写联系人姓名')
      return
    }
    if (mobile == "") {
      app.showToast('请填写手机号码')
      return
    }

    if (!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(mobile))) {
      app.showToast('错误的手机号码')
      return
    }

    if (address == "") {
      app.showToast('请填写详细地址')
      return
    }
    if (that.data.id) {
      app.showLoadToast('地址修改中')
      wx.request({
        url: app.createUrl('address', 'update'),
        header: {
          'content-type': 'application/json'
        },
        data: {
          id: that.data.id,
          userid: app.globalData.cache['weInfo'].id,
          linkman: linkMan,
          mobile: mobile,
          address: address
        },
        method: app.globalData.is_dug ? 'GET' : 'POST',
        success: function(res) {
          var res = res.data
          if (res.code == 1 && res.data) {
            wx.navigateBack({})
            wx.hideToast()
          } else {
            app.showToast(res.msg)
          }
        },
        fail: function() {
          app.showToast('网络错误')
        },
      })
    } else {
      app.showLoadToast('地址添加中')
      wx.request({
        url: app.createUrl('address', 'add'),
        header: {
          'content-type': 'application/json'
        },
        data: {
          userid: app.globalData.cache['weInfo'].id,
          linkman: linkMan,
          mobile: mobile,
          address: address
        },
        method: app.globalData.is_dug ? 'GET' : 'POST',
        success: function(res) {
          var res = res.data
          if (res.code == 1 && res.data) {
            wx.navigateBack({})
            wx.hideToast()
          } else {
            app.showToast(res.msg)
          }
        },
        fail: function() {
          app.showToast('网络错误')
        },
      })
    }
  },

  // 手机号正则
  // checkMobile: function() {
  //   var sMobile = document.mobileform.mobile.value
  //   if (!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(sMobile))) {
  //     alert("不是完整的11位手机号或者正确的手机号前七位");
  //     document.mobileform.mobile.focus();
  //     return false;
  //   }
  // },

})