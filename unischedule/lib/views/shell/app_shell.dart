import 'package:flutter/material.dart';
import 'package:unischedule/views/bottom_navbar/bottom_navbar.dart';
import '../../../views/slide-out_page/slide-out_page.dart';

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
      drawer: SlideOutMenu(),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}