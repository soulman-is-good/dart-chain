import "dart:math";
import "dart:typed_data";

Uint8List createUint8ListFromString(String s) {
  var ret = new Uint8List(s.length);

  for( var i=0 ; i<s.length ; i++ ) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}

int uInt8ListToInt(List list) {
  int bytes = (list.length - 1) * 8;
  int result = 0;

  list.forEach((int value) {
    result = result | (value << bytes);
    bytes = bytes - 8;
  });
  
  return result;
}

int sizeOfInt(int number) => (log(number) / log(2) / 8).floor() + 1;

UInt8List intToUInt8List(final int number, [int listSize]) {
  if (number == 0) return new Uint8List(0);
  int parsed = number;
  int size = listSize ?? sizeOfInt(number);
  int index = 0;
  uInt8List list = new Uint8List(size);

  while (index < size) {
    index += 1;
    list[size - index] = parsed & 0xff;
    parsed = parsed >> 8;
  }

  return list;
}