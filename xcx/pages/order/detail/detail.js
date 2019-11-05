var app = getApp()
Page({
  data: {
    imgurl: app.globalData.imgurl,
    order_status: app.globalData.order_status,
    ordermsg: []
  },
  onLoad: function(options) {
    var data = JSON.parse(options.data)
    this.setData({
      data: data
    })
    var ordermsg = []
    switch (Number(data.status)) {
      case 0:
        ordermsg = [{
            status: '订单已取消',
            desc: data.desc,
            time: data.canceltime,
          },
          {
            status: '订单提交成功',
            desc: '',
            time: data.createtime,
          }
        ]
        break;
      case 1:
        ordermsg = [{
          status: '订单提交成功',
          desc: data.desc,
          time: data.createtime,
        }]
        break;
      case 2:
        ordermsg = [{
            status: '订单已支付',
            desc: data.desc,
            time: data.paytime,
          },
          {
            status: '订单提交成功',
            desc: '',
            time: data.createtime,
          }
        ]
        break;
      case 3:
        ordermsg = [{
            status: '订单已接单',
            desc: data.desc,
            time: data.gettime,
          }, {
            status: '订单已支付',
            desc: '',
            time: data.paytime,
          },
          {
            status: '订单提交成功',
            desc: '',
            time: data.createtime,
          }
        ]
        break;
      case 4:
        ordermsg = [{
          status: '订单配送中',
          desc: data.desc,
          time: data.sendtime,
        }, {
          status: '订单已接单',
          desc: '',
          time: data.gettime,
        }, {
          status: '订单已支付',
          desc: '',
          time: data.paytime,
        }, {
          status: '订单提交成功',
          desc: '',
          time: data.createtime,
        }]
        break;
      case 5:
        ordermsg = [{
          status: '订单已完成',
          desc: data.desc,
          time: data.finishtime,
        }, {
          status: '订单配送中',
          desc: '',
          time: data.sendtime,
        }, {
          status: '订单已接单',
          desc: '',
          time: data.gettime,
        }, {
          status: '订单已支付',
          desc: '',
          time: data.paytime,
        }, {
          status: '订单提交成功',
          desc: '',
          time: data.createtime,
        }]
        break;
    }
    this.setData({
      ordermsg: ordermsg,
    })
  },
  contact: function(e) {
    wx.makePhoneCall({
      phoneNumber: e.currentTarget.dataset.phone
    })
  },

  payOrder: function(e) {
    var orderid = e.currentTarget.dataset.orderid
    var that = this;
    app.showLoadToast('订单支付中')
    wx.request({
      url: app.createUrl('order', 'wxpay'),
      header: {
        'content-type': 'application/json'
      },
      data: {
        orderid: e.currentTarget.dataset.orderid
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

  finishOrder: function(e) {
    var that = this;
    app.showLoadToast('数据更新中')
    wx.request({
      url: app.createUrl('order', 'finishorder'),
      header: {
        'content-type': 'application/json'
      },
      data: {
        orderid: e.currentTarget.dataset.orderid,
      },
      method: app.globalData.is_dug ? 'GET' : 'POST',
      success: function(res) {
        var res = res.data
        if (res.code == 1 && res.data) {
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