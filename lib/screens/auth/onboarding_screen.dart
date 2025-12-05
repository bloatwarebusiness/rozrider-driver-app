import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/buttons/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Welcome to RozRider',
      description:
          'Start your journey as a professional driver partner and earn on your terms.',
      icon: Image.network(
        "https://res.cloudinary.com/dv3gmxtuw/image/upload/v1764523354/om38m9mqwkoepkhfkqim.jpg",
        fit: BoxFit.cover,
      ),
    ),
    OnboardingPage(
      title: 'Flexible Working Hours',
      description:
          'Go online whenever you want and accept rides that fit your schedule.',
      icon:
          const Icon(Icons.access_time, size: 100, color: AppTheme.accentColor),
    ),
    OnboardingPage(
      title: 'Secure & Reliable',
      description:
          'Complete KYC verification, manage your documents, and drive safely.',
      icon: const Icon(Icons.verified_user,
          size: 100, color: AppTheme.accentColor),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _skip() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _skip,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: isDark
                        ? AppTheme.darkTextSecondary
                        : AppTheme.lightTextSecondary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) =>
                    _OnboardingPageWidget(page: _pages[index]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppTheme.accentColor
                        : (isDark ? AppTheme.darkBorder : AppTheme.lightBorder),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLG),
              child: PrimaryButton(
                text:
                    _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                onPressed: _nextPage,
                icon: Icons.arrow_forward,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------------------------------------
// ONBOARDING PAGE WITH ANIMATIONS
// --------------------------------------------------------

class _OnboardingPageWidget extends StatefulWidget {
  final OnboardingPage page;

  const _OnboardingPageWidget({Key? key, required this.page}) : super(key: key);

  @override
  State<_OnboardingPageWidget> createState() => _OnboardingPageWidgetState();
}

class _OnboardingPageWidgetState extends State<_OnboardingPageWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant _OnboardingPageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.forward(from: 0); // replay when page changes
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingXXL),
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ----------------- Circular Logo -----------------
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: widget.page.icon, // circular image/logo
                ),
              ),

              // --------------------------------------------------

              const SizedBox(height: AppTheme.spacingXXL),

              Text(
                widget.page.title,
                style: theme.textTheme.displayMedium?.copyWith(
                  color: isDark
                      ? AppTheme.darkTextPrimary
                      : AppTheme.lightTextPrimary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: AppTheme.spacingLG),

              Text(
                widget.page.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: isDark
                      ? AppTheme.darkTextSecondary
                      : AppTheme.lightTextSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --------------------------------------------------------
// ONBOARDING PAGE MODEL (UPDATED)
// --------------------------------------------------------

class OnboardingPage {
  final String title;
  final String description;
  final Widget icon;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
  });
}
