import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:locum_care/core/extensions/context-extensions.dart';
import 'package:locum_care/core/heleprs/print_helper.dart';
import 'package:locum_care/core/widgets/default_drawer.dart';
import 'package:locum_care/core/widgets/main_scaffold.dart';
import 'package:locum_care/utils/assets/assets.dart';
import 'package:locum_care/utils/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  void _launchPhone(String phoneNumber) async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      pr('Could not launch $phoneNumber', 'AboutView');
    }
  }

  void _launchEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    try {
      await launchUrl(uri);
    } catch (e) {
      pr('Could not launch $email', 'AboutView');
    }
  }

  void _launchMap(String address) async {
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$address');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      pr('Could not launch map for $address', 'AboutView');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'About Us',
      drawer: const DefaultDoctorDrawer(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated Header
            txt('Who We Are', e: St.bold18)
                .animate()
                .fade(duration: 800.ms) // Fades in the header
                .slideY(begin: -0.3, duration: 800.ms), // Slides from the top

            const SizedBox(height: 16),

            // Services Section
            txt(
              'We are a locum agency dedicated to connecting healthcare professionals with clinics and hospitals. Our services include:',
              e: St.reg14,
            ).animate().fade(duration: 800.ms, delay: 200.ms).slideX(begin: -0.3, duration: 800.ms),
            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                color: context.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(AssetsData.map, fit: BoxFit.cover),
            ).animate().fade(duration: 800.ms, delay: 200.ms).slideX(begin: -0.3, duration: 800.ms),
            const SizedBox(height: 8),

            const Text(
              '- On-demand locum services\n'
              '- Flexible scheduling for professionals\n'
              '- Reliable partnerships with healthcare providers\n'
              '- Quick and secure onboarding process\n'
              '- 24/7 customer support',
              style: TextStyle(fontSize: 16, height: 1.5),
            ).animate().fade(duration: 800.ms, delay: 400.ms),

            const SizedBox(height: 24),

            // Call Button
            TextButton.icon(
              onPressed: () => _launchPhone('+717-578-4737'),
              icon: const Icon(Icons.phone, color: Colors.teal),
              label: const Text('Call Us: +717-578-4737', style: TextStyle(color: Colors.teal)),
            ).animate().fade(delay: 600.ms).slideX(begin: -0.2, duration: 800.ms),

            // Email Button
            TextButton.icon(
              onPressed: () => _launchEmail('ajmyers.ampmlocums@gmail.com'),
              icon: const Icon(Icons.email, color: Colors.teal),
              label: const Text(
                'Email: contact@locumapp.com',
                style: TextStyle(color: Colors.teal),
              ),
            ).animate().fade(delay: 700.ms).slideX(begin: -0.2, duration: 800.ms),

            // Address Button
            TextButton.icon(
              onPressed: () => _launchMap('123 Main Street, Springfield'),
              icon: const Icon(Icons.location_on, color: Colors.teal),
              label: const Text(
                'Find Us: 123 Main Street, Springfield',
                style: TextStyle(color: Colors.teal),
              ),
            ).animate().fade(delay: 800.ms).slideX(begin: -0.2, duration: 800.ms),
          ],
        ),
      ),
    );
  }
}
