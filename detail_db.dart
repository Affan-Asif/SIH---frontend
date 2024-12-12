// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

// class DetailDb extends StatefulWidget {
//   const DetailDb({super.key});

//   @override
//   State<DetailDb> createState() {
//     return _DetailDbState();
//   }
// }

// class _DetailDbState extends State<DetailDb> {
//   Map<String, dynamic>? stats;
//   List<dynamic>? counterMetrics;
//   String? genAiResponse;
//   late Timer dataTimer;
//   final TextEditingController _promptController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchData(); // Fetch data on initial load
//     dataTimer = Timer.periodic(
//       const Duration(seconds: 2), // Poll data every 2 seconds
//       (timer) => fetchData(),
//     );
//   }

//   // Fetch data dynamically
//   Future<void> fetchData() async {
//     try {
//       final statsResponse = await http.get(Uri.parse('http://127.0.0.1:5000/stats'));
//       final counterMetricsResponse = await http.get(Uri.parse('http://127.0.0.1:5000/counters'));

//       if (statsResponse.statusCode == 200 && counterMetricsResponse.statusCode == 200) {
//         setState(() {
//           stats = jsonDecode(statsResponse.body);
//           counterMetrics = jsonDecode(counterMetricsResponse.body);
//         });
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       debugPrint('Error fetching data: $e');
//     }
//   }

