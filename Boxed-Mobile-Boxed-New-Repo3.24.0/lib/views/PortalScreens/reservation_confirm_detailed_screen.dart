import 'dart:convert';
import 'dart:ffi';

import 'package:boxed_project/common/base_widget.dart';
import 'package:boxed_project/http/api_service.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:boxed_project/Utility/constant.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/views/PortalScreens/reservation_details_screen.dart';
import 'package:boxed_project/views/widget/customsnapbar.dart';

class ReservationConfirmDetailedScreen extends StatefulWidget {
  const ReservationConfirmDetailedScreen({super.key});

  @override
  State<ReservationConfirmDetailedScreen> createState() => _ReservationConfirmDetailedScreenState();
}

class _ReservationConfirmDetailedScreenState extends State<ReservationConfirmDetailedScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pickupDateController = TextEditingController();
  final _dropDateController = TextEditingController();
  final _pickupLocationController = TextEditingController();
  final _deliveryLocationController = TextEditingController();
  final _customLocationController = TextEditingController();
  String? selectedLocation;
  String? selectedApartment;
  String? _selectedPayment;
  
  bool _isCustomLocation = false;
  int _role = 2;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchReservationDetails();
  }

  Future<void> fetchReservationDetails() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showLoadingDialog(context);
    });

    void callback(String responseBody, {bool isError = false}) {
      try {
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

        if (isError) {
          String message = jsonResponse['error'] ?? 'Something went wrong';
          if (mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              hideLoadingDialog(context);
              CustomSnackBar.show(context, message);
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(
              //       message,
              //       style: const TextStyle(color: Colors.white),
              //     ),
              //     backgroundColor: Colors.red,
              //   ),
              // );
            });
          }
        } else {
          Map<String, dynamic> data = jsonResponse['data'];
          String message = jsonResponse['message'] ?? 'Data fetched successfully!';
          String apiSelectedLocation = data['location'] ?? '';
          String pickupTime  = data['pickup_time'] ?? '';
          String dropoffTime = data['dropoff_time'] ?? '';
          String pickupLocation   = data['pickup_location'] ?? '';
          String deliveryLocation = data['delivery_location'] ?? '';

          setState(() {
            // if (Constant.schoolList.contains(apiSelectedLocation)) {
            //   selectedLocation = apiSelectedLocation;
            //   _isCustomLocation = false;
            // } else {
            //   _isCustomLocation = true;
            //   _customLocationController.text = apiSelectedLocation;
            //   selectedLocation = Constant.schoolList.isNotEmpty ? Constant.schoolList.first : null;
            // }

            // selectedApartment = Constant.apartmentList.contains(data['apartment'])
            //     ? data['apartment']
            //     : (Constant.apartmentList.isNotEmpty ? Constant.apartmentList.first : null);
            // _selectedPayment = Constant.paymentList.contains(data['payment'])
            //     ? data['payment']
            //     : (Constant.paymentList.isNotEmpty ? Constant.paymentList.first : null);
            // _role = data['role'] == 2 ? 2 : 3;

            try {
              // Parse pickup time
              DateTime parsedPickupTime = DateTime.parse(pickupTime);
              String formattedPickupTime =
                  "${parsedPickupTime.month}/${parsedPickupTime.day}/${parsedPickupTime.year}";
              _pickupDateController.text = formattedPickupTime;

              // Parse drop-off time
              DateTime parsedDropoffTime = DateTime.parse(dropoffTime);
              String formattedDropoffTime =
                  "${parsedDropoffTime.month}/${parsedDropoffTime.day}/${parsedDropoffTime.year}";
              _dropDateController.text = formattedDropoffTime;
            } catch (e) {
              print("Error parsing dates: $e");
              _pickupDateController.text = "Invalid date";
              _dropDateController.text = "Invalid date";
            }
            _pickupLocationController.text   = pickupLocation;
            _deliveryLocationController.text = deliveryLocation;

          });

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              hideLoadingDialog(context);
              CustomSnackBar.show(context, message);
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(
              //       message,
              //       style: const TextStyle(color: Colors.white),
              //     ),
              //     backgroundColor: Colors.green,
              //   ),
              // );
            }
          });
        }
      } catch (e) {
        print('Error decoding JSON: $e');
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            hideLoadingDialog(context);
            CustomSnackBar.show(context, 'An error occurred: $e');
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(
            //       'An error occurred: $e',
            //       style: const TextStyle(color: Colors.white),
            //     ),
            //     backgroundColor: Colors.red,
            //   ),
            // );
          });
        }
      }
    }
    // Temporary Stopped Part
    await ApiService(context).getReservationDetails(callback);
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
    _pickupDateController.dispose();
    _dropDateController.dispose();
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
                        32.kH,
                        const Text(
                          'Pickup Date',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        8.kH,
                        TextFormField(
                          controller: _pickupDateController,
                          // keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            hintText: 'Select Pickup Date',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              // Format the selected date (you can use intl package for custom formats)
                              String formattedDate =
                                  "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
                              setState(() {
                                _pickupDateController.text = formattedDate; // Set the formatted date
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the pickup date';
                            }
                            return null;
                          },
                        ),
                        24.kH,
                        const Text(
                          'Drop off Date',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        8.kH,
                        TextFormField(
                          controller: _dropDateController,
                          // keyboardType: TextInputType.datetime,
                          decoration: const InputDecoration(
                            hintText: 'Select Drop Date',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          readOnly: true,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                          onTap: () async {
                            DateTime? dropDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (dropDate != null) {
                              // Format the selected date (you can use intl package for custom formats)
                              String formattedDate =
                                  "${dropDate.month}/${dropDate.day}/${dropDate.year}";
                              setState(() {
                                _dropDateController.text = formattedDate; // Set the formatted date
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the pickup date';
                            }
                            return null;
                          },
                        ),                        
                        24.kH,
                        const Text(
                          'Pickup Location',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        8.kH,
                        TextFormField(
                          controller: _pickupLocationController,
                          decoration: customInputDecoration('your location'),
                          // onChanged: (value) => _reservation.cardEmail = value,
                          validator: (value) => value!.isEmpty ? "Enter your location" : null,
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.grey, // Border color
                        //     ),
                        //     borderRadius: BorderRadius.circular(4), // Rounded corners
                        //   ),
                        //   child: DropdownButtonHideUnderline(
                        //     child: DropdownButtonFormField<String>(
                        //       value: selectedLocation,
                        //       items: Constant.schoolList.map((location) {
                        //         return DropdownMenuItem<String>(
                        //           value: location,
                        //           child: Text(
                        //             location,
                        //             style: const TextStyle(
                        //               fontSize: 14.0,
                        //               fontWeight: FontWeight.w500,
                        //             ),
                        //             overflow: TextOverflow.ellipsis, // Handle text overflow
                        //           ),
                        //         );
                        //       }).toList(),
                        //       onChanged: (value) {
                        //         setState(() {
                        //           selectedLocation = value;
                        //           _isCustomLocation = selectedLocation == 'Custom';
                        //           if (_isCustomLocation) {
                        //             _customLocationController.text = '';
                        //           }
                        //         });
                        //       },
                        //       decoration: InputDecoration(
                        //         contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        //         border: InputBorder.none, // Remove default border
                        //       ),
                        //       icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                        //       isExpanded: true, // Make the dropdown fill the container width
                        //     ),
                        //   ),
                        // ),
                        24.kH,
                        const Text(
                          'Delivery Location',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        8.kH,
                        TextFormField(
                          controller: _deliveryLocationController,
                          decoration: customInputDecoration('delivery location'),
                          // onChanged: (value) => _reservation.cardEmail = value,
                          validator: (value) => value!.isEmpty ? "Enter deliver location" : null,
                        ),
                        8.kH,
                        // DropdownButtonFormField<String>(
                        //   value: selectedApartment,
                        //   items: Constant.apartmentList.map((apartment) {
                        //     return DropdownMenuItem<String>(
                        //       value: apartment,
                        //       child: Text(
                        //         apartment,
                        //         style: const TextStyle(
                        //           fontSize: 14.0,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     );
                        //   }).toList(),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       selectedApartment = value;
                        //     });
                        //   },
                        //   decoration: const InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        //   ),
                        // ),
                        // 24.kH,
                        // const Text(
                        //   'Payment Method',
                        //   style: TextStyle(
                        //     fontSize: 14.0,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        // 8.kH,
                        // DropdownButtonFormField<String>(
                        //   value: _selectedPayment,
                        //   items: Constant.paymentList.map((payment) {
                        //     return DropdownMenuItem<String>(
                        //       value: payment,
                        //       child: Text(
                        //         payment,
                        //         style: const TextStyle(
                        //           fontSize: 14.0,
                        //           fontWeight: FontWeight.w500,
                        //         ),
                        //       ),
                        //     );
                        //   }).toList(),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       _selectedPayment = value;
                        //     });
                        //   },
                        //   decoration: const InputDecoration(
                        //     border: OutlineInputBorder(),
                        //     contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        //   ),
                        // ),
                        // 32.kH,
                        // SizedBox(
                        //   width: double.infinity,
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       if (_formKey.currentState?.validate() ?? false) {
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) => const ReservationDetailScreen()),
                        //         );
                        //       }
                        //     },
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: ColorConstants.primaryColor,
                        //       padding: const EdgeInsets.symmetric(vertical: 15),
                        //       textStyle: const TextStyle(
                        //         fontSize: 18,
                        //         fontFamily: 'Inter',
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(4),
                        //       ),
                        //     ),
                        //     child: const Text('Reserve',
                        //     style: TextStyle(
                        //     fontSize: 14.0,
                        //     fontWeight: FontWeight.w500,
                        //     color: Colors.white,
                        //   ),
                        //     ),
                        //   ),
                        // ),
                        // 32.kH,
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

  InputDecoration customInputDecoration(String labelText) {
    return InputDecoration(
      hintText: labelText,
      // filled: true,
      // fillColor: Colors.grey[200],
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          // color: Colors.grey,
          // width: 1.5,
        ),
      ),
    );
  }

}