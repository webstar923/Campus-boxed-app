import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  NewsScreenState createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  final List<Map<String, String>> notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return NotificationItem(
              date: notifications[index]['date']!,
              message: notifications[index]['message']!,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Handle chat button press
        },
        backgroundColor: Colors.white,
        icon: Image.asset(
          'assets/images/whatsapp.png', // Make sure to add the WhatsApp icon in assets
          height: 30.0,
          width: 30.0,
        ),
        label: const Text(
          'Chat With Us',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String date;
  final String message;

  const NotificationItem({required this.date, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              width: 8.0,
              height: 8.0,
              decoration: const BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
