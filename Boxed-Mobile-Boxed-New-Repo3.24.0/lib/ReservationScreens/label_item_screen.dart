import 'dart:convert';

import 'package:boxed_project/common/base_widget.dart';
import 'package:boxed_project/http/api_service.dart';
import 'package:flutter/material.dart';
import 'package:boxed_project/Utility/common.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/Model/packingMaterial.dart'; // Ensure this import

class LabelItemScreen extends StatefulWidget {
  const LabelItemScreen({Key? key}) : super(key: key);

  @override
  State<LabelItemScreen> createState() => _LabelItemScreenState();
}

class _LabelItemScreenState extends State<LabelItemScreen> {
  void _showPopupDialog(int index) {
  final TextEditingController textController = TextEditingController();
  final PackingMaterial material = Common.selectedMaterials[index];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add a value'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(hintText: "Enter value"),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: (material.items ?? []).map<Widget>((value) => Chip(
                label: Text(value),
                deleteIcon: const Icon(Icons.cancel),
                onDeleted: () {
                  setState(() {
                    material.items?.remove(value);
                  });
                },
              )).toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Add'),
            onPressed: () {
              setState(() {
                final newItem = textController.text;
                if (newItem.isNotEmpty) {
                  material.items?.add(newItem);
                }
              });
              Navigator.of(context).pop();
              // Call the method to send data to server
              sendDataToServer(context);
            },
          ),
        ],
      );
    },
  );
}

  Future<void> sendDataToServer(BuildContext context) async {
  showLoadingDialog(context);

  final packagingWrapperIds = Common.selectedMaterials.map((material) {
    return {
      'id': material.id,
      'items': material.items ?? [],
    };
  }).toList();

  final payload = {
    'storage_box_id': 1, // Replace with actual data
    'pickup_time': '2024-09-08 12:00', // Replace with actual data
    'dropoff_time': '2024-09-08 12:00', // Replace with actual data
    'items_packed_labeled': true, // Replace with actual data
    'items_pickup_ready': true, // Replace with actual data
    'items_movers_possession': true, // Replace with actual data
    'status': 1, // Replace with actual data
    'packaging_wrapper_ids': packagingWrapperIds,
  };

  void callback(String responseBody, {bool isError = false}) {
    try {
      Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

      if (isError) {
        String message = jsonResponse['error'] ?? 'Something went wrong';
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
      } else {
        String message = jsonResponse['message'] ?? 'Data submitted successfully!';
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
        // Handle success, maybe navigate to another screen or refresh data
      }
    } catch (e) {
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
    }
  }

  await ApiService(context).reservationInfomationUpdate(
    context,
    payload,
    callback,
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            Common.selectedMaterials.length,
            (index) {
              final PackingMaterial material = Common.selectedMaterials[index];
              return Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width / 2 - 24, // Ensure container has a minimum width
                ),
                margin: const EdgeInsets.all(12.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min, // Prevent overflow
                      children: [
                        // Check if image is from external URL or local asset
                        material.image.startsWith('http') 
                            ? Image.network(
                                material.image,
                                width: 110,
                                height: 110,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                              )
                            : Image.asset(
                                material.image,
                                width: 110,
                                height: 110,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                              ),
                        Text(
                          material.name,
                          style: const TextStyle(
                            fontSize: 16.0, 
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: (material.items ?? []).map<Widget>((value) => Text(value)).toList(),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            _showPopupDialog(index);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(10),
                          ),
                          child: Image.asset(
                            'assets/images/cart.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}