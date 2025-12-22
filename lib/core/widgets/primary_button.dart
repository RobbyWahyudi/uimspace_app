import 'package:flutter/material.dart';
import '../theme/space_theme.dart';

/// UIMSpace Primary Button
/// Button utama dengan style Space Learning
class SpacePrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isExpanded;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Size? size;

  const SpacePrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isExpanded = false,
    this.leadingIcon,
    this.trailingIcon,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidget = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: size != null ? ElevatedButton.styleFrom(minimumSize: size) : null,
      child: isLoading
          ? const SizedBox(
              width: SpaceDimensions.iconMd,
              height: SpaceDimensions.iconMd,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  SpaceColors.textOnPrimary,
                ),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingIcon != null) ...[
                  Icon(leadingIcon, size: SpaceDimensions.iconMd),
                  const SizedBox(width: SpaceDimensions.spacing8),
                ],
                Text(text),
                if (trailingIcon != null) ...[
                  const SizedBox(width: SpaceDimensions.spacing8),
                  Icon(trailingIcon, size: SpaceDimensions.iconMd),
                ],
              ],
            ),
    );

    return isExpanded
        ? SizedBox(width: double.infinity, child: buttonWidget)
        : buttonWidget;
  }
}

/// UIMSpace Secondary Button (Outlined)
class SpaceSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isExpanded;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  const SpaceSecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isExpanded = false,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidget = OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: SpaceDimensions.iconMd,
              height: SpaceDimensions.iconMd,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(SpaceColors.primary),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingIcon != null) ...[
                  Icon(leadingIcon, size: SpaceDimensions.iconMd),
                  const SizedBox(width: SpaceDimensions.spacing8),
                ],
                Text(text),
                if (trailingIcon != null) ...[
                  const SizedBox(width: SpaceDimensions.spacing8),
                  Icon(trailingIcon, size: SpaceDimensions.iconMd),
                ],
              ],
            ),
    );

    return isExpanded
        ? SizedBox(width: double.infinity, child: buttonWidget)
        : buttonWidget;
  }
}

/// UIMSpace Text Button
class SpaceTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final Color? textColor;

  const SpaceTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: textColor != null
          ? TextButton.styleFrom(foregroundColor: textColor)
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            Icon(leadingIcon, size: SpaceDimensions.iconMd),
            const SizedBox(width: SpaceDimensions.spacing8),
          ],
          Text(text),
          if (trailingIcon != null) ...[
            const SizedBox(width: SpaceDimensions.spacing8),
            Icon(trailingIcon, size: SpaceDimensions.iconMd),
          ],
        ],
      ),
    );
  }
}

/// UIMSpace Icon Button dengan background
class SpaceIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;
  final String? tooltip;

  const SpaceIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = size ?? SpaceDimensions.buttonHeightSmall;

    Widget button = Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: backgroundColor ?? SpaceColors.surfaceVariant,
        borderRadius: BorderRadius.circular(SpaceDimensions.radiusSm),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor ?? SpaceColors.textPrimary,
          size: buttonSize * 0.5,
        ),
        padding: EdgeInsets.zero,
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}

/// UIMSpace Glow Button (untuk aksi penting/CTA)
class SpaceGlowButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;

  const SpaceGlowButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: SpaceDimensions.buttonRadius,
        boxShadow: [
          BoxShadow(
            color: SpaceColors.primary.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: SpaceColors.primary,
          foregroundColor: SpaceColors.textOnPrimary,
        ),
        child: isLoading
            ? const SizedBox(
                width: SpaceDimensions.iconMd,
                height: SpaceDimensions.iconMd,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    SpaceColors.textOnPrimary,
                  ),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: SpaceDimensions.iconMd),
                    const SizedBox(width: SpaceDimensions.spacing8),
                  ],
                  Text(text),
                ],
              ),
      ),
    );
  }
}
