import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/counter_control_button.dart';
import '../controllers/counter_cubit.dart';

const int _kMaxTarget = 10;
const int _kMinTarget = -10;

class CounterAppScreen extends StatelessWidget {
  const CounterAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Phase 3 — Complete Counter App')),
        body: BlocListener<CounterCubit, int>(
          listenWhen: (previous, current) => previous >= 0 && current < 0,
          listener: (context, state) {
            showDialog<void>(
              context: context,
              builder: (dialogContext) => AlertDialog(
                title: const Text('Negative Counter'),
                content: Text(
                  'The counter value is now $state, which is negative.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'CounterCubit + BlocProvider + context.read + '
                  'BlocBuilder + BlocListener + BlocConsumer, all together.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                BlocConsumer<CounterCubit, int>(
                  listenWhen: (previous, current) =>
                      current == _kMaxTarget || current == _kMinTarget,
                  listener: (context, state) {
                    final message = state == _kMaxTarget
                        ? 'Maximum target reached: $_kMaxTarget'
                        : 'Minimum target reached: $_kMinTarget';
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(message)));
                  },
                  builder: (context, state) {
                    return Text(
                      '$state',
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
                      onPressed: () =>
                          context.read<CounterCubit>().decrement(),
                    ),
                    const SizedBox(width: 16),
                    CounterControlButton(
                      icon: Icons.add,
                      label: 'Increment',
                      onPressed: () =>
                          context.read<CounterCubit>().increment(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
