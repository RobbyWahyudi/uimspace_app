import 'package:flutter/material.dart';
import '../theme/space_theme.dart';

/// UIMSpace Loading Indicator
/// Loading indicator dengan berbagai variasi untuk tema Space Learning
class SpaceLoadingIndicator extends StatelessWidget {
  final double? size;
  final double strokeWidth;
  final Color? color;

  const SpaceLoadingIndicator({
    super.key,
    this.size,
    this.strokeWidth = 3,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? SpaceDimensions.icon2xl,
      height: size ?? SpaceDimensions.icon2xl,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? SpaceColors.primary),
      ),
    );
  }
}

/// Loading indicator untuk full screen
class SpaceLoadingScreen extends StatelessWidget {
  final String? message;
  final Color? backgroundColor;

  const SpaceLoadingScreen({super.key, this.message, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? SpaceColors.background,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated glow effect
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: SpaceColors.primary.withValues(alpha: 0.3),
                    blurRadius: 24,
                    spreadRadius: 8,
                  ),
                ],
              ),
              child: const SpaceLoadingIndicator(size: 48),
            ),
            if (message != null) ...[
              const SizedBox(height: SpaceDimensions.spacing24),
              Text(
                message!,
                style: SpaceTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Loading overlay untuk ditampilkan di atas konten
class SpaceLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;

  const SpaceLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: SpaceColors.overlay,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SpaceLoadingIndicator(),
                    if (message != null) ...[
                      const SizedBox(height: SpaceDimensions.spacing16),
                      Text(
                        message!,
                        style: SpaceTextStyles.bodyMedium.copyWith(
                          color: SpaceColors.textPrimary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Shimmer loading effect untuk skeleton loading
class SpaceShimmerLoading extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const SpaceShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  State<SpaceShimmerLoading> createState() => _SpaceShimmerLoadingState();
}

class _SpaceShimmerLoadingState extends State<SpaceShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? SpaceDimensions.cardRadius,
            gradient: LinearGradient(
              begin: Alignment(_animation.value, 0),
              end: Alignment(_animation.value + 1, 0),
              colors: [
                SpaceColors.surfaceVariant,
                SpaceColors.surfaceVariant.withValues(alpha: 0.5),
                SpaceColors.surfaceVariant,
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Skeleton card untuk loading state
class SpaceSkeletonCard extends StatelessWidget {
  final double? height;

  const SpaceSkeletonCard({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 120,
      padding: SpaceDimensions.cardPadding,
      decoration: BoxDecoration(
        color: SpaceColors.surface,
        borderRadius: SpaceDimensions.cardRadius,
        border: Border.all(color: SpaceColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SpaceShimmerLoading(
            width: 150,
            height: 16,
            borderRadius: BorderRadius.all(
              Radius.circular(SpaceDimensions.radiusXs),
            ),
          ),
          const SizedBox(height: SpaceDimensions.spacing12),
          const SpaceShimmerLoading(
            width: double.infinity,
            height: 12,
            borderRadius: BorderRadius.all(
              Radius.circular(SpaceDimensions.radiusXs),
            ),
          ),
          const SizedBox(height: SpaceDimensions.spacing8),
          SpaceShimmerLoading(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 12,
            borderRadius: const BorderRadius.all(
              Radius.circular(SpaceDimensions.radiusXs),
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton list untuk loading state
class SpaceSkeletonList extends StatelessWidget {
  final int itemCount;
  final double itemHeight;
  final double spacing;

  const SpaceSkeletonList({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 80,
    this.spacing = SpaceDimensions.spacing12,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) => SpaceSkeletonCard(height: itemHeight),
    );
  }
}
