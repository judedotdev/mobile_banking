import 'package:flutter/material.dart';
import 'package:mobile_banking/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C56F0),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/splashscreen.png',
                  width: 320,
                  height: 204,
                ), // Add your logo
              ),
              const SizedBox(height: 20),
              const Text(
                'Jane Cooper',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Ut enim ad minima veniam, quis nostrum exercitat ionem ullam corporis suscipit laboriosam,',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              Align(
                alignment: Alignment.bottomRight, // Align to bottom-right
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), // Makes the button circular
                    padding:
                        const EdgeInsets.all(20.0), // Space inside the button
                    backgroundColor:
                        Colors.white, // Background color of the button
                  ),
                  child: const Icon(
                    Icons.arrow_forward, // Right-pointing arrow icon
                    color: Colors.black, // Color of the arrow
                    size: 24.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
