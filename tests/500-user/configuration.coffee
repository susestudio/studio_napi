expect = (require 'chai').expect
unapi = (require '../../lib/user').api

{contains, no_error} = require '../tools'

describe 'User API "configuration"', ->

  exp = configuration: { # {{{

    id: '24'
    name: 'LAMP Server'
    description: '''This is a LAMP server.

  It provides Linux, Apache, MySQL, and Perl.'''
    website: 'http://susestudio.com'

    tags: [
      'lamp'
      'server'
    ]

    locale:
      keyboard_layout: 'english-uk'
      language: 'en_GB.UTF-8'
      timezone:
        location: 'Europe/Berlin'

    network:
      type: 'manual'
      hostname: 'lampserver'
      ip: '192.168.1.100'
      netmask: '255.255.255.0'
      route: '192.168.1.1'
      nameservers: '192.168.1.1, 192.168.1.2'

    firewall:
      enabled: 'true'
      open_ports: [
        'ssh'
        'http'
      ]

    users: [
      {
        name: 'root'
        password: 'linux'
        group: 'root'
        shell: '/bin/bash'
        homedir: '/root'
      }
      {
        name: 'tux'
        password: 'linux'
        group: 'users'
        shell: '/bin/bash'
        homedir: '/home/tux'
      }
      {
        name: 'webdev'
        password: 'linux1234'
        group: 'users'
        shell: '/bin/bash'
        homedir: '/home/webdev'
      }
    ]

    eulas: [
      'This is an End User License Agreement.\n'
    ]

    databases: [
      {
        type: 'pgsql'
        users: [
          {
            username: 'db_user'
            password: 'linux'
            database_list: 'project_db'
          }
        ]
      }
    ]

    autostarts: [
      {
        command: '/usr/bin/someprogram'
        description: 'Launch "someprogram"'
        enabled: 'true'
        user: 'tux'
      }
    ]

    settings:
      memory_size: '512'
      disk_size: '16'
      swap_size: '512'
      pae_enabled: 'false'
      xen_host_mode_enabled: 'true'
      cdrom_enabled: 'true'
      webyast_enabled: 'false'
      public_clonable: 'true'
      runlevel: '3'
      automatic_login: 'tux'

    lvm:
      enabled: 'true'
      volume_group: 'systemVG'
      volumes: [
        {
          size: '1000'
          path: '/'
        }
        {
          size: '100000'
          path: '/home'
        }
      ]

    scripts:

      build:
        enabled: 'true'
        script: '''#!/bin/bash -e
        #
        # This script is executed at the end of appliance creation.  Here you can do
        # one-time actions to modify your appliance before it is ever used, like
        # removing files and directories to make it smaller, creating symlinks,
        # generating indexes, etc.
        #
        # The 'kiwi_type' variable will contain the format of the appliance (oem =
        # disk image, vmx = VMware, iso = CD/DVD, xen = Xen).
        #
        
        # read in some variables
        . /studio/profile
        
        #======================================
        # Prune extraneous files
        #--------------------------------------
        # Remove all documentation
        docfiles=`find /usr/share/doc/packages -type f |grep -iv "copying\\|license\\|copyright"`
        rm -f $docfiles
        rm -rf /usr/share/info
        rm -rf /usr/share/man
        
        # fix the setlocale error
        sed -i 's/en_US.UTF-8/POSIX/g' /etc/sysconfig/language
        
        exit 0'''

      boot:
        enabled: 'true'
        script: '''#!/bin/bash
        #
        # This script is executed whenever your appliance boots.  Here you can add
        # commands to be executed before the system enters the first runlevel.  This
        # could include loading kernel modules, starting daemons that aren't managed
        # by init files, asking questions at the console, etc.
        #
        # The 'kiwi_type' variable will contain the format of the appliance (oem =
        # disk image, vmx = VMware, iso = CD/DVD, xen = Xen).
        #
        
        # read in some variables
        . /studio/profile
        
        if [ -f /etc/init.d/suse_studio_firstboot ]
        then
        
          # Put commands to be run on the first boot of your appliance here
          echo "Running SUSE Studio first boot script..."
        
        fi'''

      autoyast:
        enabled: 'false'

  } # }}}

  it 'includes locale information', (done) ->
    unapi GET 'configuration', (err, r) ->
      no_error err
      (expect r).to.have.deep.property('configuration.locale')
        .deep.equal(exp.configuration.locale)
      done()

  it 'includes network information', (done) ->
    unapi GET 'configuration', (err, r) ->
      no_error err
      (expect r).to.have.deep.property('configuration.network')
        .deep.equal(exp.configuration.network)
      done()

  it 'includes firewall information', (done) ->
    unapi GET 'configuration', (err, r) ->
      no_error err
      (expect r).to.have.deep.property('configuration.firewall')
        .deep.equal(exp.configuration.firewall)
      done()

  it 'includes configured users', (done) ->
    unapi GET 'configuration', (err, r) ->
      no_error err
      (expect r).to.have.deep.property('configuration.users')
        .deep.equal(exp.configuration.users)
      done()

  it 'includes configured EULAs', (done) ->
    unapi GET 'configuration', (err, r) ->
      no_error err
      (expect r).to.have.deep.property('configuration.eulas')
        .deep.equal(exp.configuration.eulas)
      done()

  it 'includes database configs', (done) ->
    unapi GET 'configuration', (err, r) ->
      no_error err
      (expect r).to.have.deep.property('configuration.databases')
        .deep.equal(exp.configuration.databases)
      done()

  it 'includes configured autostart programs', (done) ->
    unapi GET 'configuration', (err, r) ->
      no_error err
      (expect r).to.have.deep.property('configuration.autostarts')
        .deep.equal(exp.configuration.autostarts)
      done()

  it 'includes basic image settings', (done) ->
    unapi GET 'configuration', (err, r) ->
      no_error err
      (expect r).to.have.deep.property('configuration.settings')
        .deep.equal(exp.configuration.settings)
      done()

  it 'includes LVM config', (done) ->
    unapi GET 'configuration', (err, r) ->
      no_error err
      (expect r).to.have.deep.property('configuration.lvm')
        .deep.equal(exp.configuration.lvm)
      done()

  describe 'custom scripts', ->
    it 'includes custom build script', (done) ->
      unapi GET 'configuration', (err, r) ->
        no_error err
        (expect r).to.have.deep.property('configuration.scripts.build')
        (expect r).to.have.deep.property(
          'configuration.scripts.build.script'
        , exp.configuration.scripts.build.script
        )
        (expect r.configuration.scripts.build).to.deep.equal(
          exp.configuration.scripts.build
        )
        done()

    it 'includes custom boot script', (done) ->
      unapi GET 'configuration', (err, r) ->
        no_error err
        (expect r).to.have.deep.property('configuration.scripts.boot')
        (expect r).to.have.deep.property(
          'configuration.scripts.boot.script'
        , exp.configuration.scripts.boot.script
        )
        (expect r.configuration.scripts.boot).to.deep.equal(
          exp.configuration.scripts.boot
        )
        done()

  it 'includes custom scripts', (done) ->
    unapi GET 'configuration', (err, r) ->
      no_error err
      (expect r).to.have.deep.property('configuration.scripts')
      (expect r.configuration.scripts).to.deep.equal(exp.configuration.scripts)
      done()

  it 'gives configuration of an appliance', (done) ->
    unapi GET 'configuration', (err, r) ->
      no_error err
      contains r, exp
      done()

