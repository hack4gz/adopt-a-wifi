request = require 'browser-request'
ko = require 'knockout'

tudeReg = /^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/;

vm =

request '/api/wifis', (err, res) ->
  wifis = JSON.parse res.response
  vm.wifis = ko.observableArray wifis
  vm.currentFilter = ko.observable 0

  for wifi in wifis
    bindProperty wifi
  vm.filterWifis = ko.computed ->
    ko.utils.arrayFilter vm.wifis(), (wifi) ->
      wifi.passed_flag() == vm.currentFilter()
  vm.toggleFilter = ->
    vm.currentFilter(if vm.currentFilter() then 0 else 1)
  vm.currentStatus = ko.pureComputed ->
    if vm.currentFilter() then "查看未审核" else "查看已审核"

  ko.applyBindings vm

bindProperty = (wifi) ->
  wifi.name = ko.observable wifi.name
  wifi.latitude = ko.observable(if wifi.passed_flag then wifi.latitude else '')
  wifi.longitude = ko.observable(if wifi.passed_flag then wifi.longitude else '')
  wifi.isValid = ko.pureComputed ->
    if tudeReg.test(@longitude() + ', ' + @latitude()) and @name() then true else false
  , wifi
  wifi.passed_flag = ko.observable wifi.passed_flag
  wifi.status = ko.pureComputed ->
    if wifi.passed_flag() then "通过" else "待审核"
  wifi.updateWifi = ->
    result = confirm('是否确定');
    if result
      request {
        method: 'PUT'
        url: '/api/wifis'
        body:
          id: @id
          name: @name()
          passed_flag: 1
          latitude: @latitude()
          longitude: @longitude()
        json: true
      }, (err, res, body) =>
        if err
          alert(err)
        else
          @passed_flag(1)

  wifi.deleteWifi = ->
    result = confirm('是否确定删除');
    if result
      request {
        method: 'DELETE'
        url: '/api/wifis'
        body:
          id: @id
        json: true
      }, (err, res, body) =>
        unless err
          vm.wifis.remove @
        else
          alert(err)
