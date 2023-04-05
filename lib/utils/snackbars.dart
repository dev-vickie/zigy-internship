import 'package:flutter/material.dart';

showErrorSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}

showSuccessSnackBar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.blue,
    ),
  );
}
