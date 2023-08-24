import 'package:flutter/material.dart';
import 'package:freeshare/main.dart';

import 'toast_builder.dart';

abstract class Toast {
  static void show(
    String text, {
    Duration duration = const Duration(seconds: 3),
  }) async {
    /// Insert
    BuildContext? context = MyApp.navigatorKey.currentContext;
    if (context == null) return;

    GlobalKey<ToastBuilderState> toastKey = GlobalKey();
    final overlay = Overlay.of(context);
    const animDuration = Duration(milliseconds: 333);
    final toast = OverlayEntry(
      builder: (context) => ToastBuilder(
        key: toastKey,
        text: text,
        animDuration: animDuration,
      ),
    );
    overlay.insert(toast);
    print("1 : ${toastKey.currentState?.isShow}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("2 : ${toastKey.currentState?.isShow}");
      toastKey.currentState?.isShow = true;
    });
    print("3 : ${toastKey.currentState?.isShow}");

    /// Remove
    await Future.delayed(duration);
    toastKey.currentState?.isShow = false;
    await Future.delayed(animDuration);
    toast.remove();
  }
}
