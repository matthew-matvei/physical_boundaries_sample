import 'package:flutter/material.dart';

import 'counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Counter _counter = Counter.zero();

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
              '${_counter.value}',
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

  void _incrementCounter() {
    setState(() {
      _counter.increment();
    });
  }

  void _decrementCounter() {
    if (_counter.tryDecrement()) {
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
