import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'pages/home.dart';
import 'pages/entry_point.dart';
import 'pages/preview.dart';

void main() {
  runApp(TestingApp());
}

class TestingApp extends StatelessWidget {
  TestingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: '健康码',
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const TestingHomePageView();
        },
      ),
      GoRoute(
        path: '/entry',
        builder: (BuildContext context, GoRouterState state) {
          return const PointerPageView();
        },
      ),
      GoRoute(
        path: '/preview',
        builder: (BuildContext context, GoRouterState state) {
          return const PreviewPageView();
        },
      ),
    ],
  );
}
