import 'package:shared_preferences/shared_preferences.dart';
import 'package:physical_boundaries_sample/domain/counter.dart';

abstract class CounterRepository {
  Future<Counter?> get();
  Future save(Counter counter);
}

class SharedPreferencesCounterRepository implements CounterRepository {
  static const _counterKey = "counterValue";

  @override
  Future<Counter?> get() async {
    final prefs = await SharedPreferences.getInstance();
    final retrievedValue = prefs.getInt(_counterKey);

    return retrievedValue == null ? null : Counter(retrievedValue);
  }

  @override
  Future save(Counter counter) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_counterKey, counter.value);
  }
}
