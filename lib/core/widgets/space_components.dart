import 'package:flutter/material.dart';
import '../theme/space_theme.dart';

/// UIMSpace Avatar
class SpaceAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double size;
  final Color? backgroundColor;
  final Color? iconColor;
  final VoidCallback? onTap;

  const SpaceAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = SpaceDimensions.avatarMd,
    this.backgroundColor,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? SpaceColors.primary.withValues(alpha: 0.2),
        image: imageUrl != null
            ? DecorationImage(image: NetworkImage(imageUrl!), fit: BoxFit.cover)
            : null,
      ),
      child: imageUrl == null
          ? Center(
              child: Icon(
                Icons.person_rounded,
                color: iconColor ?? SpaceColors.primary,
                size: size * 0.6,
              ),
            )
          : null,
    );

    if (onTap != null) {
      avatar = GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }
}

/// UIMSpace Badge/Chip
class SpaceBadge extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool isOutlined;

  const SpaceBadge({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.isOutlined = false,
  });

  factory SpaceBadge.success(String text) =>
      SpaceBadge(text: text, backgroundColor: SpaceColors.success);
  factory SpaceBadge.warning(String text) => SpaceBadge(
    text: text,
    backgroundColor: SpaceColors.warning,
    textColor: SpaceColors.background,
  );
  factory SpaceBadge.error(String text) =>
      SpaceBadge(text: text, backgroundColor: SpaceColors.error);
  factory SpaceBadge.info(String text) =>
      SpaceBadge(text: text, backgroundColor: SpaceColors.info);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? SpaceColors.primary;
    final fgColor = textColor ?? SpaceColors.textOnPrimary;

    return Container(
      padding: SpaceDimensions.chipPadding,
      decoration: BoxDecoration(
        color: isOutlined ? Colors.transparent : bgColor,
        borderRadius: SpaceDimensions.chipRadius,
        border: isOutlined ? Border.all(color: bgColor) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: SpaceDimensions.iconSm,
              color: isOutlined ? bgColor : fgColor,
            ),
            const SizedBox(width: SpaceDimensions.spacing4),
          ],
          Text(
            text,
            style: SpaceTextStyles.badge.copyWith(
              color: isOutlined ? bgColor : fgColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// UIMSpace Section Header
class SpaceSectionHeader extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onAction;
  final IconData? actionIcon;

  const SpaceSectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onAction,
    this.actionIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: SpaceDimensions.spacing8,
        bottom: SpaceDimensions.spacing16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: SpaceTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (actionText != null || actionIcon != null)
            GestureDetector(
              onTap: onAction,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (actionText != null)
                    Text(
                      actionText!,
                      style: SpaceTextStyles.bodySmall.copyWith(
                        color: SpaceColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (actionIcon != null)
                    Icon(
                      actionIcon,
                      size: SpaceDimensions.iconMd,
                      color: SpaceColors.primary,
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// UIMSpace Divider
class SpaceDivider extends StatelessWidget {
  final double? height;
  final EdgeInsetsGeometry? margin;

  const SpaceDivider({super.key, this.height, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1,
      margin:
          margin ??
          const EdgeInsets.symmetric(vertical: SpaceDimensions.spacing16),
      color: SpaceColors.divider,
    );
  }
}

/// UIMSpace Progress Bar
class SpaceProgressBar extends StatelessWidget {
  final double value;
  final Color? color;
  final Color? backgroundColor;
  final double height;
  final String? label;

  const SpaceProgressBar({
    super.key,
    required this.value,
    this.color,
    this.backgroundColor,
    this.height = 8,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label!, style: SpaceTextStyles.labelSmall),
              Text(
                '${(value * 100).toInt()}%',
                style: SpaceTextStyles.labelSmall.copyWith(
                  color: color ?? SpaceColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: SpaceDimensions.spacing8),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: LinearProgressIndicator(
            value: value,
            minHeight: height,
            backgroundColor: backgroundColor ?? SpaceColors.surfaceVariant,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? SpaceColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
