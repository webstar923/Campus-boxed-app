import 'package:flutter/material.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/ReservationScreens/reservation_details_screen.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final List<Map<String, dynamic>> _items = [
    {'id': 1873734732, 'name': 'Box'},
    {'id': 1873734733, 'name': 'Box'},
    {'id': 1873734734, 'name': 'Box'},
    {'id': 1873734735, 'name': 'Mattress Frame'},
    {'id': 1873734736, 'name': 'Bicycle'},
  ];

  List<Map<String, dynamic>> items = [
    {'id': '1873734732', 'name': 'Box', 'status': 'Awaiting Pickup'},
    {'id': '1873734733', 'name': 'Box', 'status': 'Awaiting Pickup'},
    {'id': '1873734734', 'name': 'Box', 'status': 'Awaiting Pickup'},
    {'id': '1873734735', 'name': 'Mattress Frame', 'status': 'Awaiting Pickup'},
    {'id': '1873734736', 'name': 'Bicycle', 'status': 'Awaiting Pickup'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBackgroundColor,
      body: Column(
        children: [
          Container(
            height: 150 + MediaQuery.of(context).padding.top, // Add status bar height to the container height
            color: ColorConstants.primaryColor,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 14.0),
                    child: Image.asset(
                      'assets/images/boxed_logo.png',
                      height: 67,
                      width: 212,
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).padding.top,
                  left: 0,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const Positioned(
                  bottom: 14.0,
                  right: 20,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.people, color: Colors.white),
                      SizedBox(width: 16),
                      Icon(Icons.mail_outline, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),         
          Expanded(
            child: Container(
              color: ColorConstants.primaryBackgroundColor,
              child: Column(
                children: [
                  Container(
                    height: 253,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/detailScreen.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 14.0),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16.0)),
                        child: Container(
                          color: ColorConstants.primaryWhiteColor,
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 16.0, 0, 0.0),
                                child: Text(
                                  'Complementary Moving Materials',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildInfoRow('Pickup Date', '21-1-2024'),
                                    _buildInfoRow('Location', 'Noida'),
                                    _buildInfoRow(
                                        'Estimate your Items', '23-1-2024'),
                                    _buildInfoRow('Items Check In & Pick up',
                                        '23-1-2024'),
                                    _buildInfoRow(
                                        'Dropoff Date', 'Awaiting Pickup'),
                                    _buildInfoRow('Location', 'Noida'),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 0.0, 0, 16.0),
                                child: Text(
                                  'Item Delivery',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ...items.map((item) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: ListTile(
                                    leading: Icon(Icons.check_circle),
                                    title: Text(
                                      '${item['id']} - ${item['name']}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    trailing: Text(
                                      '${item['status']}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                );
                              }).toList(),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReservationDetailScreen()),
                                    );
                                  },
                                  child: Text('Continue'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor:
                                        ColorConstants.primaryWhiteColor,
                                    backgroundColor: ColorConstants
                                        .primaryColor, // Text color
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
