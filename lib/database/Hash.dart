import 'dart:typed_data';
import 'package:base58/base58.dart';

class Hash {
  final int hashCode;
  
  Hash(this.hashCode);

  Hash.fromHex(String hexCode):
    hashCode = int.parse(hexCode, radix: 16);

  Hash.fromBase58(String base58Code):
    hashCode = new Base58Codec().decode(base58Code);
  
  toHex() => hashCode.toRadixString(16);
  
  toBase58() => new Base58Codec().encode(hashCode);
  
  @override
  toString() => toHex();
}
