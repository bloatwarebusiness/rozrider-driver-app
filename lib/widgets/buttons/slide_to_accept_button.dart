import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SlideToAcceptButton extends StatefulWidget {
  final VoidCallback onAccept;
  final String text;
  final Widget sliderIcon;

  const SlideToAcceptButton({
    super.key,
    required this.onAccept,
    this.text = 'Swipe to accept ride',
    this.sliderIcon = const Icon(
      Icons.double_arrow_rounded,
      color: AppTheme.primaryColor,
      size: 28,
    ),
  });

  @override
  State<SlideToAcceptButton> createState() => _SlideToAcceptButtonState();
}

class _SlideToAcceptButtonState extends State<SlideToAcceptButton>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  bool _accepted = false;

  late AnimationController _controller;
  late Animation<double> _bounceBackAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _bounceBackAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.addListener(() {
      setState(() {
        _dragPosition = _bounceBackAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ------------------------------
  // USER DRAGGING THE SLIDER
  // ------------------------------
  void _onPanUpdate(DragUpdateDetails details) {
    if (_accepted) return;

    setState(() {
      _dragPosition += details.delta.dx;

      final maxPos = MediaQuery.of(context).size.width - 140; // slide limit

      if (_dragPosition < 0) _dragPosition = 0;
      if (_dragPosition > maxPos) {
        _dragPosition = maxPos;
        _onAccept();
      }
    });
  }

  // ------------------------------
  // SLIDE COMPLETED
  // ------------------------------
  void _onAccept() {
    if (_accepted) return;

    setState(() {
      _accepted = true;
    });

    // Success callback
    Future.delayed(const Duration(milliseconds: 350), () {
      widget.onAccept();
    });
  }

  // ------------------------------
  // USER LEAVES SLIDER MIDWAY
  // ------------------------------
  void _onPanEnd(DragEndDetails details) {
    if (_accepted) return;

    _bounceBackAnimation = Tween<double>(
      begin: _dragPosition,
      end: 0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.of(context).size.width - 48;

    return Container(
      height: 64,
      width: width,
      decoration: BoxDecoration(
        color: _accepted
            ? AppTheme.successColor
            : (isDark ? AppTheme.darkBorder : AppTheme.lightBorder),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull),
      ),
      child: Stack(
        children: [
          // CENTER TEXT
          Center(
            child: Text(
              _accepted ? 'Ride Accepted!' : widget.text,
              style: TextStyle(
                color: _accepted
                    ? Colors.white
                    : (isDark
                        ? AppTheme.darkTextSecondary
                        : AppTheme.lightTextSecondary),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // SLIDER BUTTON
          Positioned(
            left: _dragPosition,
            top: 0,
            bottom: 0,
            child: GestureDetector(
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 80,
                decoration: BoxDecoration(
                  color: _accepted
                      ? Colors.white
                      : (isDark ? AppTheme.darkSurface : Colors.white),
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: _accepted
                      ? const Icon(
                          Icons.check,
                          color: AppTheme.successColor,
                          size: AppTheme.iconSizeLG,
                        )
                      : widget.sliderIcon, // 🔥 ACTUAL ICON HERE
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
