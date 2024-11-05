import 'package:boxed_project/route_structure/go_navigator.dart';
import 'package:boxed_project/utils/constants.dart';
import 'package:boxed_project/views/home/reserve_now.dart';
import 'package:boxed_project/views/home/widget/card.dart';
import 'package:boxed_project/widgets/custom_button.dart';
import 'package:boxed_project/widgets/custom_drop_down.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';
import 'package:boxed_project/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/widgets/filled_box.dart';
import 'package:boxed_project/widgets/image_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? check = false;
  bool? check1 = false;
  int selectSchool = 0;
  int selectPayment = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverLayoutBuilder(
              builder: (context, constraints) {
                return SliverAppBar(
                  surfaceTintColor: Palette.themecolor,
                  backgroundColor: Palette.themecolor,
                  pinned: true,
                  expandedHeight: 580,
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
                    background: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FilledBox(
                          width: double.infinity,
                          padding: EdgeInsets.zero,
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/background.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                10.kH,
                                // banner
                                banners(size),
                                // search
                                // letsTrack(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ];
        },
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // fillForms(size),
                      howWeWork(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget banners(size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageSlider(
            leftMargin: 10,
            rightMargin: 10,
            borderRadius: 14,
            images: const [
              'assets/images/banner-1.png',
              'assets/images/banner-1.png',
              'assets/images/banner-1.png',
            ],
            height: size.height / 100 * 45,
            // image size error issue
            isNetworkImage: false,
            useShadow: false,
            isShowIndicator: true,
            indicatorPositionBottom: -18,
          ),
          // Center(
          //   child: FilledBox(
          //     height: size.height / 100 * 45,
          //     width: size.width / 100 * 75,
          //     padding: EdgeInsets.zero,
          //     borderRadius: BorderRadius.circular(12),
          //     color: themewhitecolor,
          //     image: const DecorationImage(
          //       image: AssetImage(
          //         "assets/images/banner-1.png",
          //       ),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          30.kH,
          CustomButton(
            onTap: () {
              Go.route(
                context,
                const ReserveNow(),
              );
            },
            height: 60,
            buttoncolor: themewhitecolor,
            child: const Text(
              "Reserve Now",
              style: TextStyle(
                fontSize: mediumfontsize1,
                color: Palette.themecolor,
                fontWeight: boldfontweight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget howWeWork() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "How We Work",
            style: TextStyle(
              fontSize: largefontsize5,
              fontWeight: boldfontweight,
              color: Palette.themecolor,
            ),
          ),
        ),
        15.kH,
        ListView.separated(
          itemCount: 4,
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            return ReserveCard(
              image: index == 0
                  ? "assets/images/reserve1.png"
                  : index == 1
                      ? "assets/images/reserve2.png"
                      : index == 2
                          ? "assets/images/reserve3.png"
                          : "assets/images/reserve4.png",
              title: index == 0
                  ? "Reserve your Spot"
                  : index == 1
                      ? "Pack your Items"
                      : index == 2
                          ? "Receive Your College Cart"
                          : "Contact Us for Drop-Off",
              subtitle: index == 0
                  ? "Reserve your spot today and enjoy  hassle-free summer storage solutions for college students. From pickup to drop-off, Boxed has you covered every step of the way."
                  : index == 1
                      ? "Pack your Items Prior to your pickup date, Boxed will provide you with complementary moving materials, including our 18”x18”x18” heavy duty “Boxed Box”."
                      : index == 2
                          ? "We reduce the friction of your move by providing the materials you need on pickup day, including our easy-to-use COLLEGE CART that can fit 25 cubic feet of goods."
                          : "Ready to receive your belongings? Boxed will ensure you have a seamless transition back from summer break with our convenient and reliable service.",
            );
          },
          separatorBuilder: (context, seprator) {
            return 25.kH;
          },
        ),
        25.kH,
        Center(
          child: Column(
            children: [
              const Text(
                "Do our Questionnaire for a",
                style: TextStyle(
                  fontSize: mediumfontsize1,
                  color: Palette.themecolor,
                  fontWeight: boldfontweight,
                ),
              ),
              5.kH,
              const Text(
                "\$5 Amazon Gift Card!",
                style: TextStyle(
                  fontSize: largefontsize5,
                  color: Palette.themecolor,
                  fontWeight: boldfontweight,
                ),
              ),
              10.kH,
              CustomButton(
                onTap: () {},
                height: 45,
                width: 200,
                buttoncolor: Colors.transparent,
                borderRadius: BorderRadius.circular(1),
                border: Border.all(color: Palette.themecolor),
                child: const Text(
                  "Surveys",
                  style: TextStyle(
                    fontSize: mediumfontsize1,
                    color: Palette.themecolor,
                    fontWeight: boldfontweight,
                  ),
                ),
              ),
              15.kH,
              Icon(
                Icons.play_circle,
                color: Palette.themecolor.withOpacity(0.7),
                size: 50,
              ),
              15.kH,
            ],
          ),
        ),
      ],
    );
  }

  Widget letsTrack() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            "Let’s Track Your Package",
            style: TextStyle(
              fontSize: largefontsize5,
              fontWeight: boldfontweight,
              color: themewhitecolor,
            ),
          ),
        ),
        15.kH,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: CustomTextField(
            filled: true,
            fillColor: themewhitecolor,
            textInputType: TextInputType.text,
            hintText: "Enter your tracking number",
            isOutlinedInputBorder: true,
            enabledBorderColor: themegreycolor,
            focusedBorderColor: Palette.themecolor,
            borderWidth: 1.5,
            prefix: Icon(
              Icons.search,
              color: themegreytextcolor,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget letsTrackFroms() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Full Name",
            style: TextStyle(
              fontSize: mediumfontsize1,
              color: themeblackcolor,
              fontWeight: boldfontweightvar1,
            ),
          ),
          5.kH,
          const CustomTextField(
            textInputType: TextInputType.text,
            hintText: "Enter Full Name",
            isOutlinedInputBorder: true,
            filled: true,
            fillColor: themetextfieldcolor,
            focusedBorderColor: Palette.themecolor,
            borderWidth: 1.5,
          ),
          15.kH,
          const Text(
            "Are you a Student or Parent/Family Member",
            style: TextStyle(
              fontSize: mediumfontsize1,
              color: themeblackcolor,
              fontWeight: boldfontweightvar1,
            ),
          ),
          15.kH,
          Row(
            children: [
              SizedBox(
                width: 130,
                child: CheckboxListTile(
                  activeColor: Palette.themecolor,
                  contentPadding: EdgeInsets.zero,
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  value: check,
                  onChanged: (bool? value) {
                    setState(() {
                      check = value;
                    });
                  },
                  title: const Text(
                    "Student",
                    style: TextStyle(
                      fontSize: mediumfontsize5,
                      color: themegreytextcolor,
                      fontWeight: normalfontweightvar1,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              10.kW,
              SizedBox(
                width: 250,
                child: CheckboxListTile(
                  activeColor: Palette.themecolor,
                  contentPadding: EdgeInsets.zero,
                  checkboxShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  value: check1,
                  onChanged: (bool? value) {
                    setState(() {
                      check1 = value;
                    });
                  },
                  title: const Text(
                    "Parent/ Family Member",
                    style: TextStyle(
                      fontSize: mediumfontsize5,
                      color: themegreytextcolor,
                      fontWeight: normalfontweightvar1,
                    ),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
            ],
          ),
          20.kH,
          const Text(
            "Student Email",
            style: TextStyle(
              fontSize: mediumfontsize1,
              color: themeblackcolor,
              fontWeight: boldfontweightvar1,
            ),
          ),
          5.kH,
          const CustomTextField(
            textInputType: TextInputType.text,
            hintText: "Email Address",
            isOutlinedInputBorder: true,
            filled: true,
            fillColor: themetextfieldcolor,
            focusedBorderColor: Palette.themecolor,
            borderWidth: 1.5,
          ),
          20.kH,
          const Text(
            "Parent/Family Member Email",
            style: TextStyle(
              fontSize: mediumfontsize1,
              color: themeblackcolor,
              fontWeight: boldfontweightvar1,
            ),
          ),
          5.kH,
          const CustomTextField(
            textInputType: TextInputType.text,
            hintText: "Email Address",
            isOutlinedInputBorder: true,
            filled: true,
            fillColor: themetextfieldcolor,
            focusedBorderColor: Palette.themecolor,
            borderWidth: 1.5,
          ),
          15.kH,
          const Text(
            "Are You An?",
            style: TextStyle(
              fontSize: mediumfontsize1,
              color: themeblackcolor,
              fontWeight: boldfontweightvar1,
            ),
          ),
          5.kH,
          CustomDropDown(
            hint: 'Select',
            errorText: '',
            value: selectSchool,
            items: [
              const DropdownMenuItem(
                value: 0,
                child: Text('Type 1'),
              ),
              const DropdownMenuItem(
                value: 1,
                child: Text('Type 2'),
              ),
            ].cast<DropdownMenuItem<int>>(),
            onChanged: (value) {
              setState(() {
                selectSchool = value;
              });
            },
          ),
          15.kH,
          const Text(
            "Do You Live In?",
            style: TextStyle(
              fontSize: mediumfontsize1,
              color: themeblackcolor,
              fontWeight: boldfontweightvar1,
            ),
          ),
          5.kH,
          CustomDropDown(
            hint: 'Select',
            errorText: '',
            value: selectPayment,
            items: [
              const DropdownMenuItem(
                value: 0,
                child: Text('Type 1'),
              ),
              const DropdownMenuItem(
                value: 1,
                child: Text('Type 2'),
              ),
            ].cast<DropdownMenuItem<int>>(),
            onChanged: (value) {
              setState(() {
                selectPayment = value;
              });
            },
          ),
          15.kH,
          const Text(
            "Expected Graduation Year?",
            style: TextStyle(
              fontSize: mediumfontsize1,
              color: themeblackcolor,
              fontWeight: boldfontweightvar1,
            ),
          ),
          5.kH,
          CustomDropDown(
            hint: 'Select',
            errorText: '',
            value: selectPayment,
            items: [
              const DropdownMenuItem(
                value: 0,
                child: Text('Type 1'),
              ),
              const DropdownMenuItem(
                value: 1,
                child: Text('Type 2'),
              ),
            ].cast<DropdownMenuItem<int>>(),
            onChanged: (value) {
              setState(() {
                selectPayment = value;
              });
            },
          ),
          20.kH,
          CustomButton(
            onTap: () {},
            height: 55,
            borderRadius: BorderRadius.circular(10),
            child: const Text(
              "Reserve",
              style: TextStyle(
                color: themewhitecolor,
                fontSize: mediumfontsize3,
                fontWeight: boldfontweight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
