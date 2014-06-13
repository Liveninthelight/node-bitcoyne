{createHash} = require 'crypto'
{hash160} = require './crypto'
{base58} = require 'kbpgp'

#-----------------------------------------

exports.hash160_to_bc_address = hash160_to_bc_address = (h160, version = 0 ) ->
  h160 = new Buffer h160, 'binary'
  vbuf = new Buffer [0]
  vbuf .writeUInt8 version, 0
  vh160 = Buffer.concat [ vbuf, h160 ]
  h = new Buffer vh160
  for i in [0...2]
    raw = (createHash 'sha256').update(h).digest()
    h = new Buffer raw, 'binary'
  addr = Buffer.concat [ vh160, h[0...4] ]
  x = base58.encode addr
  return x

#-----------------------------------------

exports.pubkey_to_bc_address = (pubkey, version) ->
  hash160_to_bc_address (hash160 pubkey), version

#-----------------------------------------

