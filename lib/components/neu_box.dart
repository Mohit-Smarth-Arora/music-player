import 'package:flutter/material.dart';
import 'package:mymusic/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  final double? neuBoxHeight;
  final double? neuBoxWidth;

  const NeuBox({super.key, required this.child,this.neuBoxHeight,this.neuBoxWidth});

  @override
  Widget build(BuildContext context) {

    bool isDarkMode  = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            // darker shadow on bottom right
            BoxShadow(
                color: isDarkMode ? Colors.grey.shade700: Colors.grey.shade500,
                blurRadius: 15,
                offset: const Offset(4, 4)),
          //   lighter shadow on bottom left
            BoxShadow(
                color: isDarkMode ? Colors.black : Colors.grey.shade500,
                blurRadius: 15,
                offset: const Offset(-4, -4)),
          ]),
      padding: const EdgeInsets.all(12),
      height: neuBoxHeight,
      width: neuBoxWidth,
      child: child,
    );
  }
}
