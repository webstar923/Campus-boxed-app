import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/utils/constants.dart';
import 'package:boxed_project/widgets/custom_favorite_button.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';
import 'package:boxed_project/widgets/filled_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themelightgreycolor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverLayoutBuilder(
              builder: (context, constraints) {
                return SliverAppBar(
                  surfaceTintColor: Palette.themecolor,
                  backgroundColor: Palette.themecolor,
                  pinned: true,
                  expandedHeight: 180,
                  elevation: 0,
                  // shape: const RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.vertical(
                  //     bottom: Radius.circular(25),
                  //   ),
                  // ),
                  title: Image.asset(
                    Constants.splashLogo,
                    width: 200,
                  ),
                  actions: [
                    CustomIconButton(
                      onTap: () {},
                      child: const Icon(
                        CupertinoIcons.bell,
                        color: themewhitecolor,
                      ),
                    ),
                    10.kW,
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FilledBox(
                            width: double.infinity,
                            padding: EdgeInsets.zero,
                            color: Palette.themecolor,
                            borderRadius: BorderRadius.circular(0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Smart Storage, Simple Pricing",
                                    style: TextStyle(
                                      fontSize: largefontsize5,
                                      color: themewhitecolor,
                                      fontWeight: boldfontweight,
                                    ),
                                  ),
                                  8.kH,
                                  const Text(
                                    "Affordable Plans to Keep Your College Essentials Safe and Secure",
                                    style: TextStyle(
                                      fontSize: mediumfontsize3,
                                      color: themewhitecolor,
                                      fontWeight: boldfontweightvar1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: [
              collegeCart(),
              25.kH,
              pacakgeCard(),
              25.kH,
              secureStorage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget collegeCart() {
    return ListView.separated(
      itemCount: 2,
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemBuilder: (context, index) {
        return FilledBox(
          padding: EdgeInsets.zero,
          color: Color(0xffEEF7FF),
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FilledBox(
                padding: const EdgeInsets.all(8),
                color: themewhitecolor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        index == 0
                            ? "assets/images/college-cart.png"
                            : "assets/images/boxedBoxLogo.png",
                        height: 80,
                        width: 80,
                      ),
                    ),
                    Image.asset(
                      index == 0
                          ? "assets/images/college-box.png"
                          : "assets/images/BoxedBox.png",
                      height: 200,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      index == 0 ? "College Cart" : "Boxed Box",
                      style: const TextStyle(
                        fontSize: largefontsize5,
                        color: themeblackcolor,
                        fontWeight: boldfontweight,
                      ),
                    ),
                    10.kH,
                    Text.rich(
                      TextSpan(
                        text: index == 0 ? "One Cart for " : "One Box for ",
                        style: const TextStyle(
                          fontSize: mediumfontsize1,
                          color: themeblackcolor,
                          fontWeight: boldfontweightvar1,
                        ),
                        children: [
                          TextSpan(
                            text: index == 0 ? "\$119/Month" : "\$30/Month",
                            style: const TextStyle(
                              fontSize: mediumfontsize1,
                              color: themeblackcolor,
                              fontWeight: boldfontweight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.kH,
                    index == 0
                        ? const Text.rich(
                            TextSpan(
                              text: "Get your second cart for Only ",
                              style: TextStyle(
                                fontSize: mediumfontsize1,
                                color: themeblackcolor,
                                fontWeight: boldfontweightvar1,
                              ),
                              children: [
                                TextSpan(
                                  text: "\$99/Month!",
                                  style: TextStyle(
                                    fontSize: mediumfontsize1,
                                    color: themeblackcolor,
                                    fontWeight: boldfontweight,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    10.kH,
                    Text.rich(
                      TextSpan(
                        text: index == 0
                            ? "Our College Carts have inside dimensions of "
                            : "Our 'Boxed Boxes' are 18 x 18 x 18",
                        style: const TextStyle(
                          fontSize: mediumfontsize1,
                          color: themeblackcolor,
                          fontWeight: boldfontweightvar1,
                        ),
                        children: [
                          TextSpan(
                            text: index == 0 ? "45 x 27 x 30" : "",
                            style: const TextStyle(
                              fontSize: mediumfontsize1,
                              color: themeblackcolor,
                              fontWeight: boldfontweight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.kH,
                    const Text(
                      "Click For More information",
                      style: TextStyle(
                        fontSize: mediumfontsize1,
                        color: Palette.themecolor,
                        fontWeight: boldfontweight,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, seprator) {
        return 15.kH;
      },
    );
  }

  Widget pacakgeCard() {
    return FilledBox(
      color: Palette.themecolor,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(0),
      child: ListView.separated(
        itemCount: 3,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        itemBuilder: (context, index) {
          return FilledBox(
            padding: EdgeInsets.zero,
            color: Color(0xffEEF7FF),
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilledBox(
                  padding: const EdgeInsets.all(8),
                  color: themewhitecolor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        index == 0
                            ? "assets/images/smallorder.png"
                            : index == 1
                                ? "assets/images/mediumOrder.png"
                                : "assets/images/largeOrder.png",
                        height: 150,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        index == 0
                            ? "Small Order"
                            : index == 1
                                ? "Medium Order"
                                : "Large Order",
                        style: const TextStyle(
                          fontSize: largefontsize5,
                          color: themeblackcolor,
                          fontWeight: boldfontweight,
                        ),
                      ),
                      10.kH,
                      Text.rich(
                        TextSpan(
                          text: index == 0
                              ? "Registration with (Complimentary Supplies) - "
                              : index == 1
                                  ? "Medium Order Registration with (Complimentary Supplies) - "
                                  : "Registration with (Complimentary Supplies) - ",
                          style: const TextStyle(
                            fontSize: mediumfontsize1,
                            color: themeblackcolor,
                            fontWeight: boldfontweightvar1,
                          ),
                          children: [
                            TextSpan(
                              text: index == 0
                                  ? "\$25"
                                  : index == 1
                                      ? "\$25"
                                      : "\$25",
                              style: const TextStyle(
                                fontSize: mediumfontsize1,
                                color: themeblackcolor,
                                fontWeight: boldfontweight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/images/largeButton.png",
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, seprator) {
          return 15.kH;
        },
      ),
    );
  }

  Widget secureStorage() {
    return FilledBox(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(0),
      color: themewhitecolor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Boxed vs. Moving Yourself",
              style: TextStyle(
                fontSize: largefontsize6,
                color: Palette.themecolor,
                fontWeight: boldfontweight,
              ),
            ),
            10.kH,
            const Text(
              "In addition to saving your time and easing the headache associated with an on-campus move, Boxed also helps you save money.",
              style: TextStyle(
                fontSize: mediumfontsize1,
                color: themeblackcolor,
                fontWeight: boldfontweightvar1,
              ),
            ),
            20.kH,
            FilledBox(
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(12),
              color: themewhitecolor,
              child: Column(
                children: [
                  FilledBox(
                    height: 100,
                    padding: EdgeInsets.zero,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Palette.themecolor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Row(
                        children: [
                          const Spacer(),
                          Image.asset(
                            Constants.splashLogo,
                            width: 120,
                          ),
                          10.kW,
                          const SizedBox(
                            width: 75,
                            child: Text(
                              "Moving Yourself",
                              style: TextStyle(
                                fontSize: mediumfontsize1,
                                color: themelightgreycolor,
                                fontWeight: boldfontweightvar1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  15.kH,
                  ListView.separated(
                    itemCount: 6,
                    shrinkWrap: true,
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              index == 0
                                  ? "Packing Supplies"
                                  : index == 1
                                      ? "Rental of moving truck"
                                      : index == 2
                                          ? "Professional movers for pick-up and delivery"
                                          : index == 3
                                              ? "Climate-Controlled Storage Unit"
                                              : index == 4
                                                  ? "Flights, Hotel, Time, Stress, etc."
                                                  : "Total Cost for  Summer Storage",
                              style: const TextStyle(
                                fontSize: mediumfontsize3,
                                color: themeblackcolor,
                                fontWeight: boldfontweightvar1,
                              ),
                            ),
                          ),
                          const Spacer(),
                          const CustomCheckButton(),
                          10.kW,
                          SizedBox(
                            width: 80,
                            child: Text(
                              index == 0
                                  ? "\$50+"
                                  : index == 1
                                      ? "\$100+"
                                      : index == 2
                                          ? "\$200+"
                                          : index == 3
                                              ? "\$100+ /Month"
                                              : index == 4
                                                  ? "\$100+ /Month"
                                                  : "\$100+ /Month",
                              style: const TextStyle(
                                fontSize: mediumfontsize2,
                                color: Palette.themecolor,
                                fontWeight: boldfontweight,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, seprator) {
                      return 15.kH;
                    },
                  ),
                  15.kH,
                  Image.asset(
                    "assets/images/secureStorageButton.png",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
