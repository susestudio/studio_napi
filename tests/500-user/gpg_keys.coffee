tools = require '../tools'

unapi = tools.api 'user'

key = '''
  -----BEGIN PGP PUBLIC KEY BLOCK-----
  Version: GnuPG v1.2.1 (GNU/Linux)

  mQGiBEIfIY8RBACIjFavOQNbs4bjTtOblq4X5/oxuTJtv41nfqSFNeUAQke0qoxx
  AUlBesWxDsOXp5VppgNEA07hGjPvzoxabLAsTccQplvHMNzmRezyukYrSTVR/F7g
  ywpvlhaAFkL9jZxodXzWKk2cmBLVWvuyzlLEUBeijm2amyEHcIGAczxPawCgmVcM
  9WpA6SOKivd9qTXK2XP+9BUD/2xV4OR4L7q8CSiaDMwPLo6P6D6VDc9LpVy16Wmu
  iYPFJIcIpp309biKZhGZgd+gHDhld9EJcZ3A2v43GY/xCdJqZ7Uh5QIGDafnil87
  2AbMIBYpcOpvAshTM10S3Qj06pIQE47oONZT5A80O/hn+Yd8ySCEswpbWCmtAxnc
  iNw3A/0Qk/bKrhT6J9Um2JhMfxx/nB80mM+Jlsn58B8i4sjrIVdzc3b45Y2wbXN3
  uVGuvvAFolAco3cpVy3oY1wMVuh8UlJFNESmxZL/Z7BXyKhiKUZrNxEvQt9OtD1F
  d36ur8Ky8zFE5GL903Nx/dEVBvIDq2/2K3Wy9Yq3YIC0PW7fkrQlQ2VudE9TLTQg
  a2V5IDxjZW50b3MtNGtleUBjZW50b3Mub3JnPohfBBMRAgAfBQJCHyGPBQkSzAMA
  BAsHAwIDFQIDAxYCAQIeAQIXgAAKCRClPQurRD4YISH0AJ9zmx2JPGt8ELKo3aE0
  YoGg6EYipwCdH3kRVJHQtDeRs/5v5Ghn92XZS4KITAQTEQIADAUCQh8hxAWDEswC
  ywAKCRA4whYWOWygpCumAJwOseF0mAV+j/0kGrKXf/FKboFScgCdEITVqtB1CCyn
  +q+IqnCmgEF8rYy5Ag0EQh8hqhAIAKwNu60J+AnfVjNk0eN26sKBQOHFVQX9M3bd
  NBVWruocb7dro6DG4daPVB66ZI9RqBusll0jz5nUhBO3GZ3rn/KLVhMO2uCtvdcw
  WYtY6188lO6lOm3aYadIqafcPPiiLnF3zm/E8hI/trbPpaoW1dFBOiSlOY4bSpSC
  nTuHYd5fjYu77wQhnSsl19XfqwuvHQKW1vhXCaM2GrsLA5tgjLOlJhYJ4yPY2LTo
  yxoWC/JMMM0Vwi7BaVoa/G2uamC6sL5f6KXei5QftemUvw1uM/2fkLbuHtwETq6Z
  yUZlsL1H5K5G4h+GDVByBF6Y2P1csi7oXK13sdzhkewLaMjmah8ABAsH/3zhD0Gy
  1jlMs9dGKSi9kq3jcUE/4o3vvjOPbxqT9psJu0jMEAfUVCWX9BWgZXyE2u+nBxcY
  AnNyqdmQzs6wTgJWGeGKpyC1jIKtO888RpPShvXtt/aNF4LaoielWZY9xu5oYEhn
  mBoww3VTbVxFNaPjglZOWnTxWfysHwG0H/dnXMp1sJjfdNsiB7zNniRRurlIiy0x
  hQSkDLe4tUr9Q9u4ztZKbwVX/fBzJC/u4Smi4VYx+HfOAP3OqzcGKNcb68GpIVo3
  1RUQq1JqpPSM5U41kW8u+S5n+zhjZsb/Ix3ks18gI8wz5u5yzfGacqp65NLisqVe
  OKEf/MQ1xWytG4SITAQYEQIADAUCQh8hqgUJEswDAAAKCRClPQurRD4YIXC1AKCF
  3t5xKJnEXJfgvhvldOzDIFjajwCgkX/MZI0O0SxYQAc2hEQJqCI/LJU=
  =Qsai
  -----END PGP PUBLIC KEY BLOCK-----
  '''

describe 'User API', ->

  it 'gives info for a GPG key', (done) ->
    unapi GET 'gpg_keys', async done, (err, r) ->
      no_error err
      contains r, gpg_keys: [
        {
          id: '27'
          name: 'test1'
          target: 'rpm'
        }
      ]
      (expect r.gpg_keys[0].key).to.include(key)

