request = require 'browser-request'
ko = require 'knockout'

emailReg = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
vm =
  email: ko.observable ""
  adopter: ko.observable ""
  wifi: ko.observable ""
  location: ko.observable ""
  business: ko.observable ""
  submit: ->
    request.post {
      url: '/api/apply'
      body:
        email: vm.email()
        adopter: vm.adopter()
        wifi: vm.wifi()
        location: vm.location()
        business: vm.business()
      json: true
    }, (err, res, body) ->
  isEmailValid: ko.pureComputed ->
    emailReg.test vm.email()
  isAllValid: ko.pureComputed ->
    vm.isEmailValid() and vm.adopter() and vm.wifi() and vm.location()
  buttonStatus: ko.pureComputed ->
    if vm.isAllValid() then 'pure-button-primary' else "pure-button-disabled"

ko.applyBindings vm

# 初始化地图
map = new BMap.Map "map"
point = new BMap.Point 113.264435, 23.129163 # 广州市经纬度
map.centerAndZoom point, 12

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
createMarker = (point) ->
  mapPoint = new BMap.Point point.latitude, point.longitude
  mk = new BMap.Marker mapPoint
  map.addOverlay mk
  opts =
    width: 200
    height: 100
    title: point.owner + ' ' + point.name
    enableMessage: false
  infoWindow = new BMap.InfoWindow("这是属于" + point.owner + "的" + point.name, opts)
  mk.addEventListener 'click', ->
    map.openInfoWindow infoWindow, mapPoint

# 得到所有的标签
request '/api/wifis/', (err, res) ->
  wifis = JSON.parse res.response
  for wifi in wifis
    createMarker wifi

