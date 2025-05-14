import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/themes/theme_cubit.dart';

class BadgeWrap extends StatelessWidget {
  BadgeWrap({super.key, required this.items, this.onDelete});
  final List<String> items;
  final void Function(String)? onDelete;
  @override
  Widget build(BuildContext context) {
    context.watch<ThemeCubit>();
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.w,
      children: items.map((item) => _buildBadge(context, item)).toList(),
    );
  }

  Widget _buildBadge(BuildContext context, String item) {
    Color color = _getRandomColor(context);
    return Stack(
      children: [
        Padding(
          padding:
              onDelete == null
                  ? const EdgeInsets.all(0)
                  : const EdgeInsets.only(top: 15, right: 15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color),
            ),
            child: Text(
              item,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color),
            ),
          ),
        ),
        if (onDelete != null)
          Positioned(
            top: -5,
            right: -5,
            child: IconButton(
              onPressed: () => onDelete!(item),
              icon: const Icon(Icons.delete, color: Colors.redAccent),
            ),
          ),
      ],
    );
  }

  final List<Color> _lightThemeColors = [
    Colors.black,
    Colors.blueGrey,
    Colors.brown,
    Colors.deepPurple,
    Colors.indigo,
    Colors.teal,
    Colors.deepOrange,
    Colors.grey[900]!,
    Colors.blue[900]!,
    Colors.green[900]!,
  ];
  final List<Color> _darkThemeColors = [
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.yellowAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.amberAccent,
    Colors.limeAccent,
    Colors.cyanAccent,
    Colors.tealAccent,
    // Colors.purpleAccent,
  ];
  Color _getRandomColor(BuildContext context) {
    Color randomColor = context.primaryColor;
    List<Color> color =
        context.read<ThemeCubit>().isDarkMode() ? _darkThemeColors : _lightThemeColors;
    final random = Random();
    return color[random.nextInt(color.length)];
  }
}
