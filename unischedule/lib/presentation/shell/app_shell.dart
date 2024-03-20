import 'package:flutter/material.dart';
import 'package:unischedule/presentation/bottom_nav_bar/bottom_nav_bar.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  const AppShell({required this.child, Key? key}) : super(key: key);

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}