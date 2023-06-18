// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:domain/domain.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:physical_boundaries_sample/presentation/my_app.dart';

void main() {
  group('Counter', () {
    testWidgets('can be incremented', (tester) async {
      await tester.pumpWidget(
        MyApp(counterRepository: _InMemoryCounterRepository()),
      );
      await tester.pump();

      expect(find.text('0'), findsOneWidget);

      await _incrementCounter(tester);

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('can be decremented', (tester) async {
      await tester.pumpWidget(
        MyApp(counterRepository: _InMemoryCounterRepository()),
      );
      await tester.pump();

      expect(find.text('0'), findsOneWidget);

      await _incrementCounter(tester);
      await _incrementCounter(tester);
      await _incrementCounter(tester);

      expect(find.text('3'), findsOneWidget);

      await _decrementCounter(tester);

      expect(find.text('2'), findsOneWidget);
    });

    testWidgets('cannot be decremented to a negative value', (tester) async {
      await tester.pumpWidget(
        MyApp(counterRepository: _InMemoryCounterRepository()),
      );
      await tester.pump();

      expect(find.text('0'), findsOneWidget);

      await _decrementCounter(tester);

      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('can find a previously set value', (tester) async {
      final counterRepository = _InMemoryCounterRepository();

      await tester.pumpWidget(
        RootRestorationScope(
          restorationId: "Previously set value",
          child: MyApp(
            counterRepository: counterRepository,
          ),
        ),
      );
      await tester.pump();

      await _incrementCounter(tester);
      await _incrementCounter(tester);
      await _incrementCounter(tester);

      expect(find.text('3'), findsOneWidget);

      await tester.restartAndRestore();
      await tester.pump();

      expect(find.text('3'), findsOneWidget);
    });
  });
}

Future<void> _incrementCounter(WidgetTester tester) async {
  await tester.tap(find.byKey(Keys.increment.value));
  await tester.pump();
}

Future<void> _decrementCounter(WidgetTester tester) async {
  await tester.tap(find.byKey(Keys.decrement.value));
  await tester.pump();
}

class _InMemoryCounterRepository implements CounterRepository {
  Counter? _counter;

  @override
  Future<Counter?> get() async => _counter;

  @override
  Future save(Counter counter) async {
    _counter = counter;
  }
}
