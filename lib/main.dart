import 'package:flutter/widgets.dart';
import 'package:infrastructure/infrastructure.dart';
import 'package:presentation/presentation.dart';

void main() {
  runApp(MyApp(
    counterRepository: SharedPreferencesCounterRepository(),
  ));
}
