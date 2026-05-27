import 'package:farmacia_app/app/app_routes.dart';
import 'package:flutter/material.dart';

void popOrGoToAttendantHome(BuildContext context) {
  if (!context.mounted) {
    return;
  }

  final navigator = Navigator.of(context);
  if (navigator.canPop()) {
    navigator.pop();
    return;
  }

  navigator.pushReplacementNamed(AppRoutes.homeAttendant);
}

void handleAttendantBack(BuildContext context, bool didPop) {
  if (didPop) {
    return;
  }

  popOrGoToAttendantHome(context);
}
