import 'package:animated_onboard_screen/animated_onboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding Screen Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnboardingScreen(
        pages: [
          OnboardingPage(
            title: 'Convenience',
            description:
                'Control your home devices using a single app from anywhere in the world.',
            imagePath: 'assets/images/onboarding/onboarding_1.png',
          ),
          OnboardingPage(
            title: 'Stay informed',
            description:
                'Instant notifications of any alerts and system status.',
            imagePath: 'assets/images/onboarding/onboarding_2.png',
          ),
          OnboardingPage(
            title: 'Automate',
            description:
                'Switch through different scenes and quick actions for fast management of your home.',
            imagePath: 'assets/images/onboarding/onboarding_3.png',
          ),
        ],
        onComplete: (isSkipped) {
          // Navigate to your main app screen
          if (isSkipped) {
            print('Onboarding completed by skipping');
          } else {
            print('Onboarding completed');
          }
        },
      ),
    );
  }
}
