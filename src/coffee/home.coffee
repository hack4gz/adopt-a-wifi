request = require 'browser-request'
ko = require 'knockout'

emailReg = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
vm =
  email: ko.observable ""
  adopter: ko.observable ""
  wifi: ko.observable ""
  location: ko.observable ""
  business: ko.observable ""
  buttonContent: ko.observable '提交'
  submit: ->
    vm.buttonContent '正在提交...'
    request.post {
      url: '/api/applications'
      body:
        email: vm.email()
        adopter: vm.adopter()
        wifi: vm.wifi()
        location: vm.location()
        business: vm.business()
      json: true
    }, (err, res, body) ->
      vm.buttonContent '提交'
      if res.status is 200
        window.alert '提交成功, 我们将会在审核后为您标记，请耐心等候'
        vm.email ''
        vm.adopter ''
        vm.wifi ''
        vm.location ''
        vm.business ''
      else
        window.alert '服务器出现问题，请稍后再试'
  isEmailValid: ko.pureComputed ->
    emailReg.test vm.email()
  isAllValid: ko.pureComputed ->
    vm.isEmailValid() and vm.adopter() and vm.wifi() and vm.location()
  buttonStatus: ko.pureComputed ->
    if vm.isAllValid() then 'pure-button-primary' else "pure-button-disabled"

ko.applyBindings vm

# 初始化地图
map = new BMap.Map("map", enableMapClick: false)
map.centerAndZoom '广州', 12

# 添加平移和缩放按钮
topLeftControl = new BMap.ScaleControl(anchor: BMAP_ANCHOR_TOP_LEFT)
topLeftNavigation = new BMap.NavigationControl();
map.addControl(topLeftControl)
map.addControl(topLeftNavigation)

# 得到当前位置
geolocation = new BMap.Geolocation()
geolocation.getCurrentPosition ((r) ->
  if @getStatus() == BMAP_STATUS_SUCCESS
    map.centerAndZoom r.point, 15
  else
    alert '失败' + @getStatus()
  return
), enableHighAccuracy: true

# 创建标签
createMarker = (wifi) ->
  mapPoint = new BMap.Point wifi.latitude, wifi.longitude
  mk = new BMap.Marker mapPoint
  map.addOverlay mk
  mk.setAnimation BMAP_ANIMATION_DROP
  opts =
    width: 200
    height: 100
    title: wifi.adopter + ' ' + wifi.name
    enableMessage: false
  infoContent = if wifi.business then wifi.business else '这里是输入' + wifi.adopter + '的' + wifi.name
  infoWindow = new BMap.InfoWindow(infoContent, opts)
  mk.addEventListener 'click', ->
    map.openInfoWindow infoWindow, mapPoint

# 得到所有的标签
request '/api/wifis/', (err, res) ->
  wifis = JSON.parse res.response
  for wifi in wifis
    createMarker wifi

