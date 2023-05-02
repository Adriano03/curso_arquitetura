// ignore_for_file: must_be_immutable

import 'package:curso_arquitetura/presentation/resources/routes_manager.dart';
import 'package:curso_arquitetura/presentation/resources/theme_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  // Define o construtor com nome privado;
  MyApp._internal();
  int appState = 0;

  // Cria uma instância única -- Singleton;
  static final MyApp instance = MyApp._internal();

  // Fábrica para a instância da classe
  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
