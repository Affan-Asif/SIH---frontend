import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sih_app/EmpScreens/employee_interface.dart';
import 'package:sih_app/PostMasterScreens/postmaster_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 
import 'package:google_fonts/google_fonts.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIH App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Options(),
    );
  }
}

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFf8f9fa), Color(0xFFdfe6e9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child:  SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CounterFlow',
                  // style: TextStyle(
                  //   fontSize: 28,
                  //   fontWeight: FontWeight.bold,
                  //   color: Color(0xFF2c3e50),
                  // ),
                  style : GoogleFonts.lato(fontSize: 28,fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/logos/indian_post_logo.png',
                  width: 250,
                  height: 160
                ),
                const SizedBox(height: 40),
                _buildElevatedButton(
                  context: context,
                  label: 'Postmaster',
                  icon: Icon(MdiIcons.accountTie, color: Colors.white, size: 28),
                  color: const Color(0xFF1abc9c),
                  destination:  PostmasterInterface(),
                ),
                const SizedBox(height: 20),
                _buildElevatedButton(
                  context: context,
                  label: 'Employee',
                  icon:  const Icon(Icons.person, color: Colors.white, size: 28),
                  color: const Color(0xFFe74c3c),
                  destination: const EmployeeInterface(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildElevatedButton({
    required BuildContext context,
    required String label,
    required Icon icon,
    required Color color,
    required Widget destination,
  }) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      icon: icon,
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.black38,
        elevation: 8,
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 15,
        ),
      ),
    );
  }
}
