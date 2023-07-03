class Counter {
  int _value;

  Counter([int? value]) : _value = value ?? 0 {
    if (_value < 0) {
      throw ArgumentError.value(
        value,
        "value",
        "Counter cannot have a negative value",
      );
    }
  }

  int get value => _value;

  void increment() {
    _value++;
  }

  bool tryDecrement() {
    if (value == 0) {
      return false;
    }

    _value--;
    return true;
  }
}
