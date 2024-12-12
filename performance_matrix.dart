import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PerformanceMetrix extends StatelessWidget {
  const PerformanceMetrix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text('Performance Metrics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customers Served Currently
              _buildMetricTile(
                title: 'Customers Served Currently',
                value: '25', // Replace with dynamic data if available
              ),
              const SizedBox(height: 20),

              // Average Time Per Customer
              const Text(
                'Average Time Per Customer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildProgressBar(
                percentage: 0.75, // 75% example value
                label: '5.4 minutes', // Replace with actual average time
              ),
              const SizedBox(height: 20),

              // Customer Feedback
              const Text(
                'Customer Feedback',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: 4.5, // Replace with dynamic rating
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 30.0,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    '4.5/5.0',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildRecentFeedback([
                'Great service, very fast!',
                'Friendly and efficient.',
                'Had to wait too long this time.',
              ]),

              const SizedBox(height: 30),

              // Performance Trends
              const Text(
                'Performance Trends',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildLineGraph(),
            ],
          ),
        ),
      ),
    );
  }

  // Metric Tile
  Widget _buildMetricTile({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    );
  }

  // Progress Bar for Average Time Per Customer
  Widget _buildProgressBar({required double percentage, required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: percentage,
          minHeight: 10,
          color: Colors.green,
          backgroundColor: Colors.grey.shade300,
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Recent Feedback Section
  Widget _buildRecentFeedback(List<String> feedback) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: feedback.map((review) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.comment, color: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  review,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Line Graph for Performance Trends
  Widget _buildLineGraph() {
    final List<_ChartData> data = [
      _ChartData('Jan', 20),
      _ChartData('Feb', 25),
      _ChartData('Mar', 30),
      _ChartData('Apr', 35),
      _ChartData('May', 28),
    ]; // Example data

    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <LineSeries<_ChartData, String>>[
          LineSeries<_ChartData, String>(
            dataSource: data,
            xValueMapper: (_ChartData data, _) => data.month,
            yValueMapper: (_ChartData data, _) => data.value,
            color: Colors.blue,
            width: 3,
            markerSettings: const MarkerSettings(isVisible: true),
          ),
        ],
        title: ChartTitle(text: 'Customer Served Over Time'),
        legend: Legend(isVisible: false),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.month, this.value);
  final String month;
  final int value;
}
