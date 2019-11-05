var app = getApp()
Page({
  data: {
    imgurl: app.globalData.imgurl,
    address: '',
    linkman: '',
    mobile: '',
    carArray: [],
    mch_name: '',
    send_price: 0,

  },
  onLoad: function(options) {
    var carArray = JSON.parse(options.carArray)
    var sum_price = 0;
    for (var i = 0; i < carArray.length; i++) {
      sum_price = Number(sum_price) + Number(carArray[i].totalprice)
    }
    this.setData({
      carArray: carArray,
      mch_name: options.mch_name,
      mch_id: options.mch_id,
      send_price: Number(options.send_price),
      sum_price: (Number(sum_price) + Number(options.send_price)).toFixed(2),
    })
  },
  onShow: function() {
    if (app.globalData.cache['address']) {
      this.setData({
        addressid: app.globalData.cache['address'].id,
        address: app.globalData.cache['address'].address,
        linkman: app.globalData.cache['address'].linkman,
        mobile: app.globalData.cache['address'].mobile,
      })
    }
  },
  selectAddress: function() {
    wx.navigateTo({
      url: '/pages/address/list',
    })
  },
  insertOrder: function() {
    var that = this;
    if (!that.data.addressid) {
      app.showToast('请选择地址');
      return;
    };
    var data = {
      userid: app.globalData.cache['weInfo'].id,
      mchid: that.data.mch_id,
      addressid: that.data.addressid,
      sendprice: that.data.send_price,
      totalprice: that.data.sum_price,
      order: JSON.stringify(that.data.carArray),
    }
    app.showLoadToast('订单生成中')
    wx.request({
      url: app.createUrl('order', 'add'),
      header: {
        'content-type': 'application/json'
      },
      data: data,
      method: app.globalData.is_dug ? 'GET' : 'POST',
      success: function(res) {
        var res = res.data
        if (res.code == 1 && res.data) {
          that.payOrder(res.data)
        } else {
          app.showToast(res.msg)
        }
      },
      fail: function() {
        app.showToast('网络错误')
      },
    })
  },

  payOrder: function(orderid) {
    var that = this;
    app.showLoadToast('订单生成中')
    wx.request({
      url: app.createUrl('order', 'wxpay'),
      header: {
        'content-type': 'application/json'
      },
      data: {
        orderid: orderid
      },
      method: app.globalData.is_dug ? 'GET' : 'POST',
      success: function(res) {
        var res = res.data
        if (res.code == 1 && res.data) {
          console.log(res.data)
          var prepay_id = res.data.package.replace(/prepay_id=/, "")
          //调用微信支付
          wx.requestPayment({
            'timeStamp': res.data.timeStamp,
            'nonceStr': res.data.nonceStr,
            'package': res.data.package,
            'signType': 'MD5',
            'paySign': res.data.paySign,
            'success': function(res) {
              if (res.errMsg == "requestPayment:ok") {
                that.updatePay(orderid, prepay_id);
              }
            },
            'fail': function(res) {
              if (res.errMsg == "requestPayment:fail cancel") {
                app.showToast('用户取消支付')
              } else {
                app.showToast(res.err_desc)
              }
            },
            'complete': function() {
              console.log("交易完成")
            }
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


  updatePay: function(orderid, formid) {
    var that = this;
    app.showLoadToast('订单支付中')
    wx.request({
      url: app.createUrl('order', 'updatePay'),
      header: {
        'content-type': 'application/json'
      },
      data: {
        orderid: orderid,
        formid: formid
      },
      method: app.globalData.is_dug ? 'GET' : 'POST',
      success: function(res) {
        var res = res.data
        if (res.code == 1 && res.data) {
          console.log(res.data)
          wx.hideToast()
          wx.navigateBack({})
        } else {
          app.showToast(res.msg)
        }
      },
      fail: function() {
        app.showToast('网络错误')
      },
    })
  },

})