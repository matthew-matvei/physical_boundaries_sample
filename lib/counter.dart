class Counter {
  int _value;

  Counter.zero() : _value = 0;

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
