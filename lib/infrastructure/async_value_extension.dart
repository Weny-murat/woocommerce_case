import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showSnackbarOnChange(BuildContext context) {
    if (!isRefreshing && hasError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    } else if (hasValue) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('İşlem Başarılı')),
      );
    }
  }
}
