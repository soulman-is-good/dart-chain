import 'dart:math';
import 'dart:typed_data';
import 'package:base58/base58.dart';
import 'package:pointycastle/pointycastle.dart';
import '../utils/dataUtils.dart';

class Hash {
  final int hashCode;
  
  Hash(this.hashCode);

  Hash.fromHex(String hexCode):
    hashCode = int.parse(hexCode, radix: 16);

  Hash.fromBase58(String base58Code):
    hashCode = new Base58Codec().decode(base58Code);
  
  Hash.fromUint8List(Uint8List list):
    hashCode = uInt8ListToInt(list);
  
  String toHex() => hashCode.toRadixString(16);
  
  String toBase58() => new Base58Codec().encode(hashCode);

  get length => (log(hashCode) / log(2) / 8).floor() + 1;
  
  @override
  toString() => toHex();
}
