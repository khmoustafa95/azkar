import 'package:flutter/material.dart';

/// Shows a short floating snackbar (Arabic-friendly).
void showAppSnackBar(
  BuildContext context, {
  required String message,
  bool isError = false,
}) {
  final messenger = ScaffoldMessenger.maybeOf(context);
  if (messenger == null) return;
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? const Color(0xFFB3261E) : null,
      content: Text(
        message,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}

/// Safe snackbar after async — pass [messenger] captured before await.
void showAppSnackBarFromMessenger(
  ScaffoldMessengerState? messenger, {
  required String message,
  bool isError = false,
}) {
  if (messenger == null) return;
  messenger.hideCurrentSnackBar();
  messenger.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isError ? const Color(0xFFB3261E) : null,
      content: Text(
        message,
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
