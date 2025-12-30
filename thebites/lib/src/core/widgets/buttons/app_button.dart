import 'package:flutter/material.dart';
import 'package:thebites/src/core/theme/colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool outlined;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Text(text);

    final style = outlined
        ? OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            side: const BorderSide(color: AppColors.primary),
            foregroundColor: AppColors.primary,
            textStyle: Theme.of(context).textTheme.labelLarge,
          )
        : FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            textStyle: Theme.of(context).textTheme.labelLarge,
          );

    return outlined
        ? OutlinedButton(onPressed: isLoading ? null : onPressed, style: style, child: child)
        : FilledButton(onPressed: isLoading ? null : onPressed, style: style, child: child);
  }
}