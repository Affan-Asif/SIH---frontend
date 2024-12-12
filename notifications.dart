import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sih_app/customer_feedback.dart';
import 'package:sih_app/theme.dart';

class NotificationCenter extends StatelessWidget {
  const NotificationCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text(
          'Notification Center',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: themeContainer(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Idle Counter Aletr
            NotificationTile(
              title: 'Idle Counter Alert',
              subtitle: 'The counter is idle. Please attend to the customers.',
              icon: MdiIcons.alert,
              color: Colors.orange,
              onTap: () {},
            ),
            // Customer Feedback
            NotificationTile(
              title: 'Customer Feedback',
              subtitle: 'A customer left feedback about the service.',
              icon: Icons.feedback,
              color: Colors.blue,
              onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerFeedback(),
                    ),
                  );},
            ),
            // New Message
            NotificationTile(
                title: 'New Message',
                subtitle: 'You have a new message from the admin.',
                icon: Icons.message,
                color: Colors.green,
                onTap: () { }),
            // More notifications can be added here
          ],
        ),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
