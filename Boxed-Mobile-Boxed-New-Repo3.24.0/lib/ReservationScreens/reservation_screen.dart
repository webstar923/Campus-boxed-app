import 'dart:convert';
import 'dart:ffi';

import 'package:boxed_project/common/base_widget.dart';
import 'package:boxed_project/http/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:boxed_project/Utility/constant.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/ReservationScreens/reservation_details_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MaterialApp(home: ReservationScreen()));
}

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _parentEmailController = TextEditingController();
  final _customLocationController = TextEditingController();
  String? selectedLocation;
  String? selectedApartment;
  String? _selectedPayment;
  
  bool _isCustomLocation = false;
  int _role = 2;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoadingDialog(context);
    });

    void callback(String responseBody, {bool isError = false}) {
      print('Response Body: $responseBody');

      try {
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

        if (isError) {
          String message = jsonResponse['error'] ?? 'Something went wrong';
          if (mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              hideLoadingDialog(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }
        } else {
          Map<String, dynamic> data = jsonResponse['data'];
          String message = jsonResponse['message'] ?? 'Data fetched successfully!';
          String apiSelectedLocation = data['location'] ?? '';
          setState(() {
            if (Constant.schoolList.contains(apiSelectedLocation)) {
              selectedLocation = apiSelectedLocation;
              _isCustomLocation = false;
            } else {
              _isCustomLocation = true;
              _customLocationController.text = apiSelectedLocation;
              selectedLocation = Constant.schoolList.isNotEmpty ? Constant.schoolList.first : null;
            }

            _fullNameController.text = '${data['first_name']} ${data['last_name']}';
            _phoneNumberController.text = data['phone_number'] ?? '';
            _emailController.text = data['email'] ?? '';
            selectedApartment = Constant.apartmentList.contains(data['apartment'])
                ? data['apartment']
                : (Constant.apartmentList.isNotEmpty ? Constant.apartmentList.first : null);
            _selectedPayment = Constant.paymentList.contains(data['payment'])
                ? data['payment']
                : (Constant.paymentList.isNotEmpty ? Constant.paymentList.first : null);
            _role = data['role'] == 2 ? 2 : 3; 
          });

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              hideLoadingDialog(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            }
          });
        }
      } catch (e) {
        print('Error decoding JSON: $e');
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            hideLoadingDialog(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'An error occurred: $e',
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
      }
    }

    await ApiService(context).getUserDetails(callback);
  }

  @override
  void initState() {
    super.initState();
    // Initialize the variables with the first item from the list or null if the list is empty
    selectedLocation = Constant.schoolList.isNotEmpty ? Constant.schoolList.first : null;
    selectedApartment = Constant.apartmentList.isNotEmpty ? Constant.apartmentList.first : null;
    _selectedPayment = Constant.paymentList.isNotEmpty ? Constant.paymentList.first : null;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _parentEmailController.dispose();
    _customLocationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32.0),
                        const Text(
                          'Full Name',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _fullNameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter Full Name',
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24.0),
                        const Text(
                          'Are you a Student or Parent/Family Member',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Wrap(
                          spacing: 24.0,
                          runSpacing: 8.0,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio<int>(
                                  value: 2,
                                  groupValue: _role,
                                  onChanged: (value) {
                                    setState(() {
                                      _role = value ?? 2;
                                    });
                                  },
                                ),
                                const Text('Student'),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio<int>(
                                  value: 3,
                                  groupValue: _role,
                                  onChanged: (value) {
                                    setState(() {
                                      _role = value ?? 3;
                                    });
                                  },
                                ),
                                const Text('Parent/Family Member'),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 24.0),
                        const Text(
                          'Student Email',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email Address',
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24.0),
                        const Text(
                          'Parent/Family Member Email',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email Address',
                            border: OutlineInputBorder(),
                          ),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the parent or family member email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24.0),
                        const Text(
                          'Location',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey, // Border color
                            ),
                            borderRadius: BorderRadius.circular(4), // Rounded corners
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField<String>(
                              value: selectedLocation,
                              items: Constant.schoolList.map((location) {
                                return DropdownMenuItem<String>(
                                  value: location,
                                  child: Text(
                                    location,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis, // Handle text overflow
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedLocation = value;
                                  _isCustomLocation = selectedLocation == 'Custom';
                                  if (_isCustomLocation) {
                                    _customLocationController.text = '';
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none, // Remove default border
                              ),
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                              isExpanded: true, // Make the dropdown fill the container width
                            ),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        const Text(
                          'Apartment',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        DropdownButtonFormField<String>(
                          value: selectedApartment,
                          items: Constant.apartmentList.map((apartment) {
                            return DropdownMenuItem<String>(
                              value: apartment,
                              child: Text(
                                apartment,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedApartment = value;
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                        const SizedBox(height: 24.0),
                        const Text(
                          'Payment Method',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        DropdownButtonFormField<String>(
                          value: _selectedPayment,
                          items: Constant.paymentList.map((payment) {
                            return DropdownMenuItem<String>(
                              value: payment,
                              child: Text(
                                payment,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedPayment = value;
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ReservationDetailScreen()),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              textStyle: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            child: const Text('Reserve',
                            style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}