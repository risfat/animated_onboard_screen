import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onboarding_page.dart';

/// A customizable animated onboarding screen widget.
///
/// This widget creates an onboarding experience with smooth animations
/// and transitions between pages. It supports custom pages, skip and next
/// buttons, and a completion callback.
///
/// Example usage:
/// ```dart
/// OnboardingScreen(
///   pages: [
///     OnboardingPage(
///       title: 'Welcome',
///       description: 'Get started with our app!',
///       imagePath: 'assets/welcome.png',
///     ),
///     // Add more pages...
///   ],
///   onComplete: (bool skipped) {
///     // Handle onboarding completion
///   },
/// )
/// ```
class OnboardingScreen extends StatefulWidget {
  /// The list of [OnboardingPage] objects to display in the onboarding screen.
  final List<OnboardingPage> pages;

  /// Callback function called when the onboarding is completed or skipped.
  ///
  /// The boolean parameter indicates whether the onboarding was skipped (true)
  /// or completed normally (false).
  final void Function(bool skipped) onComplete;

  /// Custom widget to use as the skip button.
  ///
  /// If not provided, a default text button with "SKIP" will be used.
  final Widget? skipButton;

  /// Custom widget to use as the next button.
  ///
  /// If not provided, a default circular button with an arrow icon will be used.
  final Widget? nextButton;

  /// Creates an [OnboardingScreen] widget.
  ///
  /// The [pages] parameter is required and must contain at least one page.
  /// The [onComplete] callback is required to handle the completion of the onboarding process.
  OnboardingScreen({
    super.key,
    required this.pages,
    required this.onComplete,
    this.skipButton,
    this.nextButton,
  }) : assert(pages.isNotEmpty, 'At least one onboarding page is required');

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (var page in widget.pages) {
      precacheImage(AssetImage(page.imagePath), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _buildPage(widget.pages[index]);
            },
          ),
          Positioned(
            top: 40,
            right: 20,
            child:
                widget.skipButton ??
                TextButton(
                  onPressed: _handleSkip,
                  child: Text(
                    'SKIP',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: widget.pages.length,
                    effect: WormEffect(
                      dotColor: Colors.grey.shade400,
                      activeDotColor: Colors.blue,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 8,
                    ),
                  ),
                  widget.nextButton ??
                      ElevatedButton(
                        onPressed: _handleNext,
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.blue,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds an individual onboarding page with animations.
  Widget _buildPage(OnboardingPage page) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(page.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                page.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2),
              SizedBox(height: 10),
              Text(
                    page.description,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                  .animate()
                  .fadeIn(duration: 500.ms, delay: 200.ms)
                  .slideY(begin: 0.2),
              SizedBox(height: 150),
            ],
          ),
        ),
      ),
    ).animate().custom(
      duration: 600.ms,
      builder: (context, value, child) {
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5 - (value * 0.5)),
            BlendMode.srcOver,
          ),
          child: child,
        );
      },
    );
  }

  /// Handles the skip action, calling the [onComplete] callback with `true`.
  void _handleSkip() async {
    widget.onComplete(true);
  }

  /// Handles the next action, moving to the next page or calling [onComplete] if on the last page.
  void _handleNext() async {
    if (_currentPage < widget.pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onComplete(false);
    }
  }
}
