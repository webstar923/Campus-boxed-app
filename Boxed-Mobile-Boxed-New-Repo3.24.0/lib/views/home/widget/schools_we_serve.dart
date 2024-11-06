import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SchoolsWeServeWidget extends StatelessWidget {
  final List<String> schoolImages = [
    'assets/images/Davidson-Logo.png',
    'assets/images/Davidson-Logo-Transparent.png',
    'assets/images/UNC-Charlotte-Logo-e1712655936954.png',
  ];

  final List<Map<String, String>> contentSections = [
    {
      'image': 'assets/images/medium-shot-man-walking-warehouse.png',
      'text': 'Boxed Campus Storage is a student storage provider that works with reputable third-party storage and moving companies to assist with all of your student storage needs.'
    },
    {
      'image': 'assets/images/image-5.png',
      'text': 'As a part of our world-class customer service, we provide complimentary packing boxes, moving materials, and a College Cart for your use; our Uline moving carts will enable the easiest move of your life.'
    },
    {
      'image': 'assets/images/1-1.png',
      'text': 'After you provide your packed College Cart to the movers, your items are secured in a climate-controlled storage facility until you request delivery of your goods.'
    },
    {
      'image': 'assets/images/Boxed-Blue-Cart-1.png',
      'text': 'Boxed Campus Storage is Charlotte’s Premier Student Valet Storage Provider, Streamlining On-Campus Move-In and Move-Out Experiences for Students, Families, and School Staff.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Schools We Serve",
              style: TextStyle(
                fontSize: largefontsize5,
                fontWeight: boldfontweight,
                color: Palette.themecolor,
              ),
            ),
          ),
        ),
        15.kH,        
        
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: Text(
        //     'Schools We Serve',
        //     style: TextStyle(
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),

        // Carousel with BackdropFilter
        CarouselSlider(
          options: CarouselOptions(
            height: 100, // Adjust height to give more space for centering
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            enlargeCenterPage: true,
            viewportFraction: 0.8,
          ),
          
          items: schoolImages.map((imagePath) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        // Blurred background
                        BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                        // Centered Image
                        Center(
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 10),
          // Text fitting in the container
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Horizontal padding for text
          child: Text(
            "Stress-Free Storage for Students",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Palette.themecolor,
              fontWeight:normalfontweightvar1
            ),
          ),
        ),
        // Sections based on content
        ...contentSections.map((section) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF121665),
                // borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.zero,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [                  
                  // Image fitting in the container
                  ClipRRect(
                    // borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      section['image']!,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover
                    ),
                  ),
                  SizedBox(height: 10),
                  // Text fitting in the container
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Horizontal padding for text
                    child: Text(
                      section['text']!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight:normalfontweightvar1
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),

      ],
    );
  }
}
