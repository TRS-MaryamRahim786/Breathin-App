import 'package:breathin_app/utilities/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void showNoInternetDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)), // Add rounded corners
      backgroundColor: Colors.grey[200], // Set a pleasant background color
      title: const Center(
        child: Text(
          "Oops, No Internet!", // Use a friendly title
          style: TextStyle(fontSize: 20, color: Colors.black87),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wifi_off,
            size: 60,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 15),
          const Text(
            "We can't reach the internet right now. Please check your connection and try again.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text(
            "Try Again",
            style: TextStyle(color: AppColors.black),
          ),
        ),
      ],
    ),
  );
}
