tools = require '../tools'

unapi = tools.api 'user'

describe 'User API', ->

  it 'gives all selected packages and patterns of an appliance', (done) ->
    unapi GET '/appliances/:app/software', async done, (err, r) ->
      no_error err
      contains r, software: {
        appliance_id: '42'
        patterns: [
          'laptop'
          'x11'
        ]
        packages: [
          { name: 'MozillaFirefox' }
          { name: 'PolicyKit' }
          { name: 'SuSEfirewall2' }
          { name: 'aaa_base' }
          { name: 'branding-openSUSE' }
          { name: 'dhcpcd' }
          { name: 'fate' }
          { name: 'grub' }
          { name: 'hwinfo' }
          { name: 'insserv' }
          { name: 'kbd' }
          { name: 'kde4-yakuake' }
          { name: 'kernel-default', version: '2.6.27.7-9.1' }
          { name: 'licenses' }
          { name: 'mkinitrd' }
          { name: 'module-init-tools' }
          { name: 'netcfg' }
          { name: 'openSUSE-build-key' }
          { name: 'openSUSE-release' }
          { name: 'openssh' }
          { name: 'polkit-default-privs' }
          { name: 'procps' }
          { name: 'pwdutils' }
          { name: 'rpcbind' }
          { name: 'rpm' }
          { name: 'sysconfig' }
          { name: 'syslog-ng' }
          { name: 'vim', version: '7.2-7.3' }
        ]
      }