//   Future<void> fetchGenAiResponse(String prompt) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://127.0.0.1:5000/genai'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'prompt': prompt}),
//       );

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         setState(() {
//           genAiResponse = responseData['response'];
//         });
//       } else {
//         throw Exception('Failed to fetch GenAI response');
//       }
//     } catch (e) {
//       debugPrint('Error fetching GenAI response: $e');
//     }
//   }

//   @override
//   void dispose() {
//     dataTimer.cancel(); // Cancel the timer when the widget is disposed
//     _promptController.dispose();
//     super.dispose();
//   }

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
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               stats != null
//                   ? _buildHeaderSection(stats!)
//                   : const Center(child: CircularProgressIndicator()),
//               const SizedBox(height: 20),
//               counterMetrics != null
//                   ? _buildCounterMetricsSection(counterMetrics!)
//                   : const Center(child: CircularProgressIndicator()),
//               const SizedBox(height: 20),
//               _buildGenAiSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeaderSection(Map<String, dynamic> data) {
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
//             _buildStatCard('Active Customers', '${data['active_customers']}',
//                 const Color.fromARGB(255, 73, 177, 77)),
//             _buildStatCard('Total Customers', '${data['total_customers']}',
//                 const Color.fromARGB(255, 75, 158, 226)),
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

//   Widget _buildCounterMetricsSection(List<dynamic> counters) {
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
//           itemCount: counters.length,
//           itemBuilder: (context, index) {
//             final counter = counters[index];
//             return Card(
//               child: ListTile(
//                 title: Text('Counter ${counter['number']}'),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Status: ${counter['status']}'),
//                     Text('Average Time Per Customer: ${counter['avg_time']}'),
//                     Text('Activity: ${counter['activity']}'),

//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   Widget _buildGenAiSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Generate AI Response',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         TextField(
//           controller: _promptController,
//           decoration: const InputDecoration(
//             border: OutlineInputBorder(),
//             labelText: 'Enter your prompt',
//           ),
//         ),
//         const SizedBox(height: 10),
//         ElevatedButton(
//           onPressed: () {
//             final prompt = _promptController.text;
//             if (prompt.isNotEmpty) {
//               fetchGenAiResponse(prompt);
//             }
//           },
//           child: const Text('Generate Response'),
//         ),
//         const SizedBox(height: 20),
//         if (genAiResponse != null)
//           Text(
//             'AI Response: $genAiResponse',
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';
// // import 'package:fl_chart/fl_chart.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DetailDb extends StatefulWidget {
//   const DetailDb({super.key});

//   @override
//   State<DetailDb> createState() {
//     return _DetailDbState();
//   }
// }

// class _DetailDbState extends State<DetailDb> {
//   late Future<Map<String, dynamic>> stats;
//   late Future<List<dynamic>> counterMetrics;

//   final String baseUrl = "https://6c7a-103-165-8-10.ngrok-free.app"; // Replace with your machine's IP address.

//   @override
//   void initState() {
//     super.initState();
//     stats = fetchStats();
//     counterMetrics = fetchCounterMetrics();
//   }

//   // Fetch stats
//   Future<Map<String, dynamic>> fetchStats() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/stats'));
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to load stats');
//       }
//     } catch (e) {
//       throw Exception('Error fetching stats: $e');
//     }
//   }

//   // Fetch counter metrics
//   Future<List<dynamic>> fetchCounterMetrics() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/counters'));
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to load counter metrics');
//       }
//     } catch (e) {
//       throw Exception('Error fetching counter metrics: $e');
//     }
//   }

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
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               FutureBuilder<Map<String, dynamic>>(
//                 future: stats,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else {
//                     final data = snapshot.data!;
//                     return _buildHeaderSection(data);
//                   }
//                 },
//               ),
//               const SizedBox(height: 20),
//               FutureBuilder<List<dynamic>>(
//                 future: counterMetrics,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else {
//                     return _buildCounterMetricsSection(snapshot.data!);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeaderSection(Map<String, dynamic> data) {
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
//             _buildStatCard('Active Customers', '${data['active_customers']}',
//                 const Color.fromARGB(255, 73, 177, 77)),
//             _buildStatCard('Total Customers', '${data['total_customers']}',
//                 const Color.fromARGB(255, 75, 158, 226)),
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

//   Widget _buildCounterMetricsSection(List<dynamic> counters) {
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
//           itemCount: counters.length,
//           itemBuilder: (context, index) {
//             final counter = counters[index];
//             return Card(
//               child: ListTile(
//                 title: Text('Counter ${counter['number']}'),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Status: ${counter['status']}'),
//                     Text('Average Time Per Customer: ${counter['avg_time']}'),
//                     Text('Activity: ${counter['activity']}'),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

// import 'dart:async'; // For Timer
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class DetailDb extends StatefulWidget {
//   const DetailDb({super.key});

//   @override
//   State<DetailDb> createState() {
//     return _DetailDbState();
//   }
// }

// class _DetailDbState extends State<DetailDb> {
//   late Future<Map<String, dynamic>> stats;
//   late Future<List<dynamic>> counterMetrics;
//   late Timer _timer;

//   final String baseUrl = "https://fc8b-103-165-8-10.ngrok-free.app"; // Replace with your machine's IP address.

//   @override
//   void initState() {
//     super.initState();
//     stats = fetchStats();
//     counterMetrics = fetchCounterMetrics();
//     // Start a periodic update for dynamic data
//     _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       setState(() {
//         stats = fetchStats();
//         counterMetrics = fetchCounterMetrics();
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel(); // Cancel the timer when the widget is disposed
//     super.dispose();
//   }

//   // Fetch stats
//   Future<Map<String, dynamic>> fetchStats() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/stats'));
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to load stats');
//       }
//     } catch (e) {
//       throw Exception('Error fetching stats: $e');
//     }
//   }

//   // Fetch counter metrics
//   Future<List<dynamic>> fetchCounterMetrics() async {
//     try {
//       final response = await http.get(Uri.parse('$baseUrl/counters'));
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to load counter metrics');
//       }
//     } catch (e) {
//       throw Exception('Error fetching counter metrics: $e');
//     }
//   }

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
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               FutureBuilder<Map<String, dynamic>>(
//                 future: stats,
//                 builder: (context, snapshot) {
//                   // if (snapshot.connectionState == ConnectionState.waiting) {
//                   //   return const Center(child: CircularProgressIndicator());
//                   // } else
//                   if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else {
//                     final data = snapshot.data!;
//                     return _buildHeaderSection(data);
//                   }
//                 },
//               ),
//               const SizedBox(height: 20),
//               FutureBuilder<List<dynamic>>(
//                 future: counterMetrics,
//                 builder: (context, snapshot) {
//                   // if (snapshot.connectionState == ConnectionState.waiting) {
//                   //   return const Center(child: CircularProgressIndicator());
//                   // } else
//                   if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else {
//                     return _buildCounterMetricsSection(snapshot.data!);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeaderSection(Map<String, dynamic> data) {
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
//             _buildStatCard('Active Customers', '${data['active_customers']}',
//                 const Color.fromARGB(255, 73, 177, 77)),
//             _buildStatCard('Total Customers', '${data['total_customers']}',
//                 const Color.fromARGB(255, 75, 158, 226)),
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

//   Widget _buildCounterMetricsSection(List<dynamic> counters) {
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
//           itemCount: counters.length,
//           itemBuilder: (context, index) {
//             final counter = counters[index];
//             return Card(
//               child: ListTile(
//                 title: Text('Counter ${counter['number']}'),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Status: ${counter['status']}'),
//                     Text('Average Time Per Customer: ${counter['avg_time']}'),
//                     Text('Activity: ${counter['activity']}'),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }


//main
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class DetailDb extends StatefulWidget {
  const DetailDb({super.key});

  @override
  State<DetailDb> createState() {
    return _DetailDbState();
  }
}

class _DetailDbState extends State<DetailDb> {
  Map<String, dynamic>? stats;
  List<dynamic>? counterMetrics;
  String? genAiResponse;
  late Timer dataTimer;
  final TextEditingController _promptController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data on initial load
    dataTimer = Timer.periodic(
      const Duration(seconds: 2), // Poll data every 2 seconds
      (timer) => fetchData(),
    );
  }

  // Fetch data dynamically
  Future<void> fetchData() async {
    try {
      final statsResponse = await http.get(Uri.parse('http://127.0.0.1:5000/stats'));
      final counterMetricsResponse = await http.get(Uri.parse('http://127.0.0.1:5000/counters'));

      if (statsResponse.statusCode == 200 && counterMetricsResponse.statusCode == 200) {
        setState(() {
          stats = jsonDecode(statsResponse.body);
          counterMetrics = jsonDecode(counterMetricsResponse.body);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  Future<void> fetchGenAiResponse(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/genai'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'prompt': prompt}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          genAiResponse = responseData['response'];
        });
      } else {
        throw Exception('Failed to fetch GenAI response');
      }
    } catch (e) {
      debugPrint('Error fetching GenAI response: $e');
    }
  }

  @override
  void dispose() {
    dataTimer.cancel(); // Cancel the timer when the widget is disposed
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              stats != null
                  ? _buildHeaderSection(stats!)
                  : const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 20),
              counterMetrics != null
                  ? _buildCounterMetricsSection(counterMetrics!)
                  : const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 20),
              _buildGenAiSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Stats',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatCard('Active Customers', '${data['active_customers']}',
                const Color.fromARGB(255, 73, 177, 77)),
            _buildStatCard('Total Customers', '${data['total_customers']}',
                const Color.fromARGB(255, 75, 158, 226)),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounterMetricsSection(List<dynamic> counters) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Counter Metrics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: counters.length,
          itemBuilder: (context, index) {
            final counter = counters[index];
            return Card(
              child: ListTile(
                title: Text('Counter ${counter['number']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Status: ${counter['status']}'),
                    Text('Average Time Per Customer: ${counter['avg_time']}'),
                    Text('Activity: ${counter['activity']}'),
                   
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGenAiSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Generate AI Response',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _promptController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter your prompt',
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            final prompt = _promptController.text;
            if (prompt.isNotEmpty) {
              fetchGenAiResponse(prompt);
            }
          },
          child: const Text('Generate Response'),
        ),
        const SizedBox(height: 20),
        if (genAiResponse != null)
          Text(
            'AI Response: $genAiResponse',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
      ],
    );
  }
}

 

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:async';

// class Dashboard extends StatefulWidget {
//   const Dashboard({Key? key}) : super(key: key);

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   Map<String, dynamic>? stats;
//   List<dynamic>? counterMetrics;
//   String videoStreamUrl = 'http://127.0.0.1:5000/video_feed'; // Flask video stream URL
//   late Timer dataTimer;

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     dataTimer = Timer.periodic(
//       const Duration(seconds: 2), // Poll data every 2 seconds
//       (timer) => fetchData(),
//     );
//   }

//   // Fetch stats and counter metrics
//   Future<void> fetchData() async {
//     try {
//       final statsResponse = await http.get(Uri.parse('http://127.0.0.1:5000/stats'));
//       final counterMetricsResponse = await http.get(Uri.parse('http://127.0.0.1:5000/counters'));

//       if (statsResponse.statusCode == 200 && counterMetricsResponse.statusCode == 200) {
//         setState(() {
//           stats = jsonDecode(statsResponse.body);
//           counterMetrics = jsonDecode(counterMetricsResponse.body);
//         });
//       } else {
//         throw Exception('Failed to load data');
//       }
//     } catch (e) {
//       debugPrint('Error fetching data: $e');
//     }
//   }

//   @override
//   void dispose() {
//     dataTimer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//       ),
//       body: Column(
//         children: [
//           // Video Stream
//           Expanded(
//             flex: 2,
//             child: Container(
//               color: Colors.black,
//               child: Image.network(
//                 videoStreamUrl,
//                 fit: BoxFit.cover,
//                 errorBuilder: (context, error, stackTrace) {
//                   return const Center(
//                     child: Text(
//                       'Failed to load video stream',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(height: 10),
//           // Statistics Section
//           Expanded(
//             flex: 1,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   stats != null
//                       ? Text(
//                           'Active Customers: ${stats!['active_customers']}',
//                           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         )
//                       : const CircularProgressIndicator(),
//                   const SizedBox(height: 10),
//                   stats != null
//                       ? Text(
//                           'Total Customers: ${stats!['total_customers']}',
//                           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         )
//                       : const CircularProgressIndicator(),
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: counterMetrics != null
//                         ? ListView.builder(
//                             itemCount: counterMetrics!.length,
//                             itemBuilder: (context, index) {
//                               final counter = counterMetrics![index];
//                               return Card(
//                                 child: ListTile(
//                                   title: Text('Counter ${counter['number']}'),
//                                   subtitle: Text(
//                                     'Status: ${counter['status']}\n'
//                                     'Avg Time: ${counter['avg_time']} sec\n'
//                                     'Activity: ${counter['activity']}',
//                                   ),
//                                 ),
//                               );
//                             },
//                           )
//                         : const Center(child: CircularProgressIndicator()),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
