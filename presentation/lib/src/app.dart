import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/home_page.dart';

class MyApp extends StatelessWidget {
  final CounterRepository _counterRepository;

  const MyApp({super.key, required CounterRepository counterRepository})
      : _counterRepository = counterRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Physical Boundaries',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Physical Boundaries Sample',
        counterRepository: _counterRepository,
      ),
    );
  }
}
