import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';

class WhyChooseUsWidget extends StatefulWidget {
  const WhyChooseUsWidget({super.key});

  @override
  State<WhyChooseUsWidget> createState() => _WhyChooseUsWidgetState();
}

class _WhyChooseUsWidgetState extends State<WhyChooseUsWidget> {
  final chooseUsData = [
    [const Icon(Icons.edit), const SizedBox(width: 10), const Text('Streamlined Ad Creation')],
    [
      const Icon(Icons.star),
      const SizedBox(width: 10),
      const Text('Top Tier Healthcare Providers'),
    ],
    [const Icon(Icons.chat), const SizedBox(width: 10), const Text('Easy Communication Tools')],
    [const Icon(Icons.analytics), const SizedBox(width: 10), const Text('Comprehensive Analytics')],
  ];

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Why Choose Us?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.secondaryHeaderColor,
            ),
          ),
          Column(
            children: List.generate(chooseUsData.length, (index) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(children: chooseUsData[index])
                    .animate()
                    .fadeIn(delay: Duration(milliseconds: 400 * (index + 1)), duration: 500.ms)
                    .slideX(
                      delay: Duration(milliseconds: 400 * (index + 1)),
                      begin: -1,
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ModernCard extends StatelessWidget {
  final Widget content;

  const ModernCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(padding: const EdgeInsets.all(16.0), child: content),
    );
  }
}
