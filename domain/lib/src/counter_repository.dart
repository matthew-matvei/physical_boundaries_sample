import 'package:domain/domain.dart';

abstract class CounterRepository {
  Future<Counter?> get();
  Future save(Counter counter);
}
