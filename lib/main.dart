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
              alignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  key: Keys.decrement.value,
                  onPressed: _decrementCounter,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primaryContainer,
                    ),
                    overlayColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  child: Text(
                    '-',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                TextButton(
                  key: Keys.increment.value,
                  onPressed: _incrementCounter,
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primaryContainer,
                    ),
                    overlayColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  child: Text(
                    '+',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
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
      _counter = retrievedCounter ?? Counter();
    });
  }

  Future<void> _incrementCounter() async {
    if (_counter == null) {
      return;
    }

    _counter!.increment();
    await widget._counterRepository.save(_counter!);

    setState(() {});
  }

  Future<void> _decrementCounter() async {
    if (_counter == null) {
      return;
    }

    if (_counter!.tryDecrement()) {
      await widget._counterRepository.save(_counter!);

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
