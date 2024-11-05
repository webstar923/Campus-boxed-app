import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:boxed_project/Model/packingMaterial.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/http/api_service.dart';
import 'package:boxed_project/common/base_widget.dart';
import 'package:boxed_project/Utility/common.dart';

class OrderMaterialScreen extends StatefulWidget {
  const OrderMaterialScreen({super.key});

  @override
  OrderMaterialScreenState createState() => OrderMaterialScreenState();
}

class OrderMaterialScreenState extends State<OrderMaterialScreen> {
  List<PackingMaterial> packingMaterials = [];  
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchPackingMaterials();
    });
  }

  Future<void> fetchPackingMaterials() async {
    showLoadingDialog(context);

    void callback(String responseBody, {bool isError = false}) {
      Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

      if (isError) {
        String message = jsonResponse['error'] ?? 'Something went wrong';
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              isLoading = false;
            });
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
        List<dynamic> data = jsonResponse['data'];
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              packingMaterials = data.map((item) => PackingMaterial.fromJson(item)).toList();
              isLoading = false;
            });
            hideLoadingDialog(context);
          });
        }
      }
    }

    await ApiService(context).getPackagingWrapperImages(callback);
  }

  bool isMaterialSelected(PackingMaterial material) {
    return Common.selectedMaterials.contains(material);
  }

  void toggleMaterialSelection(PackingMaterial material) {
    setState(() {
      if (isMaterialSelected(material)) {
        Common.selectedMaterials.remove(material);
      } else {
        Common.selectedMaterials.add(material);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Your Packing Materials',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 2; // Default for small screens
                  double width = constraints.maxWidth;

                  // Adjust crossAxisCount based on screen width
                  if (width > 600) {
                    crossAxisCount = 4;
                  } else if (width > 500) {
                    crossAxisCount = 3;
                  } else if (width > 400) {
                    crossAxisCount = 2;
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 1 / 1.5, // Adjust this value for image-to-text ratio
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: packingMaterials.length,
                    itemBuilder: (context, index) {
                      final material = packingMaterials[index];
                      final isSelected = isMaterialSelected(material);

                      return GestureDetector(
                        onTap: () => toggleMaterialSelection(material),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? ColorConstants.primaryColor
                                  : Colors.grey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Image.network(
                                    material.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${material.name} (${material.price}x)',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(height: 4),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Checkbox(
                                        value: isSelected,
                                        onChanged: (bool? value) {
                                          if (value != null) {
                                            toggleMaterialSelection(material);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}