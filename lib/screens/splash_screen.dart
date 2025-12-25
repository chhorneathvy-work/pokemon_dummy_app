import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../main_page.dart';
import '../widgets/typewritter_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _logoScale;

  bool showLogo = false;
  bool showSubtitle = false;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _logoScale = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => showSubtitle = true);
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  // Use async/await so we can safely navigate after a delay.
  // This allows checking `mounted` before using BuildContext,
  // preventing navigation after the widget is disposed.
  void _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const MainPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TypewriterTextWidget(
              text: "Welcome to Pokémon Store",
              speed: const Duration(milliseconds: 60),
              style: const TextStyle(
                fontFamily: "Lato",
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.outlineDark,
              ),
              onFinished: () {
                setState(() => showLogo = true);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _logoController.forward();
                });
              },
            ),

            const SizedBox(height: 35),

            if (showLogo)
              ScaleTransition(
                scale: _logoScale,
                child: Image.asset(
                  'assets/icon/pokemon_logo.png',
                  width: 160,
                  height: 160,
                ),
              ),

            const SizedBox(height: 25),

            if (showSubtitle)
              TypewriterTextWidget(
                text: "Buy them all!",
                speed: const Duration(milliseconds: 80),
                style: const TextStyle(
                  fontFamily: "Lato",
                  fontSize: 14,
                  color: AppColors.outlineDark,
                ),
                onFinished: _navigateAfterSplash,
              ),
          ],
        ),
      ),
    );
  }
}
