# Flutter State Management — BLoC Mini Project

## 1. Project Description

A small Flutter application built to demonstrate state management with the
[`flutter_bloc`](https://pub.dev/packages/flutter_bloc) package, covering
both the **Bloc** (Events + States) and **Cubit** (direct method calls)
patterns, plus the three core widgets used to consume them:
`BlocBuilder`, `BlocListener`, and `BlocConsumer`.

## 2. Technologies Used

- Flutter / Dart
- `flutter_bloc` (Bloc, Cubit, BlocProvider, BlocBuilder, BlocListener,
  BlocConsumer, `context.read`)

## 4. Phase 1 — Introduction to BLoC

### CounterBloc
Manages an integer counter using explicit events and states:
- `CounterIncrementRequested` / `CounterDecrementRequested` events
- `CounterState { counterValue }`
- Initial value: `0`

### ThemeBloc
Manages the app's `ThemeMode` (light/dark) completely independently of
`CounterBloc`:
- `ThemeToggleRequested` event
- `ThemeState { themeMode }`
- Toggling flips between `ThemeMode.light` and `ThemeMode.dark`

`Phase1Screen` provides both blocs (`CounterBloc` locally, `ThemeBloc` from
the app root) and displays the counter value, increment/decrement buttons,
and a theme toggle button.

## 5. Phase 2 — BlocListener, BlocBuilder & BlocConsumer

Each widget gets its own dedicated screen, each with its own `CounterBloc`
instance, to keep the demonstrations isolated and easy to follow.

### A. BlocListener (`bloc_listener_screen.dart`)
Listens for the counter reaching **5** and shows a `SnackBar`. It performs
**no UI rebuilding** itself — a separate `BlocBuilder` is used just to render
the digits.

### B. BlocBuilder (`bloc_builder_screen.dart`)
Rebuilds only the counter `Text` whenever the state changes. No side effects.

### C. BlocConsumer (`bloc_consumer_screen.dart`)
Combines both responsibilities: rebuilds the counter text (`builder`) and
shows a `SnackBar` (`listener`) when the counter reaches **8** or **-8**.

## 6. Phase 3 — Complete Counter Application

### CounterCubit
A `Cubit<int>` with `increment()` / `decrement()` methods, starting at `0`.
Unlike a Bloc, it has no events — methods are called directly.

### BlocProvider & context.read
`CounterCubit` is provided once at the top of `CounterAppScreen`. Both
buttons call the cubit directly with `context.read<CounterCubit>()`
(never `context.watch`, since button callbacks don't need to rebuild).

### Dialog for negative values
A `BlocListener<CounterCubit, int>` shows an `AlertDialog` the moment the
counter transitions from `>= 0` to a negative value. `listenWhen` restricts
the listener to that exact transition, so the dialog cannot be triggered
again just by continuing to decrement, or fire more than once per crossing.

### Messages for 10 and -10
A `BlocConsumer<CounterCubit, int>` rebuilds the counter text and shows a
`SnackBar`:
- `"Maximum target reached: 10"` when the value hits `10`
- `"Minimum target reached: -10"` when the value hits `-10`

## 7. How to Run the Project

```bash
flutter pub get
flutter run
```

> Note: this project's source was generated and reviewed for correctness in
> an environment without the Flutter SDK installed, so it has **not** been
> compiled or run automatically. Please run `flutter pub get` and
> `flutter analyze` locally before relying on it, and open an issue in your
> own workflow if anything needs adjusting.

## 8. Screenshots

Add screenshots here after running the app locally:

- [ ] Phase 1 — CounterBloc value + ThemeBloc light/dark toggle
- [ ] Phase 2 — BlocListener SnackBar at counter = 5
- [ ] Phase 2 — BlocBuilder UI showing live counter updates
- [ ] Phase 2 — BlocConsumer SnackBar at counter = 8 / -8
- [ ] Phase 3 — Negative counter AlertDialog
- [ ] Phase 3 — Counter at 10 or -10 showing the target SnackBar
