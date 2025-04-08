# Animated Onboard Screen

A Flutter package for creating engaging and interactive animated onboarding screens.

<div style="text-align: center;"><img src="https://github.com/risfat/animated_onboarding_screen/raw/refs/heads/master/demo/demo.gif" width="150" alt="Demo GIF">
</div>

## Features

- Customizable animations for onboarding screens
- Smooth transitions between pages
- Easy-to-use API for creating onboarding experiences
- Support for various content types (text, images, icons)
- Customizable page indicators

## Getting started

To use this package, add `animated_onboard_screen` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  animated_onboard_screen: ^1.0.1
```

Then, run:

```
flutter pub get
```

## Usage

Import the package in your Dart code:

```dart
import 'package:animated_onboard_screen/animated_onboard_screen.dart';
```

Create an `OnboardingScreen` widget with a list of `OnboardingPage` objects:

```dart
OnboardingScreen(
  pages: [
    OnboardingPage(
      title: 'Welcome',
      description: 'Get started with our amazing app!',
      image: AssetImage('assets/welcome.png'),
    ),
    OnboardingPage(
      title: 'Features',
      description: 'Discover all the great features we offer.',
      image: AssetImage('assets/features.png'),
    ),
    OnboardingPage(
      title: 'Get Started',
      description: 'Ready to begin? Let\'s go!',
      image: AssetImage('assets/start.png'),
    ),
  ],
  onComplete: (isSkipped) {
  // Action on complete
  if (isSkipped) {
      print('Onboarding completed by skipping');
    } else {
      print('Onboarding completed');
    }
  },
)
```

## Additional information

For more detailed examples and advanced usage, please refer to the [example](https://github.com/risfat/animated_onboard_screen/tree/master/example) folder in the repository.

### Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, please file an issue on the [GitHub repository](https://github.com/risfat/animated_onboard_screen/issues).

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
