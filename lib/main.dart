import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:testing/pages/settings.dart';
import 'package:testing/shared/local_storage.dart';

import 'pages/home.dart';
import 'pages/entry_point.dart';
import 'pages/preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await localStorage.init();
  runApp(TestingApp());
}

class TestingApp extends StatelessWidget {
  TestingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
      locale: const Locale('zh'),
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
      GoRoute(
        path: '/settings',
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsPageView();
        },
      ),
    ],
  );
}
