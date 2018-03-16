import '../consts/datatypes.dart';

class DataType {
  int _controlByte = null;
  dynamic _value = null;

  DataType._internal(this._controlByte, this.length) {
    this._buffer = new ByteBuffer();
  }

  DataType.string(String value) {
    this._controlByte = DATATYPES.STRING;
    this._value = value;
  }

  DataType.integer(int value) {
    this._controlByte = DATATYPES.INTEGER;
    this._value = value;
  }

  DataType.boolean(bool value) {
    this._controlByte = DATATYPES.BOOLEAN;
    this._value = value;
  }

  DataType.double(double value) {
    this._controlByte = DATATYPES.DOUBLE;
    this._value = value;
  }
}
