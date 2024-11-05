import 'package:flutter/material.dart';

class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  OfferScreenState createState() => OfferScreenState();
}

class OfferScreenState extends State<OfferScreen> {
  final List<Map<String, String>> notifications = [
    {
      'date': '3/12/2024',
      'message': 'Your Items have been dropped off. Thanks'
    },
    {
      'date': '2/15/2024',
      'message': 'Thanks for reaching out to Boxed Customer.'
    },
    {
      'date': '1/19/2024',
      'message': 'Hey you! Fill out this questionnaire for \$5 gif.'
    },
    {
      'date': '1/16/2024',
      'message': 'Downloaded Boxed...1st step to stress-free.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
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

  NotificationItem({required this.date, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8FA), // Light background color
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(children: [
            Row(
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
                const Expanded(
                  child: SizedBox(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600), // Adjusted font weight
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  message,
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500), // Adjusted font weight
                )),
          ])),
    );
  }
}
