fs = require 'fs'
xml = require './xml'
common = require './common'

asis = common.asis
as_array = common.as_array

roots =
  api_version: 'version'
  appliance_status: 'status'
  sharing: 'appliance'

methods =
  account: (xo) ->
    xo.openid_urls = as_array xo.openid_urls.openid_url
    xo

  api_version: asis

  appliance: (xo) ->
    xo.builds = as_array xo.builds.build
    xo

  appliance_status: (xo) ->
    xo.issues = as_array xo.issues.issue
    xo

  appliances: (xo) ->
    xo = as_array xo.appliance
    for a in xo
      a.builds = as_array a.builds.build
    xo

  build: asis

  builds: (xo) ->
    xo = as_array xo.build
    xo

  configuration: (xo) ->
    xo.tags = as_array xo.tags.tag
    xo.firewall.open_ports = as_array xo.firewall.open_port
    delete xo.firewall.open_port
    xo.users = as_array xo.users.user
    xo.eulas = as_array xo.eulas.eula
    xo.databases = as_array xo.databases.database
    for d in xo.databases
      d.users = as_array d.users.user
    xo.autostarts = as_array xo.autostarts.autostart
    if xo.settings.pae_enabled not instanceof String
      xo.settings.pae_enabled = 'false'
    xo.lvm.volumes = as_array xo.lvm.volumes.volume
    xo

  file: asis

  files: (xo) ->
    as_array xo.file

  gpg_key: asis

  gpg_keys: (xo) ->
    as_array xo.gpg_key

  repositories: (xo) ->
    as_array xo.repository

  repository: asis

  rpm: asis

  rpms: (xo) ->
    xo.base_system = xo['@'].base_system
    delete xo['@']
    xo.rpms = as_array xo.rpm
    for r in xo.rpms
      r.base_system = xo.base_system
    delete xo.rpm
    xo

  running_build: asis

  running_builds: (xo) ->
    as_array xo.running_build

  sharing: (xo) ->
    xo.read_users = as_array xo.read_users.username
    xo

  software: (xo) ->
    xo
  
  testdrive: asis

  testdrives: (xo) ->
    as_array xo.testdrive


exports.api = common.api 'user', methods, roots
