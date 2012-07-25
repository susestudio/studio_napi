common = require './common'

asis = common.asis
as_array = common.as_array

roots =
  'GET /account': 'account'
  'GET /api_version': 'version'
  'GET /appliances': 'appliances'
  'GET /appliances/:app': 'appliance'
  'GET /appliances/:app/configuration': 'configuration'
  'GET /appliances/:app/gpg_key/:key': 'gpg_key'
  'GET /appliances/:app/gpg_keys': 'gpg_keys'
  'GET /appliances/:app/sharing': 'appliance'
  'GET /appliances/:app/software': 'software'
  'GET /appliances/:app/status': 'status'
  'GET /builds': 'builds'
  'GET /builds/:bld': 'build'
  'GET /files': 'files'
  'GET /files/:file': 'file'
  'GET /repositories': 'repositories'
  'GET /repositories/:repo': 'repository'
  'GET /rpms': 'rpms'
  'GET /rpms/:rpm': 'rpm'
  'GET /running_builds': 'running_builds'
  'GET /running_builds/:bld': 'running_build'
  'GET /testdrives': 'testdrives'
  'POST /testdrives': 'testdrive'

methods =
  'GET /account': (xo) ->
    xo.openid_urls = as_array xo.openid_urls.openid_url
    xo

  'GET /api_version': asis

  'GET /appliances/:app': (xo) ->
    xo.builds = as_array xo.builds.build
    xo

  'GET /appliances/:app/status': (xo) ->
    xo.issues = as_array xo.issues.issue
    xo

  'GET /appliances': (xo) ->
    xo = as_array xo.appliance
    for a in xo
      a.builds = as_array a.builds.build
    xo

  'GET /builds/:bld': asis

  'GET /builds': (xo) ->
    xo = as_array xo.build
    xo

  'GET /appliances/:app/configuration': (xo) ->
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

  'GET /files/:file': asis

  'GET /files': (xo) ->
    as_array xo.file

  'GET /appliances/:app/gpg_key/:key': asis

  'GET /appliances/:app/gpg_keys': (xo) ->
    as_array xo.gpg_key

  'GET /repositories': (xo) ->
    as_array xo.repository

  'GET /repositories/:repo': asis

  'GET /rpms/:rpm': asis

  'GET /rpms': (xo) ->
    xo.base_system = xo['@'].base_system
    delete xo['@']
    xo.rpms = as_array xo.rpm
    for r in xo.rpms
      r.base_system = xo.base_system
    delete xo.rpm
    xo

  'GET /running_builds/:bld': asis

  'GET /running_builds': (xo) ->
    as_array xo.running_build

  'GET /appliances/:app/sharing': (xo) ->
    xo.read_users = as_array xo.read_users.username
    xo

  'GET /appliances/:app/software': (xo) ->
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

  'POST /testdrives': asis

  'GET /testdrives': (xo) ->
    as_array xo.testdrive


exports.api = common.api methods, roots
