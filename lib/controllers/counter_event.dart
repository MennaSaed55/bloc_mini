abstract class CounterEvent {
  const CounterEvent();
}
class CounterIncrementRequested extends CounterEvent {
  const CounterIncrementRequested();
}
class CounterDecrementRequested extends CounterEvent {
  const CounterDecrementRequested();
}
