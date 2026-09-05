import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/counter_bloc.dart';
import '../controllers/counter_event.dart';
import '../controllers/counter_state.dart';
import '../controllers/theme_bloc.dart';
import '../controllers/theme_event.dart';
import '../controllers/theme_state.dart';

class Phase1Screen extends StatelessWidget {
  const Phase1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Phase 1 — CounterBloc & ThemeBloc')),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'CounterBloc uses Events & States to manage an integer value.',
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
                  ElevatedButton(
                    onPressed: () => context
                        .read<CounterBloc>()
                        .add(const CounterDecrementRequested()),
                    child: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton(
                    onPressed: () => context
                        .read<CounterBloc>()
                        .add(const CounterIncrementRequested()),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 16),
              const Text(
                'ThemeBloc toggles the app between light and dark mode.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return FilledButton.icon(
                    onPressed: () => context
                        .read<ThemeBloc>()
                        .add(const ThemeToggleRequested()),
                    icon: Icon(
                      themeState.isDarkMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                    label: Text(
                      themeState.isDarkMode
                          ? 'Switch to Light Theme'
                          : 'Switch to Dark Theme',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
