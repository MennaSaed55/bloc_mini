import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    on<CounterIncrementRequested>(_onIncrementRequested);
    on<CounterDecrementRequested>(_onDecrementRequested);
  }

  void _onIncrementRequested(
    CounterIncrementRequested event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counterValue: state.counterValue + 1));
  }

  void _onDecrementRequested(
    CounterDecrementRequested event,
    Emitter<CounterState> emit,
  ) {
    emit(state.copyWith(counterValue: state.counterValue - 1));
  }
}
