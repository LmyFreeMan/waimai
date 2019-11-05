define(['jquery', 'bootstrap', 'backend', 'table', 'form'], function ($, undefined, Backend, Table, Form) {

    var Controller = {
        index: function () {
            // 初始化表格参数配置
            Table.api.init({
                extend: {
                    index_url: 'mch/index',
                    add_url: 'mch/add',
                    edit_url: 'mch/edit',
                    del_url: 'mch/del',
                    multi_url: 'mch/multi',
                    table: 'mch',
                }
            });

            var table = $("#table");

            // 初始化表格
            table.bootstrapTable({
                url: $.fn.bootstrapTable.defaults.extend.index_url,
                pk: 'id',
                sortName: 'id',
                columns: [
                    [
                        {checkbox: true},
                        {field: 'id', title: __('Id')},
                        {field: 'name', title: __('Name')},
                        {field: 'image', title: __('Image'), formatter: Table.api.formatter.image},
                        {field: 'request_price', title: __('Request_price'), operate:'BETWEEN'},
                        {field: 'send_price', title: __('Send_price'), operate:'BETWEEN'},
                        {field: 'desc', title: __('Desc')},
                        {field: 'licence_images', title: __('Licence_images'), formatter: Table.api.formatter.images},
                        {field: 'money', title: __('Money'), operate:'BETWEEN'},
                        {field: 'contact', title: __('Contact')},
                        {field: 'city', title: __('City')},
                        {field: 'addr', title: __('Addr')},
                        {field: 'usetime', title: __('Usetime')},
                        {field: 'lng', title: __('Lng')},
                        {field: 'lat', title: __('Lat')},
                        {field: 'createtime', title: __('Createtime'), operate:'RANGE', addclass:'datetimerange', formatter: Table.api.formatter.datetime},
                        {field: 'operate', title: __('Operate'), table: table, events: Table.api.events.operate, formatter: Table.api.formatter.operate}
                    ]
                ]
            });

            

            // 为表格绑定事件
            Table.api.bindevent(table);
        },
        add: function () {
            Controller.api.bindevent();
        },
        edit: function () {
            Controller.api.bindevent();
        },
        api: {
            bindevent: function () {
                Form.api.bindevent($("form[role=form]"));
            }
        }
    };
    return Controller;
});