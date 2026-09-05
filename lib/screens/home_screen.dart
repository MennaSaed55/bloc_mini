import 'package:flutter/material.dart';

import 'phase1_screen.dart';
import 'bloc_builder_screen.dart';
import 'bloc_consumer_screen.dart';
import 'bloc_listener_screen.dart';
import 'counter_app_screen.dart';

class _DemoDestination {
  final String title;
  final String subtitle;
  final IconData icon;
  final WidgetBuilder builder;

  const _DemoDestination({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.builder,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<_DemoDestination> _destinations = [
    _DemoDestination(
      title: 'Phase 1 — CounterBloc & ThemeBloc',
      subtitle: 'Two independent BLoCs: counting and theme switching.',
      icon: Icons.looks_one,
      builder: (_) => const Phase1Screen(),
    ),
    _DemoDestination(
      title: 'Phase 2 — BlocListener',
      subtitle: 'Side effects only: SnackBar at a target value.',
      icon: Icons.hearing,
      builder: (_) => const BlocListenerScreen(),
    ),
    _DemoDestination(
      title: 'Phase 2 — BlocBuilder',
      subtitle: 'UI rebuilding only.',
      icon: Icons.build,
      builder: (_) => const BlocBuilderScreen(),
    ),
    _DemoDestination(
      title: 'Phase 2 — BlocConsumer',
      subtitle: 'Builder + listener combined.',
      icon: Icons.merge_type,
      builder: (_) => const BlocConsumerScreen(),
    ),
    _DemoDestination(
      title: 'Phase 3 — Complete Counter App',
      subtitle: 'CounterCubit with dialog + SnackBar side effects.',
      icon: Icons.looks_5,
      builder: (_) => const CounterAppScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter State Management — BLoC')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _destinations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final destination = _destinations[index];
          return Card(
            elevation: 1,
            child: ListTile(
              leading: Icon(destination.icon),
              title: Text(destination.title),
              subtitle: Text(destination.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: destination.builder),
              ),
            ),
          );
        },
      ),
    );
  }
}
