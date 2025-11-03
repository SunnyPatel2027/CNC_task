import 'package:flutter/material.dart';

snackBar({required BuildContext context, required String error}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
}
