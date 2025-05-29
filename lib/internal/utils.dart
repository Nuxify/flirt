import 'dart:developer';

import 'package:flutter/material.dart';

/// Triggers a snackbar notification based on user parameters
///
/// [context] The current widget tree's `BuildContext`
///
/// [isSuccessful] Determines whether the snackbar will be green or red
///
/// [message] The message of the snackbar
void showSnackbar(
  BuildContext context, {
  required bool isSuccessful,
  required String message,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: isSuccessful ? Colors.green : Colors.red,
      content: Text(
        message,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white),
      ),
    ),
  );
}

FadeTransition fadeTransition(
  Animation<double> animation,
  __,
  Widget child,
) {
  const double begin = 0.0;
  const double end = 1.0;
  final Tween<double> tween = Tween<double>(begin: begin, end: end);
  final CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOut,
  );
  return FadeTransition(
    opacity: tween.animate(curvedAnimation),
    child: child,
  );
}

/// Logs an error with the function name extracted from the stack trace.
///
/// [e] The error object to be logged.
///
/// [stacktrace] The stack trace of the error.
///
/// Returns a string representation of the error including the function name.
void logError(dynamic e, StackTrace stacktrace) {
  // Parse the stack trace to extract the current function name
  final String functionName = _getFunctionName(stacktrace);
  log('Error in function: $functionName - $e');
}

/// Extracts the function name from the stack trace.
///
/// [stacktrace] The stack trace from which to extract the function name.
///
/// Returns the extracted function name as a string.
String _getFunctionName(StackTrace stacktrace) {
  // Extracting the topmost line from the stack trace, which contains the function name
  final String traceString = stacktrace.toString().split('\n')[0];
  // Parsing the line to extract only the function name
  final String functionName = traceString.split(' ').reversed.elementAt(1);
  return functionName;
}
