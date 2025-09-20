import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicklo_app/provider/theme_provider.dart';

class ThemeSwitchButton extends ConsumerWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
  final isLightMode = themeMode == ThemeMode.light;
    return SizedBox(
      child:  IconButton(
       icon : Icon(
        isLightMode
          ? Icons.nightlight_round
          : Icons.wb_sunny,
        color: isLightMode ? Colors.white : Colors.black,
        ),
      
        onPressed: (){
          ref.read(themeProvider.notifier).state =
           themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light; 
        },
                            ),
    );
  }
}