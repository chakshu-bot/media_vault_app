import 'dart:async';
import 'package:flutter/material.dart';

Future<T> retry<T>(FutureOr<T> Function() function, {int retryCount = 3}) async {
  while (retryCount > 0) {
    try {
      return await function();
    } catch (e) {
      retryCount--;

      if (retryCount == 0) {
        rethrow;
      }
    }
  } return Future.error( ErrorHint );
}
