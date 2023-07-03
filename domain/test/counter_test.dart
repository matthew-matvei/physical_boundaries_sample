import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group("Counter", () {
    test("does not allow decrementing below zero", () {
      final counter = Counter(0);

      final decrementedSuccessfully = counter.tryDecrement();

      expect(decrementedSuccessfully, isFalse);
      expect(counter.value, 0);
    });

    test("does not support being constructed with a negative value", () {
      void constructingCounterWithNegativeValue() => Counter(-1);

      expect(
        constructingCounterWithNegativeValue,
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
