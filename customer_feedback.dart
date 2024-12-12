import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CustomerFeedback extends StatelessWidget {
  const CustomerFeedback({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Feedback"),
        backgroundColor:  Colors.blue.shade100,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('feedback') // Replace with your collection name
            .orderBy('email', descending: true) // Sort by time
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "No feedback yet!",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          final feedbackList = snapshot.data!.docs;

          return ListView.builder(
  itemCount: feedbackList.length,
  itemBuilder: (context, index) {
    var feedback = feedbackList[index];

    // Access the fields using the correct names
    String name = feedback['name'] ?? 'Anonymous'; // Fallback if 'name' is missing
    String email = feedback['email'] ?? 'N/A';     // Fallback if 'email' is missing
    String message = feedback['feedback'] ?? 'No message provided.'; // Access 'feedback' field

    return FeedbackCard(
      name: name,
      email: email,
      message: message,
    );
  },
);

        },
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final String name;
  final String email;
  final String message;
  //final DateTime? timestamp;

  const FeedbackCard({
    required this.name,
    required this.email,
    required this.message,
    //this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              email,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            /*if (timestamp != null) ...[
              SizedBox(height: 12),
              Text(
                "Submitted on: ${timestamp!.toLocal()}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],*/
          ],
        ),
      ),
    );
  }
}