class _64BIT {
  static const int size = 64;
}

class _Int {
  final int size;
  int _value;
  
  _Int(this.size, dynamic value) {
    if (value is _Int) {
      _value = value.toInt();
    } else if (value is int) {
      _value = value.toSigned(size);
    }
  }
  
  _Int _parseInt(dynamic value) {
    if (value is _Int) {
      return value.toInt();
    } else if (value is int) {
      return value;
    }
    
    throw new ArgumentError.value(value);
  }

  _Int operator +(dynamic other) {
    _value = (_value + _parseInt(other)).toSigned(size);

    return this;
  }

  Int operator |(dynamic other) {
    _value = _parseInt(other).toSigned(size);

    return this;
  }
  
  int toInt() {
    return _value.toSigned(size);
  }
}

class Int64 extends _Int {
  Int64(value): super(64, value);
}