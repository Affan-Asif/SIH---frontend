import 'package:flutter/material.dart';
import 'package:sih_app/PostMasterScreens/notifications.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration:
                BoxDecoration(color: Color.fromARGB(255, 161, 191, 216)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Employee Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Role',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Notification Center
          ListTile(
            title: const Text('Notifications'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationCenter(),
                  ));
            },
          ),
          // Settings
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              // Handle navigation to Settings
            },
          ),
          // Logout
          ListTile(
            title: const Text('Log Out'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Handle logout functionality
            },
          ),
        ],
      ),
    );
  }
}
