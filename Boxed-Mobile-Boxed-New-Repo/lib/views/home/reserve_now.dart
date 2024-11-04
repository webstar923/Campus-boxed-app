import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/utils/constants.dart';
import 'package:boxed_project/widgets/custom_button.dart';
import 'package:boxed_project/widgets/custom_drop_down.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';
import 'package:boxed_project/widgets/custom_text_field.dart';
import 'package:boxed_project/widgets/filled_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReserveNow extends StatefulWidget {
  const ReserveNow({super.key});

  @override
  State<ReserveNow> createState() => _ReserveNowState();
}

class _ReserveNowState extends State<ReserveNow> {
  final PageController _pageController = PageController(initialPage: 0);
  int pageIndex = 0;
  bool? check = false;
  bool? check1 = false;
  int selectSchool = 0;
  int selectPayment = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Column(
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

                      // search
                      // letsTrack(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              width: 150,
              borderRadius: BorderRadius.circular(12),
              child: const Center(
                child: Text(
                  'Previous',
                  style: TextStyle(
                    color: themewhitecolor,
                    fontSize: mediumfontsize3,
                  ),
                ),
              ),
              onTap: () {
                if (pageIndex == 3) {
                  _pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                }
                if (pageIndex == 2) {
                  _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                } else if (pageIndex == 1) {
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                } else if (pageIndex == 0) {
                  Navigator.pop(context);
                }
              },
            ),
            CustomButton(
              onTap: () {
                if (pageIndex == 0) {
                  _pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                } else if (pageIndex == 1) {
                  _pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                } else if (pageIndex == 2) {}
              },
              width: 150,
              child: Text(
                pageIndex == 2 ? 'Finish' : "Next",
                style: TextStyle(
                  fontSize: mediumfontsize1,
                  color: themewhitecolor,
                  fontWeight: boldfontweight,
                ),
              ),
            ),
          ],
        ),
      ],
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (int page) {
                setState(() {
                  pageIndex = page;
                });
              },
              children: [
                fillForms(size),
                letsTrackFroms(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget fillForms(size) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
              "Phone Number or Email",
              style: TextStyle(
                fontSize: mediumfontsize1,
                color: themeblackcolor,
                fontWeight: boldfontweightvar1,
              ),
            ),
            5.kH,
            const CustomTextField(
              textInputType: TextInputType.text,
              hintText: "Phone Number or Email",
              isOutlinedInputBorder: true,
              filled: true,
              fillColor: themetextfieldcolor,
              focusedBorderColor: Palette.themecolor,
              borderWidth: 1.5,
            ),
            15.kH,
            const Text(
              "Select School",
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
              "Select Payment",
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
      ),
    );
  }

  Widget letsTrackFroms() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
      ),
    );
  }
}
