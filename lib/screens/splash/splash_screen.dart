import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A fully custom splash screen that shows the exact branding images
/// (no OS masking) and scales responsively on all devices.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();

    // Navigate after a short delay; replace with actual app init when ready.
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      // Navigate to home route via GoRouter
      context.go('/');
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    // Responsive sizing: logo ~28% of shortest side, min/max clamped
    final shortestSide = media.size.shortestSide;
    final logoSize = shortestSide * 0.28;
    final clampedLogo = logoSize.clamp(96.0, 192.0);

    // Branding width ~55% of width, clamped for readability
    final brandingWidth = (media.size.width * 0.55).clamp(160.0, 360.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF78DA7), // same as pubspec color
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _fadeIn,
          builder: (context, child) {
            return Opacity(opacity: _fadeIn.value, child: child);
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  // Center logo
                  Expanded(
                    child: Center(
                      child: Image.asset(
                        'assets/logo/icon.png',
                        width: clampedLogo.toDouble(),
                        height: clampedLogo.toDouble(),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  // Bottom branding wordmark
                  Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: Image.asset(
                      'assets/logo/texticon.png',
                      width: brandingWidth.toDouble(),
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
