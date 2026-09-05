import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/counter_bloc.dart';
import '../controllers/counter_event.dart';
import '../controllers/counter_state.dart';
import '../widgets/counter_control_button.dart';

const int _kUpperTarget = 8;
const int _kLowerTarget = -8;
class BlocConsumerScreen extends StatelessWidget {
  const BlocConsumerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Phase 2 — BlocConsumer')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'BlocConsumer combines BlocListener and BlocBuilder.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              BlocConsumer<CounterBloc, CounterState>(
                listenWhen: (previous, current) =>
                    current.counterValue == _kUpperTarget ||
                    current.counterValue == _kLowerTarget,
                listener: (context, state) {
                  final message = state.counterValue == _kUpperTarget
                      ? 'Maximum target reached: $_kUpperTarget'
                      : 'Minimum target reached: $_kLowerTarget';
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                },
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
