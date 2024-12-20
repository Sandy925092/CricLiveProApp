import 'package:flutter/material.dart';

class WelcomeScreens extends StatefulWidget {
  const WelcomeScreens({super.key});

  @override
  State<WelcomeScreens> createState() => _WelcomeScreensState();
}

class _WelcomeScreensState extends State<WelcomeScreens> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    // Use addPostFrameCallback to ensure the context is fully initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Preload the images after the widget tree has been built
      precacheImage(AssetImage('assets/images/welcome1.png'), context);
      precacheImage(AssetImage('assets/images/welcome2.png'), context);

      // Automatically scroll from the first page to the second after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          _pageController.animateToPage(
            1,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int pageIndex) {
    if (pageIndex == 1) {
      // Navigate to HomeScreen after 2 seconds on the second page
      Future.delayed(Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          _buildSplashPage(context, 'assets/images/welcome1.png'),
          _buildSplashPage(context, 'assets/images/welcome2.png', isLast: true),
        ],
      ),
    );
  }

  Widget _buildSplashPage(BuildContext context, String imagePath, {bool isLast = false}) {
    return   Image.asset(
      imagePath,
      fit: BoxFit.cover,
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Welcome to Home Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
