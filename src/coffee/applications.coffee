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
  application.confirmApplication = ->
    console.log('hi')

  application.deleteApplication = ->
    console.log('hi')

