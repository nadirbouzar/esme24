import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/screens/home_page.dart';
import 'package:swipezone/screens/planning_page.dart';
import 'package:swipezone/screens/select_page.dart';

void main() {
  runApp(
    MaterialApp.router(
      routerConfig: _router,
    ),
  );
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage(
          title: 'HomePage',
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'planningpage',
          builder: (BuildContext context, GoRouterState state) {
            return const PlanningPage(
              title: "PlanningPage",
            );
          },
        ),
        GoRoute(
          path: 'selectpage',
          builder: (BuildContext context, GoRouterState state) {
            return const SelectPage(
              title: "SelectPage",
            );
          },
        ),
      ],
    ),
  ],
);

// Retirer les boutons --> Remplacer par le système NFC : 1 like == NFC sinon on ne fait rien (puis il
// y a un classement des lieux préférés