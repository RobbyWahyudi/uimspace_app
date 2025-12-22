import 'package:flutter/material.dart';
import '../theme/space_theme.dart';

/// UIMSpace Input Field
/// Text field dengan style Space Learning
class SpaceTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;
  final Widget? suffix;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final FocusNode? focusNode;
  final bool autofocus;

  const SpaceTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffix,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.onChanged,
    this.onEditingComplete,
    this.focusNode,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: SpaceTextStyles.labelMedium),
          const SizedBox(height: SpaceDimensions.spacing8),
        ],
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          maxLength: maxLength,
          enabled: enabled,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          focusNode: focusNode,
          autofocus: autofocus,
          style: SpaceTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    size: SpaceDimensions.iconMd,
                    color: SpaceColors.textSecondary,
                  )
                : null,
            suffix: suffix,
          ),
        ),
      ],
    );
  }
}

/// Password field dengan toggle visibility
class SpacePasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;

  const SpacePasswordField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.textInputAction,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  State<SpacePasswordField> createState() => _SpacePasswordFieldState();
}

class _SpacePasswordFieldState extends State<SpacePasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SpaceTextField(
      controller: widget.controller,
      label: widget.label,
      hint: widget.hint ?? 'Masukkan password',
      errorText: widget.errorText,
      obscureText: _obscureText,
      textInputAction: widget.textInputAction,
      prefixIcon: Icons.lock_outline,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      suffix: IconButton(
        onPressed: () => setState(() => _obscureText = !_obscureText),
        icon: Icon(
          _obscureText
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
          size: SpaceDimensions.iconMd,
          color: SpaceColors.textSecondary,
        ),
      ),
    );
  }
}

/// Search field
class SpaceSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool autofocus;

  const SpaceSearchField({
    super.key,
    this.controller,
    this.hint,
    this.onChanged,
    this.onClear,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      autofocus: autofocus,
      style: SpaceTextStyles.bodyMedium,
      decoration: InputDecoration(
        hintText: hint ?? 'Cari...',
        prefixIcon: const Icon(
          Icons.search,
          size: SpaceDimensions.iconMd,
          color: SpaceColors.textSecondary,
        ),
        suffixIcon: controller != null && controller!.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  controller!.clear();
                  onClear?.call();
                },
                icon: const Icon(
                  Icons.close,
                  size: SpaceDimensions.iconMd,
                  color: SpaceColors.textSecondary,
                ),
              )
            : null,
        contentPadding: SpaceDimensions.inputPadding,
        filled: true,
        fillColor: SpaceColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: SpaceDimensions.chipRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: SpaceDimensions.chipRadius,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: SpaceDimensions.chipRadius,
          borderSide: const BorderSide(color: SpaceColors.primary),
        ),
      ),
    );
  }
}
