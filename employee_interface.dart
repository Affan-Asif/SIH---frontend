import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sih_app/EmpScreens/chatbox.dart';
import 'package:sih_app/EmpScreens/performance_matrix.dart';
import 'package:sih_app/EmpScreens/schedule.dart';
import 'package:sih_app/theme.dart';
import 'package:sih_app/EmpScreens/drawer.dart';

class EmployeeInterface extends StatefulWidget {
  const EmployeeInterface({super.key});

  @override
  State<EmployeeInterface> createState() {
    return _EmpState();
  }
}

class _EmpState extends State<EmployeeInterface> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text(
          'Employee Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: themeContainer(child: 
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section as a Column
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60, // Profile picture size
                    child: Icon(Icons.person), // Default icon for now
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Welcome, John Doe', // Replace with employee name
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Customer Service Representative',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Grid of functional tiles
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildTile(
                    icon: MdiIcons.chat,
                    label: 'Ask a Question',
                    iconColor: Colors.blue, // Color for the chat icon
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatboxScreen(),),);
                    },
                  ),
                  _buildTile(
                    icon: MdiIcons.calendar,
                    label: 'Attendance & Schedule',
                    iconColor: Colors.green, // Color for the calendar icon
                    onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => const AttendanceScheduleScreen(),),);
                    },
                  ),
                  _buildTile(
                    icon: Icons.bar_chart,
                    label: 'Your Performance',
                    iconColor: Colors.orange, // Color for the performance icon
                    onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => const PerformanceMetrix(),),);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
      );
  }

  // Tile builder function for the grid
  Widget _buildTile({
    required IconData icon,
    required String label,
    required Color iconColor, 
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: iconColor, // Use the color passed as argument
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
