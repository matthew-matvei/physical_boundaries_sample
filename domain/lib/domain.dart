class Counter {
  int _value;

  Counter([int? value]) : _value = value ?? 0;

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

abstract class CounterRepository {
  Future<Counter?> get();
  Future save(Counter counter);
}
