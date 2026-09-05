class CounterState {
  final int counterValue;

  const CounterState({required this.counterValue});

  factory CounterState.initial() => const CounterState(counterValue: 0);

  CounterState copyWith({int? counterValue}) {
    return CounterState(counterValue: counterValue ?? this.counterValue);
  }
}
