import 'package:curso_arquitetura/app/app.dart';
import 'package:curso_arquitetura/app/di.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
