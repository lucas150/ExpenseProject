import 'package:expense_project/app/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: palette[AppColors.surface],
    elevation: 0,
    centerTitle: false,
    title: Text(
      'Note-Go',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: palette[AppColors.onSurface],
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.settings_outlined,
          color: palette[AppColors.onSurface],
        ),
        onPressed: () => context.go('/settings'),
      ),
    ],
  );
}
