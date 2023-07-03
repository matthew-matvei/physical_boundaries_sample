import 'package:flutter/material.dart';
import 'package:infrastructure/infrastructure.dart';
import 'package:physical_boundaries_sample/presentation/my_app.dart';

void main() {
  runApp(MyApp(
    counterRepository: SharedPreferencesCounterRepository(),
  ));
}
