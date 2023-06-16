import 'package:flutter/material.dart';
import 'package:physical_boundaries_sample/counter_repository.dart';

import 'counter.dart';

void main() {
  runApp(MyApp(
    counterRepository: SharedPreferencesCounterRepository(),
  ));
}

class MyApp extends StatelessWidget {
  final CounterRepository _counterRepository;

  const MyApp({super.key, required CounterRepository counterRepository})
      : _counterRepository = counterRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        counterRepository: _counterRepository,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required CounterRepository counterRepository,
  }) : _counterRepository = counterRepository;

  final String title;
  final CounterRepository _counterRepository;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Counter? _counter;

  @override
  void initState() {
    super.initState();
    _initialiseCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "The counter's value is:",
            ),
            Text(
              _counter?.value == null ? 'Not yet loaded' : '${_counter!.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ButtonBar(
              children: [
                TextButton(
                  key: Keys.decrement.value,
                  onPressed: _decrementCounter,
                  child: const Text('-'),
                ),
                TextButton(
                  key: Keys.increment.value,
                  onPressed: _incrementCounter,
                  child: const Text('+'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _initialiseCounter() async {
    final retrievedCounter = await widget._counterRepository.get();

    setState(() {
      _counter = retrievedCounter ?? Counter.zero();
    });
  }

  void _incrementCounter() {
    if (_counter == null) {
      return;
    }

    setState(() {
      _counter!.increment();
    });
  }

  void _decrementCounter() {
    if (_counter == null) {
      return;
    }

    if (_counter!.tryDecrement()) {
      setState(() {});
    }
  }
}

enum Keys {
  increment(ValueKey("increment")),
  decrement(ValueKey("decrement"));

  final ValueKey value;

  const Keys(this.value);
}
