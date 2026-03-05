import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../config/routes/routes.dart';
import '../../../config/themes/color_tokens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _starsController;
  late AnimationController _rocketController;
  late List<_Star> _stars;
  final _random = Random();

  @override
  void initState() {
    super.initState();

    // Status bar transparente para inmersión total
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    _stars = List.generate(80, (_) => _Star.random(_random));

    _starsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Cohete arranca inmediatamente
    _rocketController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) context.go(Routes.login);
    });
  }

  @override
  void dispose() {
    _starsController.dispose();
    _rocketController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: ColorTokens.spaceBlack,
      body: Stack(
        children: [
          // Stars — aparecen inmediatamente
          AnimatedBuilder(
            animation: _starsController,
            builder: (context, _) {
              return CustomPaint(
                size: size,
                painter: _StarsPainter(
                  stars: _stars,
                  animation: _starsController.value,
                ),
              );
            },
          ),

          // Glow radial sutil — sin delay
          Center(
            child: Container(
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    ColorTokens.spaceXBlue.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 800.ms, curve: Curves.easeOut)
              .scale(
                begin: const Offset(0.5, 0.5),
                end: const Offset(1.2, 1.2),
                duration: 2500.ms,
                curve: Curves.easeOut,
              ),

          // Contenido principal
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Cohete con llama — arranca inmediato
                AnimatedBuilder(
                  animation: _rocketController,
                  builder: (context, child) {
                    final progress = Curves.easeOut.transform(
                      _rocketController.value,
                    );
                    return Transform.translate(
                      offset: Offset(0, 30 * (1 - progress)),
                      child: Opacity(
                        opacity: progress.clamp(0.0, 1.0),
                        child: child,
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Llama
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 30,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                center: Alignment.topCenter,
                                colors: [
                                  ColorTokens.rocketOrange.withValues(alpha: 0.6),
                                  ColorTokens.launchYellow.withValues(alpha: 0.2),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          )
                              .animate(onPlay: (c) => c.repeat(reverse: true))
                              .scaleY(begin: 0.8, end: 1.3, duration: 300.ms)
                              .fadeIn(duration: 200.ms),
                        ),
                        // Cohete
                        const Icon(
                          Icons.rocket_launch_rounded,
                          size: 80,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // SPACE — aparece rápido
                Text(
                  'SPACE',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 16,
                    height: 1,
                    shadows: [
                      Shadow(
                        color: ColorTokens.spaceXBlue.withValues(alpha: 0.8),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                )
                    .animate()
                    .fadeIn(delay: 100.ms, duration: 600.ms)
                    .slideX(begin: -0.1, end: 0, duration: 600.ms),

                Transform.translate(
                  offset: const Offset(2, -8),
                  child: Text(
                    'X',
                    style: TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 8,
                      height: 1,
                      shadows: [
                        Shadow(
                          color: ColorTokens.spaceXBlue.withValues(alpha: 0.8),
                          blurRadius: 30,
                        ),
                        Shadow(
                          color: ColorTokens.rocketOrange.withValues(alpha: 0.5),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 600.ms)
                    .slideX(begin: 0.2, end: 0, duration: 600.ms),

                const SizedBox(height: 12),

                // Línea divisora
                Container(
                  width: 60,
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        ColorTokens.spaceXBlue,
                        Colors.transparent,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(1),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 500.ms)
                    .scaleX(begin: 0, end: 1, delay: 600.ms, duration: 500.ms),

                const SizedBox(height: 16),

                // Subtítulo
                Text(
                  'LAUNCHES',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.5),
                    letterSpacing: 8,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 800.ms, duration: 600.ms),

                const SizedBox(height: 60),

                // Loading
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ColorTokens.spaceXBlue.withValues(alpha: 0.6),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 1000.ms, duration: 500.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Star {
  final double x;
  final double y;
  final double size;
  final double blinkSpeed;
  final double blinkOffset;

  const _Star({
    required this.x,
    required this.y,
    required this.size,
    required this.blinkSpeed,
    required this.blinkOffset,
  });

  factory _Star.random(Random random) {
    return _Star(
      x: random.nextDouble(),
      y: random.nextDouble(),
      size: random.nextDouble() * 2.5 + 0.5,
      blinkSpeed: random.nextDouble() * 2 + 0.5,
      blinkOffset: random.nextDouble() * 2 * pi,
    );
  }
}

class _StarsPainter extends CustomPainter {
  final List<_Star> stars;
  final double animation;

  _StarsPainter({required this.stars, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    for (final star in stars) {
      final opacity = (sin(animation * 2 * pi * star.blinkSpeed + star.blinkOffset) + 1) / 2;
      final paint = Paint()
        ..color = Colors.white.withValues(alpha: opacity * 0.8)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, star.size * 0.5);

      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_StarsPainter oldDelegate) => true;
}
