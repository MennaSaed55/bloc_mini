import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/counter_bloc.dart';
import '../controllers/counter_event.dart';
import '../controllers/counter_state.dart';
import '../widgets/counter_control_button.dart';

class BlocBuilderScreen extends StatelessWidget {
  const BlocBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Phase 2 — BlocBuilder')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'BlocBuilder rebuilds the UI when the state changes.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              BlocBuilder<CounterBloc, CounterState>(
                builder: (context, state) {
                  return Text(
                    '${state.counterValue}',
                    style: Theme.of(context).textTheme.displayMedium,
                  );
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CounterControlButton(
                    icon: Icons.remove,
                    label: 'Decrement',
                    onPressed: () => context
                        .read<CounterBloc>()
                        .add(const CounterDecrementRequested()),
                  ),
                  const SizedBox(width: 16),
                  CounterControlButton(
                    icon: Icons.add,
                    label: 'Increment',
                    onPressed: () => context
                        .read<CounterBloc>()
                        .add(const CounterIncrementRequested()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
