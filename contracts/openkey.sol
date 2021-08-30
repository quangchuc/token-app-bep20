#
// decompile bytecode
#  Panoramix v4 Oct 2019 
#  Decompiled source of bsc:0xa362d8529e2c1222AA411470f5A3367f36de999C
# 
#  Let's make the world open source 
# 
#
#  I failed with these: 
#  - _fallback()
#  All the rest is below.
#

def storage:
  stor3608 is addr at storage 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
  storB531 is addr at storage 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103

def admin(): # not payable
  if caller == storB531:
      return storB531
  delegate stor3608 with:
     funct call.data[0 len 4]
       gas gas_remaining wei
      args call.data[4 len calldata.size - 4]
  if not delegate.return_code:
      revert with ext_call.return_data[0 len return_data.size]
  return ext_call.return_data[0 len return_data.size]

def implementation(): # not payable
  if caller == storB531:
      return stor3608
  delegate stor3608 with:
     funct call.data[0 len 4]
       gas gas_remaining wei
      args call.data[4 len calldata.size - 4]
  if not delegate.return_code:
      revert with ext_call.return_data[0 len return_data.size]
  return ext_call.return_data[0 len return_data.size]

def upgradeTo(address _implementation): # not payable
  require calldata.size - 4 >=′ 32
  require _implementation == _implementation
  if storB531 != caller:
      delegate stor3608 with:
         funct call.data[0 len 4]
           gas gas_remaining wei
          args call.data[4 len calldata.size - 4]
      if not delegate.return_code:
          revert with ext_call.return_data[0 len return_data.size]
      return ext_call.return_data[0 len return_data.size]
  if not ext_code.size(_implementation):
      revert with 0, 'ERC1967: new implementation is not a contract'
  stor3608 = _implementation
  log Upgraded(address implementation=_implementation)

def changeAdmin(address _admin): # not payable
  require calldata.size - 4 >=′ 32
  require _admin_ == _admin_
  if storB531 != caller:
      delegate stor3608 with:
         funct call.data[0 len 4]
           gas gas_remaining wei
          args call.data[4 len calldata.size - 4]
      if not delegate.return_code:
          revert with ext_call.return_data[0 len return_data.size]
      return ext_call.return_data[0 len return_data.size]
  log AdminChanged(
        address previousAdmin=storB531,
        address newAdmin=_admin_)
  if not _admin_:
      revert with 0x8c379a000000000000000000000000000000000000000000000000000000000, 'ERC1967: new admin is the zero address'
  storB531 = _admin_

def upgradeToAndCall(address _implementation, bytes _data) payable: 
  require calldata.size - 4 >=′ 64
  require _implementation == _implementation
  require _data <= 18446744073709551615
  require _data + 35 <′ calldata.size
  require _data.length <= 18446744073709551615
  require _data + _data.length + 36 <= calldata.size
  if storB531 != caller:
      delegate stor3608 with:
         funct call.data[0 len 4]
           gas gas_remaining wei
          args call.data[4 len calldata.size - 4]
      if not delegate.return_code:
          revert with ext_call.return_data[0 len return_data.size]
      return ext_call.return_data[0 len return_data.size]
  mem[128 len _data.length] = _data[all]
  mem[_data.length + 128] = 0
  if not ext_code.size(_implementation):
      revert with 0, 'ERC1967: new implementation is not a contract'
  stor3608 = _implementation
  log Upgraded(address implementation=_implementation)
  mem[ceil32(_data.length) + 128] = 39
  mem[ceil32(_data.length) + 160 len 39] = 0xfe416464726573733a206c6f772d6c6576656c2064656c65676174652063616c6c206661696c65
  if not ext_code.size(_implementation):
      revert with 0, 'Address: delegate call to non-contract'
  mem[ceil32(_data.length) + 224 len ceil32(_data.length)] = _data[all], mem[_data.length + 128 len ceil32(_data.length) - _data.length]
  if ceil32(_data.length) > _data.length:
      mem[_data.length + ceil32(_data.length) + 224] = 0
  delegate _implementation.mem[ceil32(_data.length) + 224 len 4] with:
       gas gas_remaining wei
      args mem[ceil32(_data.length) + 228 len _data.length - 4]
  if not return_data.size:
      if delegate.return_code:
          stop
      if _data.length:
          revert with _data[all]
      mem[ceil32(_data.length) + 224] = 0x8c379a000000000000000000000000000000000000000000000000000000000
      mem[ceil32(_data.length) + 228] = 32
      mem[ceil32(_data.length) + 260] = Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)]
      mem[ceil32(_data.length) + 292 len ceil32(Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)])] = mem[ceil32(_data.length) + 160 len ceil32(Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)])]
      if ceil32(Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)]) > Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)]:
          mem[Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)] + ceil32(_data.length) + 292] = 0
      revert with memory
        from ceil32(_data.length) + 224
         len ceil32(Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)]) + 68
  mem[ceil32(_data.length) + 224] = return_data.size
  mem[ceil32(_data.length) + 256 len return_data.size] = ext_call.return_data[0 len return_data.size]
  if delegate.return_code:
      stop
  if return_data.size:
      revert with ext_call.return_data[0 len return_data.size]
  mem[ceil32(_data.length) + ceil32(return_data.size) + 225] = 0x8c379a000000000000000000000000000000000000000000000000000000000
  mem[ceil32(_data.length) + ceil32(return_data.size) + 229] = 32
  mem[ceil32(_data.length) + ceil32(return_data.size) + 261] = Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)]
  mem[ceil32(_data.length) + ceil32(return_data.size) + 293 len ceil32(Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)])] = mem[ceil32(_data.length) + 160 len ceil32(Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)])]
  if ceil32(Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)]) > Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)]:
      mem[Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)] + ceil32(_data.length) + ceil32(return_data.size) + 293] = 0
  revert with memory
    from ceil32(_data.length) + ceil32(return_data.size) + 225
     len ceil32(Mask(8 * -ceil32(_data.length) + _data.length + 32, 0, 0), mem[_data.length + 160 len -_data.length + ceil32(_data.length)]) + 68

