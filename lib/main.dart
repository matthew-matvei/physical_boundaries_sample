import 'package:flutter/widgets.dart';
import 'package:physical_boundaries_sample/infrastructure/counter_repository.dart';
import 'package:physical_boundaries_sample/presentation/my_app.dart';

void main() {
  runApp(MyApp(
    counterRepository: SharedPreferencesCounterRepository(),
  ));
}
