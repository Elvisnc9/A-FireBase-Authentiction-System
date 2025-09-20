import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicklo_app/provider/theme_provider.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key,
    required this.isLightMode,
    required this.themeMode,
  });

  final bool isLightMode;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        child: IconButton(
          icon: Icon(
            isLightMode ? Icons.nightlight_round : Icons.wb_sunny,
            color: isLightMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            ref.read(themeProvider.notifier).state =
                themeMode == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
          },
        ),
      ),
    );
  }
}