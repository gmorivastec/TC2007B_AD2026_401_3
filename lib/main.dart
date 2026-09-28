import 'package:flutter/material.dart';
import 'classes/example.dart';

// Flutter - framework for multiplatform development (including mobile)
// language? - Dart
// what about Dart? - c++ like, not widely used

void main() {
  // we have a main method here!
  // we can mess with it!
  runApp(const MainApp());
}

// the main building block in flutter is called
// Widget

// conceptually VERY similar to a component in React
// widgets can be aggregated - we create a complex widget 
// using simpler ones

// widgets are defined in classes
// it is REQUIRED that a widget class extends from a widget
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StatelessExampleWidget(),
    );
  }
}
