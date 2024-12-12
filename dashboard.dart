/*main dashboard*/

// import 'package:flutter/material.dart';
// import 'package:sih_app/modules/performance_chart.dart';
// import 'package:sih_app/theme.dart';

// class DashBoard extends StatefulWidget {
//   const DashBoard({super.key});
//   @override
//   State<DashBoard> createState() {
//     return _DashBoardState();
//   }
// }

// class _DashBoardState extends State<DashBoard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Dashboard',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blue.shade100,
//       ),
//       body: themeContainer(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header Section
//                 _buildHeaderSection(),

//                 const SizedBox(height: 20),

//                 // Counter Metrics Section
//                 _buildCounterMetricsSection(),

//                 const SizedBox(height: 20),

//                 // Employee Performance Section
//                 _buildEmployeePerformanceSection(),

//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Header Section
//   Widget _buildHeaderSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Quick Stats',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             _buildStatCard('Total Customers Served', '150',
//                 const Color.fromARGB(255, 73, 177, 77)), //backend
//             _buildStatCard('Total Queue Length', '45',
//                 const Color.fromARGB(255, 75, 158, 226)),
//             _buildStatCard(
//                 'Idle Counters', '1', const Color.fromARGB(255, 207, 88, 79)),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildStatCard(String title, String value, Color color) {
//     return Expanded(
//       child: Card(
//         color: color,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Counter Metrics Section
//   Widget _buildCounterMetricsSection() {
//     final counters = [
//       {
//         'number': 1,
//         'status': 'Active',
//         'avgTime': '2 mins',
//         'served': '30',
//         'queue': '3'
//       },
//       {
//         'number': 2,
//         'status': 'Active',
//         'avgTime': '3 mins',
//         'served': '25',
//         'queue': '5'
//       },
//       {
//         'number': 3,
//         'status': 'Idle',
//         'avgTime': '0 mins',
//         'served': '0',
//         'queue': '0'
//       },
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Counter Metrics',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: counters.length, //3 counters
//           itemBuilder: (context, index) {
//             final counter = counters[index];
//             return Card(
//               child: ListTile(
//                 title: Text('Counter ${counter['number']}'),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Status: ${counter['status']}'),
//                     Text('Average Time Per Customer: ${counter['avgTime']}'),
//                     Text('Total Customers Served: ${counter['served']}'),
//                     Text('Queue Length: ${counter['queue']}'),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   // Employee Performance Section
//   Widget _buildEmployeePerformanceSection() {
//     return EmployeePerformanceChart();
//   }
// }
