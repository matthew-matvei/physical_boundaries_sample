import 'package:flutter/foundation.dart';

enum Keys {
  increment(ValueKey("increment")),
  decrement(ValueKey("decrement"));

  final ValueKey value;

  const Keys(this.value);
}
