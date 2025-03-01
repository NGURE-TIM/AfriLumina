import 'package:afrilumina/core/core.dart';
import 'package:flutter/material.dart';


/// A reusable error card widget that displays an error message
/// and provides an optional retry button.
///
/// This widget is useful for displaying errors in the UI, such as
/// network failures or API response errors.
///
/// **Parameters:**
/// - [message] (required): The error message to display.
/// - [retryAction] (optional): A callback function to retry the failed operation.
class ErrorCard extends StatelessWidget {
  final String message;
  final VoidCallback? retryAction;

  const ErrorCard({super.key, required this.message, this.retryAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.errorColor),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: retryAction,
            child: const Text("Retry",style:TextStyle(color: Colors.black) ,),
          ),
        ],
      ),
    );
  }
}
