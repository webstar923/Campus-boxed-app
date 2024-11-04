import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:boxed_project/Utility/color_constant.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({Key? key}) : super(key: key);

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  final String pricingUrl = "https://boxedstorage.org/pricing/";
  final List<Map<String, dynamic>> storageOptions = [
    {
      'title': 'College Cart',
      'price': '\$119/Month',
      'secondPrice': '\$99/Month',
      'description':
          'Our College Carts have inside dimensions of 45" x 27" x 30"',
      'imageUrl': 'assets/images/collegeCart.png',
      'additionalImageUrl': 'assets/images/Mask group.png',
    },
    {
      'title': 'Boxed Box',
      'price': '\$30/Month',
      'description': 'Our "Boxed Boxes" are 18" x 18" x 18"',
      'imageUrl': 'assets/images/BoxedBox.png',
      'additionalImageUrl': 'assets/images/boxedBoxLogo.png',
    },
  ];

  final List<Map<String, dynamic>> _orders = [
    {
      'title': 'Small Order',
      'description': 'Registration with (Complimentary Supplies)',
      'price': '\$25',
      'image': 'assets/images/smallorder.png',
      'buttonImage': 'assets/images/smallMediumButton.png',
      'additionalImageUrl': 'assets/images/dropDownpricing.png',
    },
    {
      'title': 'Medium Order',
      'description': 'Registration with (Complimentary Supplies)',
      'price': '\$25',
      'image': 'assets/images/mediumOrder.png',
      'buttonImage': 'assets/images/smallMediumButton.png',
      'additionalImageUrl': 'assets/images/dropDownpricing.png',
    },
    {
      'title': 'Large Order',
      'description': 'Registration with (Complimentary Supplies)',
      'price': '\$25',
      'image': 'assets/images/largeOrder.png',
      'buttonImage': 'assets/images/largeButton.png',
      'additionalImageUrl': 'assets/images/dropDownpricing.png',
    },
  ];

  final List<Map<String, dynamic>> _data = [
    {
      'title': 'Packing Supplies',
      'boxed': true,
      'cost': '\$50+',
    },
    {
      'title': 'Rental of moving truck',
      'boxed': true,
      'cost': '\$100+',
    },
    {
      'title': 'Professional movers for pick-up and delivery',
      'boxed': true,
      'cost': '\$200+',
    },
    {
      'title': 'Climate-Controlled Storage Unit',
      'boxed': true,
      'cost': '\$100+/Month',
    },
    {
      'title': 'Flights, Hotel, Time, Stress, etc.',
      'boxed': true,
      'cost': '\$100+/Month',
    },
    {
      'title': 'Total Cost for Summer Storage',
      'boxed': false,
      'cost': '\$596 2024 Average',
    },
  ];

  TextSpan formatText(String text) {
    final RegExp regExp = RegExp(r'\d+');
    List<TextSpan> spans = [];
    int start = 0;

    regExp.allMatches(text).forEach((match) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      spans.add(TextSpan(
        text: match.group(0),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ));
      start = match.end;
    });

    if (start < text.length) {
      spans.add(TextSpan(text: text.substring(start)));
    }

    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              height: 150 + MediaQuery.of(context).padding.top,
              color: ColorConstants.primaryColor,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/boxed_logo.png',
                          height: 44,
                          width: 137,
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 20.0),
                      child: Text(
                        'Smart Storage, Simple Pricing',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 10.0),
                      child: Text(
                        'Affordable Plans to Keep Your College Essentials\nSafe and Secure',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: const Color(0xFFF8FAFF),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: storageOptions.length,
                itemBuilder: (context, index) {
                  final option = storageOptions[index];
                  return Container(
                    margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                      color: ColorConstants.primaryWhiteColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 12.0, right: 8.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: SizedBox(
                                  width: 130,
                                  child: Image.asset(
                                    option['additionalImageUrl'],
                                    height: 50,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Image.asset(
                              option['imageUrl'],
                              fit: BoxFit.cover,
                              width: constraints
                                  .maxWidth, // Ensure image takes full width
                            ),
                            const SizedBox(height: 16),
                            Container(
                              color: const Color(0xFFEEF7FF),
                              padding: const EdgeInsets.all(8.0),
                              width: constraints
                                  .maxWidth, // Ensure container takes full width
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    formatText(option['title']),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF000F31),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text.rich(
                                    formatText(option['price']),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF30343D),
                                    ),
                                  ),
                                  if (option.containsKey('secondPrice')) ...[
                                    const SizedBox(height: 8),
                                    Text.rich(
                                      formatText(
                                          'Get your second ${option['title'].toLowerCase()} for Only'),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF30343D),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text.rich(
                                      formatText(option['secondPrice']),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF30343D),
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 16),
                                  Text(
                                    option['description'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  TextButton(
                                    onPressed: () async {
                                      if (await canLaunch(pricingUrl)) {
                                        await launch(pricingUrl);
                                      } else {
                                        throw 'Could not launch $pricingUrl';
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    child: const Text(
                                      'Click For More Information',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: ColorConstants.primaryColor,
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            ColorConstants.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: Container(
                color: ColorConstants.primaryColor,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _orders.length,
                  itemBuilder: (context, index) {
                    final order = _orders[index];
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryWhiteColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Image.asset(order['image'],
                                height: 84.0, width: 97.0),
                            const SizedBox(height: 16),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return Container(
                                  width: constraints.maxWidth,
                                  color: const Color(0xFFEEF7FF),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order['title'],
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          order['description'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          order['price'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return Image.asset(
                                  order['buttonImage'],
                                  height: 64,
                                  width: constraints.maxWidth,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Image.asset(
                                  order['additionalImageUrl'],
                                  height: 28,
                                  width: 28,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                color: const Color(0xFFF8FAFF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Boxed vs. Moving Yourself',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'In addition to saving your time and easing the headache associated with an on-campus move. Boxed also helps you save money.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        height: 89, // Adjust height based on your logo
                        decoration: const BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/boxed_logo.png',
                                height: 25,
                                width: 78,
                              ),
                              const SizedBox(
                                  width:
                                      16), // Add spacing between the image and text
                              const Padding(
                                padding: EdgeInsets.only(right: 18.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Moving',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Yourself',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _data.length,
                      itemBuilder: (context, index) {
                        final item = _data[index];
                        return Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Color(0xFFF5FAFF),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.5, 0.5],
                                ),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        item['title'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50, // Adjust the height as needed
                                    width: 1,
                                    color: Color(
                                        0xFFF2F5FE), // Adjust color and thickness as needed
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: item['boxed'] == true
                                          ? Image.asset(
                                              'assets/images/CheckboxPricing.png',
                                              height: 24,
                                              width: 24,
                                            )
                                          : const SizedBox.shrink(),
                                    ),
                                  ),
                                  Container(
                                    height: 50, // Adjust the height as needed
                                    width: 1,
                                    color: Color(
                                        0xFFF2F5FE), // Adjust color and thickness as needed
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        item['cost'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index != _data.length - 1)
                              const Divider(
                                color: Color(
                                    0xFFF2F5FE), // Adjust color and thickness as needed
                                thickness: 1.0,
                                height: 1.0,
                              ),
                          ],
                        );
                      },
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Image.asset(
                          'assets/images/secureStorageButton.png',
                          height: 100,
                          width: constraints.maxWidth,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
