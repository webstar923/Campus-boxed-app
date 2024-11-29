import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:boxed_project/http/api_constant.dart';
import 'package:boxed_project/http/api_client.dart';

class ReservationDetailSlider extends StatefulWidget {
  const ReservationDetailSlider({Key? key}) : super(key: key);

  @override
  State<ReservationDetailSlider> createState() =>
      _ReservationDetailSliderState();
}

class _ReservationDetailSliderState extends State<ReservationDetailSlider> {

  final storage = FlutterSecureStorage();
  String? _customerId;
  String? _pickupTime;

  @override
  void initState() {
    super.initState();
    _loadCustomerId(); // Load the customer ID when the widget initializes
    _loadPickupTime(); // Load the pickup Time when the widget initializes
  }

  // Function to load customer ID from secure storage
  Future<void> _loadCustomerId() async {
    String? customerId = await storage.read(key: 'customer_id');
    setState(() {
      _customerId = customerId; // Update the state with the retrieved value
    });
  }

  // Function to load Pickup Time from Server
  Future<void> _loadPickupTime() async {
    final url  = '${ApiConstants.baseUrl}${ApiConstants.reservations}';
    final response = await makeAuthenticatedRequest(url, 'GET');
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      if (responseData['success']) {
        _pickupTime = responseData['data']['pickup_time'];
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Reservation failed: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.primaryBackgroundColor,
        body: _customerId == null
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        color: ColorConstants
                            .primaryBackgroundColor, // Background color of ListView
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.primaryWhiteColor,
                              borderRadius:
                                  BorderRadius.circular(16.0), // Corner radius
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        16.0), // Corner radius for image container
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/sliderImages.png',
                                      height: 309,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstants
                                        .primaryWhiteColor, // Background color for data containers
                                    borderRadius: BorderRadius.circular(
                                        16.0), // Corner radius for data containers
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Customer ID:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          _customerId ?? 'Not available',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        16.0), // Corner radius for data containers
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      const Text(
                                        'PickUp Details:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          _pickupTime ?? 'Not available',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        16.0), // Corner radius for data containers
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Status:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Awaiting Pickup',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        16.0), // Corner radius for data containers
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: const Row(
                                    children: [
                                      Text(
                                        'Next Step:',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Confirm Details',
                                          style: TextStyle(
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
        );
  }
}
