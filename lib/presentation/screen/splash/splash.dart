import 'dart:math';

import 'package:gap/gap.dart';
import 'package:notes_test/domain/injects.dart';
import 'package:flutter/material.dart';
import 'package:notes_test/domain/routers/routers.dart';
import 'package:notes_test/presentation/theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  String error = '';
  late AnimationController _animationController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    initializeApp();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> initializeApp() async {
    try {
      error = await initMain();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        if (error.isEmpty) {
          router.goNamed('main');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 200,
            child: Column(
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.width * 0.6,
                ),
                const Gap(10),
                Text('Заметки',
                    style: AppText.t38mw.copyWith(color: AppColor.orange)),
              ],
            ),
          ),
          if (error.isNotEmpty && !_isLoading)
            Positioned(
              bottom: 100,
              left: 50,
              right: 50,
              child: Text('$error \n\nПерешлите ошибку разработчику',
                  style: AppText.t16rw.copyWith(color: AppColor.orangeLight),
                  textAlign: TextAlign.center),
            ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: _isLoading
                ? AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      final progress = _progressAnimation.value;

                      const double horizontalAmplitude = 18.0;
                      const double verticalAmplitude = 6.0;

                      final double xOffset = -horizontalAmplitude +
                          progress * (2 * horizontalAmplitude);
                      final double yOffset =
                          sin(progress * pi) * verticalAmplitude;

                      const double baseAngle = -pi / 4.5;
                      const double tiltBackAngle = -pi / 8;
                      const double tiltRange = tiltBackAngle - baseAngle;

                      final double currentAngle = baseAngle +
                          tiltRange * sin(_animationController.value * pi);
                      return Transform.translate(
                        offset: Offset(xOffset, yOffset),
                        child: Transform.rotate(
                          angle: currentAngle,
                          child: const Icon(
                            Icons.edit_outlined,
                            color: AppColor.orange,
                            size: 48,
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
