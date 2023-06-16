import 'counter.dart';

abstract class CounterRepository {
  Future<Counter?> get();
  Future save(Counter counter);
}

class SharedPreferencesCounterRepository implements CounterRepository {
  @override
  Future<Counter?> get() {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future save(Counter counter) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
