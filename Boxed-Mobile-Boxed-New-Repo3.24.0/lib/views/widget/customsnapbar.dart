import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message) {
    final overlay = Overlay.of(context);

    if (overlay == null) return; // Ensure the overlay is available.

    // Create the OverlayEntry
    final entry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 0, // Display at the very bottom
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9), // Snackbar background color
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8), // Rounded corners at the top
              ),
            ),
            child: Center(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Insert the OverlayEntry
    overlay.insert(entry);

    // Remove the snackbar after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      entry.remove();
    });
  }
}
