import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.yellow, Colors.black],
          ),
        ),
        child: Center(
          child: Container(
            width: 340,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.95),
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [BoxShadow(blurRadius: 30, color: Colors.black12)],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo.png', height: 56),
                const SizedBox(height: 14),
                Text('TheBites', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 6),
                Text('Fresh. Fast. Secure.', style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 18),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}