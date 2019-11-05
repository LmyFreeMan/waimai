const app = getApp()
Page({
  data: {
    imgurl: app.globalData.imgurl,
    goods: [],
    toView: '',
    scrollTop: 100,
    foodCounts: 0,
    totalPrice: 0, // 总价格
    totalCount: 0, // 总商品数
    carArray: [],
    minPrice: 0, //起送价格
    payDesc: '',
    deliveryPrice: 0, //配送費
    fold: true,
    selectFoods: [],
    cartShow: 'none',
    status: 0,
  },

  onLoad: function(options) {
    var mch = JSON.parse(options.data)
    this.getMchGoods(mch.id);
    this.setData({
      mch: mch,
      minPrice: Number(mch.request_price),
      deliveryPrice: Number(mch.send_price),
      payDesc: this.payDesc(mch.request_price)
    });
  },

  selectMenu: function(e) {
    var index = e.currentTarget.dataset.itemIndex;
    this.setData({
      toView: 'order' + index.toString(),
      selectidx: index.toString(),
    })
  },


  //移除商品
  decreaseShopCart: function(e) {
    this.decreaseCart(e);
  },
  decreaseCart: function(e) {
    var index = e.currentTarget.dataset.itemIndex;
    var parentIndex = e.currentTarget.dataset.parentindex;
    this.data.goods[parentIndex].foods[index].Count--;
    var num = this.data.goods[parentIndex].foods[index].Count;
    var mark = 'a' + index + 'b' + parentIndex
    var price = this.data.goods[parentIndex].foods[index].price;
    var name = this.data.goods[parentIndex].foods[index].name;
    var image = this.data.goods[parentIndex].foods[index].image;
    var totalprice = (this.data.goods[parentIndex].foods[index].price * this.data.goods[parentIndex].foods[index].Count).toFixed(2);
    var obj = {
      price: price,
      num: num,
      mark: mark,
      name: name,
      image: image,
      index: index,
      parentIndex: parentIndex,
      totalprice: totalprice
    };
    var carArray1 = this.data.carArray.filter(item => item.mark != mark);
    if (e.currentTarget.dataset.idx) {
      carArray1[e.currentTarget.dataset.idx] = obj
    } else {
      carArray1.push(obj)
    }
    for (var i = 0; i < carArray1.length; i++) {
      if (carArray1[i].num == 0) {
        carArray1.splice(i, 1)
      }
    }
    this.setData({
      carArray: carArray1,
      goods: this.data.goods
    })
    this.calTotalPrice()
    this.setData({
      payDesc: this.payDesc(),
    })
    //关闭弹起
    var count1 = 0
    for (let i = 0; i < carArray1.length; i++) {
      if (carArray1[i].num == 0) {
        count1++;
      }
    }
    if (count1 == carArray1.length) {
      if (num == 0) {
        this.setData({
          cartShow: 'none'
        })
      }
    }
  },


  //添加到购物车
  addShopCart: function(e) {
    this.addCart(e);
  },
  addCart: function(e) {
    var index = e.currentTarget.dataset.itemIndex;
    var parentIndex = e.currentTarget.dataset.parentindex;
    if (!this.data.goods[parentIndex].foods[index].Count) {
      this.data.goods[parentIndex].foods[index].Count = 0
    }
    this.data.goods[parentIndex].foods[index].Count++;
    var mark = 'a' + index + 'b' + parentIndex
    var price = this.data.goods[parentIndex].foods[index].price;
    var num = this.data.goods[parentIndex].foods[index].Count;
    var name = this.data.goods[parentIndex].foods[index].name;
    var image = this.data.goods[parentIndex].foods[index].image;
    var totalprice = (this.data.goods[parentIndex].foods[index].price * this.data.goods[parentIndex].foods[index].Count).toFixed(2);
    var obj = {
      price: price,
      num: num,
      mark: mark,
      name: name,
      image: image,
      index: index,
      parentIndex: parentIndex,
      totalprice: totalprice
    };
    var carArray1 = this.data.carArray.filter(item => item.mark != mark)
    if (e.currentTarget.dataset.idx) {
      carArray1[e.currentTarget.dataset.idx] = obj
    } else {
      carArray1.push(obj)
    }
    this.setData({
      carArray: carArray1,
      goods: this.data.goods
    })
    this.calTotalPrice();
    this.setData({
      payDesc: this.payDesc()
    })
  },

  //计算总价
  calTotalPrice: function() {
    var carArray = this.data.carArray;
    var totalPrice = 0;
    var totalCount = 0;
    for (var i = 0; i < carArray.length; i++) {
      totalPrice += carArray[i].price * carArray[i].num;
      totalCount += carArray[i].num
    }
    this.setData({
      totalPrice: totalPrice.toFixed(2),
      totalCount: totalCount,
    });
  },


  //差几元起送
  payDesc: function(request_price) {
    if (request_price) {
      return `￥${request_price}元起送`;
    } else if (this.data.totalPrice === 0) {
      return `￥${this.data.minPrice}元起送`;
    } else if (this.data.totalPrice < this.data.minPrice) {
      let diff = this.data.minPrice - this.data.totalPrice;
      return '还差' + diff.toFixed(2) + '元起送';
    } else {
      return '去结算';
    }
  },

  //结算
  pay: function() {
    if (this.data.totalPrice < this.data.minPrice) {
      return;
    }
    //确认支付逻辑
    // var resultType = "success";
    var carArray = JSON.stringify(this.data.carArray)
    wx.navigateTo({
      url: '/pages/pay/pay?carArray=' + carArray + '&mch_id=' + this.data.mch.id + '&mch_name=' + this.data.mch.name + '&send_price=' + this.data.mch.send_price
    })
  },

  //弹起购物车
  toggleList: function() {
    if (!this.data.totalCount) {
      return;
    }
    this.setData({
      fold: !this.data.fold,
    })
    var fold = this.data.fold
    //console.log(this.data.fold);
    this.cartShow(fold)
  },
  // ????
  cartShow: function(fold) {
    if (fold == false) {
      this.setData({
        cartShow: 'block',
      })
    } else {
      this.setData({
        cartShow: 'none',
      })
    }
  },

  // 切换tap
  tabChange: function(e) {
    var showtype = e.target.dataset.type;
    if (showtype == 2) {
      this.getMchDetail()
    }
    this.setData({
      status: showtype,
    });
  },

  //清空购物车
  empty: function() {
    this.getMchGoods(this.data.mch.id);
    this.setData({
      foodCounts: 0,
      totalPrice: 0,
      totalCount: 0,
      carArray: [],
      fold: true,
      selectFoods: [],
      cartShow: 'none',
      payDesc: this.payDesc(this.data.minPrice),
    })
  },
  // 拨打电话
  call: function() {
    wx.makePhoneCall({
      phoneNumber: this.data.mch.contact
    })
  },
  // 获取商家信息
  getMchDetail: function() {
    var that = this;
    wx.request({
      url: app.createUrl('mch', 'getmchdetail'),
      header: {
        'content-type': 'application/json'
      },
      data: {
        mchid: that.data.mch.id
      },
      method: app.globalData.is_dug ? 'GET' : 'POST',
      success: function(res) {
        var res = res.data
        console.log(res)
        if (res.code == 1 && res.data) {
          that.setData({
            'mch.licence_images': res.data.licence_images,
            'mch.city': res.data.city,
            'mch.addr': res.data.addr,
          })
        }
      },
      fail: function() {
        app.showToast('网络错误')
      },
    })
  },
  // 获取商家店铺商品
  getMchGoods: function(mchid) {
    var that = this;
    wx.request({
      url: app.createUrl('goods', 'getmchgoods'),
      header: {
        'content-type': 'application/json'
      },
      data: {
        mchid: mchid
      },
      method: app.globalData.is_dug ? 'GET' : 'POST',
      success: function(res) {
        var res = res.data
        if (res.code == 1 && res.data) {
          that.setData({
            goods: res.data
          })
        } else {
          app.showToast(res.msg)
        }
      },
      fail: function() {
        app.showToast('网络错误')
      },
    })
  }
})