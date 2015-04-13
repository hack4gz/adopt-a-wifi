request = require 'browser-request'
ko = require 'knockout'

vm =

request '/api/applications', (err, res) ->
  applications = JSON.parse res.response
  vm.applications = ko.observableArray applications
  for application in applications
    bindProperty application
  ko.applyBindings vm

bindProperty = (application) ->
  application.latitude = ko.observable ''
  application.longitude = ko.observable ''
  application.isValid = ko.pureComputed ->
    if @latitude() and @longitude() then true; else false
  , application
  application.confirmApplication = ->
    result = confirm('是否确定');
    if result
      request.post {
        url: '/api/wifis'
        body:
          adopter: @adopter
          name: @wifi
          latitude: @latitude()
          longitude: @longitude()
          business: @business
        json: true
      }, (err, res, body) =>
        request {
          method: 'DELETE'
          url: '/api/applications'
          body:
            id: @id
          json: true
        }, (err, res, body) =>
          unless err
            vm.applications.remove @
          else
            alert(err)

  application.deleteApplication = ->
    result = confirm('是否确定删除');
    if result
      request {
        method: 'DELETE'
        url: '/api/applications'
        body:
          id: @id
        json: true
      }, (err, res, body) =>
        unless err
          vm.applications.remove @
        else
          alert(err)
