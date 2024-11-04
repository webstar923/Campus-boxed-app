import 'package:boxed_project/views/chats/chat_screen.dart';
import 'package:boxed_project/views/pricing/pricing_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/views/home/home_screen.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class NavBar extends StatefulWidget {
  String currentIndex;
  final int indexCategory;
  NavBar({
    Key? key,
    required this.currentIndex,
    this.indexCategory = 0,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: int.parse(widget.currentIndex),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      widget.currentIndex = page.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomIconButton(
              onTap: () {},
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: themegreycolor,
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor: Palette.themecolor,
                  child: Icon(
                    CupertinoIcons.qrcode_viewfinder,
                    color: themewhitecolor,
                    size: 25,
                  ),
                ),
              ),
            ),
            const Text(
              "Scan\nan item",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [
          HomeScreen(),
          ChatScreen(),
          PricingScreen(),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: themewhitecolor,
        height: kToolbarHeight,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: widget.currentIndex == "0"
                  ? const Column(
                      children: [
                        Icon(
                          Icons.home,
                          color: Palette.themecolor,
                        ),
                        Text(
                          "Home",
                        ),
                      ],
                    )
                  : const Column(
                      children: [
                        Icon(
                          Icons.home_outlined,
                        ),
                        Text(
                          "Home",
                        ),
                      ],
                    ),
            ),
            // label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: widget.currentIndex == "1"
                  ? const Column(
                      children: [
                        Icon(
                          CupertinoIcons.bubble_middle_bottom_fill,
                          color: Palette.themecolor,
                        ),
                        Text(
                          "Chat",
                        ),
                      ],
                    )
                  : const Column(
                      children: [
                        Icon(
                          CupertinoIcons.bubble_middle_bottom,
                        ),
                        Text(
                          "Chat",
                        ),
                      ],
                    ),
            ),
            // label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: widget.currentIndex == "2"
                  ? const Column(
                      children: [
                        Icon(
                          CupertinoIcons.bookmark_fill,
                          color: Palette.themecolor,
                        ),
                        Text(
                          "Pricing",
                        ),
                      ],
                    )
                  : const Column(
                      children: [
                        Icon(
                          CupertinoIcons.bookmark,
                        ),
                        Text(
                          "Pricing",
                        ),
                      ],
                    ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: widget.currentIndex == "3"
                  ? const Column(
                      children: [
                        Icon(
                          CupertinoIcons.person_crop_circle_fill,
                          color: Palette.themecolor,
                        ),
                        Text(
                          "Account",
                        ),
                      ],
                    )
                  : const Column(
                      children: [
                        Icon(
                          CupertinoIcons.person_crop_circle,
                        ),
                        Text(
                          "Account",
                        ),
                      ],
                    ),
            ),
          ),
        ],
        currentIndex: int.parse(widget.currentIndex),
        activeColor: Palette.themecolor,
        iconSize: 28,
        onTap: navigationTapped,
      ),
    );
  }
}
