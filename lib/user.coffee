common = require './common'

asis = common.asis
as_array = common.as_array

methods =
  'GET /account':
    root: 'account'
    output: (xo) ->
      xo.openid_urls = as_array xo.openid_urls.openid_url
      xo

  'GET /api_version':
    root: 'version'
    output: asis

  'GET /appliances':
    root: 'appliances'
    output: (xo) ->
      xo = as_array xo.appliance
      for a in xo
        a.builds = as_array a.builds.build
      xo

  'GET /appliances/:app':
    root: 'appliance'
    output: (xo) ->
      xo.builds = as_array xo.builds.build
      xo

  'GET /appliances/:app/configuration':
    root: 'configuration'
    output: (xo) ->
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

  'GET /appliances/:app/gpg_keys':
    root: 'gpg_keys'
    output: (xo) ->
      as_array xo.gpg_key

  'GET /appliances/:app/gpg_key/:key':
    root: 'gpg_key'
    output: asis

  'GET /appliances/:app/sharing':
    root: 'appliance'
    output: (xo) ->
      xo.read_users = as_array xo.read_users.username
      xo

  'GET /appliances/:app/software':
    root: 'software'
    output: (xo) ->
      fix = (p) ->
        if p['#'] then { name: p['#'], version: p['@'].version }
        else { name: p }

      packages = (fix(p) for p in xo.package)
      packages.sort (l, r) ->
        l.name.localeCompare r.name
      xo.pattern.sort (l, r) ->
        l.localeCompare r

      {
        appliance_id: xo['@'].appliance_id
        patterns: xo.pattern
        packages: packages
      }

  'GET /appliances/:app/status':
    root: 'status'
    output: (xo) ->
      xo.issues = as_array xo.issues.issue
      xo

  'GET /builds':
    root: 'builds'
    output: (xo) ->
      xo = as_array xo.build
      xo

  'GET /builds/:bld':
    root: 'build'
    output: asis

  'GET /files':
    root: 'files'
    output: (xo) ->
      as_array xo.file

  'GET /files/:file':
    root: 'file'
    output: asis

  'GET /repositories':
    root: 'repositories'
    output: (xo) ->
      as_array xo.repository

  'GET /repositories/:repo':
    root: 'repository'
    output: asis

  'GET /rpms':
    root: 'rpms'
    output: (xo) ->
      xo.base_system = xo['@'].base_system
      delete xo['@']
      xo.rpms = as_array xo.rpm
      for r in xo.rpms
        r.base_system = xo.base_system
      delete xo.rpm
      xo

  'GET /rpms/:rpm':
    root: 'rpm'
    output: asis

  'GET /running_builds':
    root: 'running_builds'
    output: (xo) ->
      as_array xo.running_build

  'GET /running_builds/:bld':
    root: 'running_build'
    output: asis

  'POST /testdrives':
    root: 'testdrive'
    output: asis

  'GET /testdrives':
    root: 'testdrives'
    output: (xo) ->
      as_array xo.testdrive


exports.api = common.api methods
