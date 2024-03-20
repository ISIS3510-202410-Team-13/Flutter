import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unischedule/routes/go_router_provider.dart';


void main() {

  runApp(
    const ProviderScope(child: UniScheduleApp())
  );
}

class UniScheduleApp extends ConsumerStatefulWidget {
  const UniScheduleApp({super.key});

  @override
  ConsumerState<UniScheduleApp> createState() => _UniScheduleAppState();
}

class _UniScheduleAppState extends ConsumerState<UniScheduleApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      title: 'UniSchedule',
      theme: ThemeData(       
        primarySwatch: Colors.blue,
      ),
    );
  }
}