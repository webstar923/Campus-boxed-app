import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:boxed_project/Utility/color_constant.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  XFile? _selectedFile;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80 + MediaQuery.of(context).padding.top,
            color: ColorConstants.primaryColor,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                    child: Image.asset(
                      'assets/images/boxed_logo.png',
                      height: 62,
                      width: 208,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 253,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/images/contactUs.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Get in touch with us',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 9.0),
                    const Text(
                      'Any Questions? Send us an email and we will answer you promptly!',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'SUPPORT@BOXEDSTORAGE.ORG',
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorConstants.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            controller: _messageController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              labelText: 'Message',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your message';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Process form data
                                  // ...
                                  print('Name: ${_nameController.text}');
                                  print('Email: ${_emailController.text}');
                                  print('Message: ${_messageController.text}');
                                  print('File: ${_selectedFile?.path}');
                                  // Reset the form
                                  _formKey.currentState!.reset();
                                  setState(() {
                                    _selectedFile = null;
                                  });
                                  // Show a success message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Form submitted successfully')),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstants.primaryColor,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                foregroundColor: Colors
                                    .white, // Explicitly set text color to white
                              ),
                              child: const Text('CONTACT US'),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
