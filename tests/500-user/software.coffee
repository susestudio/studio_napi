expect = (require 'chai').expect

tools = require '../tools'

unapi = (require '../../lib/user').api tools.rpc 'user'

describe 'User API', ->

  it 'gives all selected packages and patterns of an appliance', (done) ->
    unapi GET 'software', async done, (err, r) ->
      no_error err
      if 0 then contains r, software: {
        appliance_id: '42'
        software: [
          { type: 'package', name: 'aaa_base' }
          { type: 'package', name: 'dhcpcd' }
          { type: 'package', name: 'hwinfo' }
          { type: 'package', name: 'insserv' }
          { type: 'package', name: 'kbd' }
          { type: 'package', name: 'licenses' }
          { type: 'package', name: 'mkinitrd' }
          { type: 'package', name: 'module-init-tools' }
          { type: 'package', name: 'netcfg' }
          { type: 'package', name: 'openssh' }
          { type: 'package', name: 'procps' }
          { type: 'package', name: 'pwdutils' }
          { type: 'package', name: 'rpm' }
          { type: 'package', name: 'openSUSE-release' }
          { type: 'package', name: 'openSUSE-build-key' }
          { type: 'package', name: 'sysconfig' }
          { type: 'package', name: 'syslog-ng' }
          { type: 'package', name: 'grub' }
          { type: 'package', name: 'branding-openSUSE' }
          { type: 'package', name: 'rpcbind' }
          { type: 'package', name: 'PolicyKit' }
          { type: 'package', name: 'polkit-default-privs' }
          { type: 'package', name: 'SuSEfirewall2' }
          { type: 'package', name: 'vim', version: '7.2-7.3' }
          { type: 'package', name: 'kernel-defualt', version: '2.6.27.7-9.1' }
          { type: 'pattern', name: 'x11' }
          { type: 'package', name: 'MozillaFirefox' }
          { type: 'package', name: 'kde4-yakuake' }
          { type: 'pattern', name: 'laptop' }
          { type: 'package', name: 'fate' }
        ]
      }

