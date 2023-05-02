import 'dart:async';

import 'package:curso_arquitetura/presentation/resources/assets_manager.dart';
import 'package:curso_arquitetura/presentation/resources/color_manager.dart';
import 'package:curso_arquitetura/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  void _goNext() {
    Navigator.of(context).pushReplacementNamed(Routes.onBoardingRoute);
  }

  void _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
        child: Image(image: AssetImage(ImageAssets.splashLogo)),
      ),
    );
  }
}
