request = require 'browser-request'

map = new BMap.Map "map"
point = new BMap.Point 113.264435, 23.129163 # 广州市经纬度
map.centerAndZoom point, 12

geolocation = new BMap.Geolocation()
geolocation.getCurrentPosition ((r) ->
  if @getStatus() == BMAP_STATUS_SUCCESS
    map.panTo r.point
  else
    alert '失败' + @getStatus()
  return
), enableHighAccuracy: true

createMarker = (point) ->
  mapPoint = new BMap.Point point.latitude, point.longitude
  mk = new BMap.Marker mapPoint
  map.addOverlay mk
  mk.setAnimation BMAP_ANIMATION_BOUNCE
  opts =
    width: 200
    height: 100
    title: point.owner + ' ' + point.name
    enableMessage: false
  infoWindow = new BMap.InfoWindow("这是属于" + point.owner + "的" + point.name, opts)
  mk.addEventListener 'click', ->
    map.openInfoWindow infoWindow, mapPoint


request '/api/points/', (err, res) ->
  res = JSON.parse res.response
  for point in res
    createMarker point



