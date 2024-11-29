import 'package:boxed_project/route_structure/go_navigator.dart';
import 'package:boxed_project/utils/constants.dart';
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
import 'package:boxed_project/views/home/widget/schools_we_serve.dart'; // Schools We Server Widget.
import 'package:boxed_project/views/home/widget/trusted_partner.dart'; // Trusted partner Widget
import 'package:boxed_project/views/home/widget/servey.dart'; // Trusted partner Widget
import 'package:boxed_project/views/home/widget/self_move.dart'; // Widget
import 'package:provider/provider.dart';
import 'package:boxed_project/provider/auth_provider.dart';
import 'package:boxed_project/views/reservation/reserve_now.dart';
import 'package:boxed_project/views/auth/signup_screen.dart';
import 'package:boxed_project/views/widget/loading_button.dart';
import 'package:boxed_project/views/widget/customsnapbar.dart';
import 'package:boxed_project/controllers/notification_controller.dart';
import 'package:boxed_project/route_structure/go_navigator.dart';
import 'package:boxed_project/route_structure/go_router.dart';

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
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late NotificationController _notificationController;

  @override
  void initState() {
    super.initState();
     _notificationController = NotificationController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    bool isLoggedIn = Provider.of<AuthProvider>(context).isLoggedIn;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Go.named(context, RouteName.welcomeScreen);
        return false;
      },
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [

              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverPersistentHeaderDelegate(
                  minHeight: 60,
                  maxHeight: 60,
                  child: Container(
                    color: Palette.themecolor,
                    child: Padding(
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                Constants.splashLogo,
                                width: 200,
                              ),
                            ),
                          ),
                          CustomIconButton(
                            onTap: () {},
                            child: const Icon(
                              CupertinoIcons.bell,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Divider(),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverPersistentHeaderDelegate(
                  minHeight: 60,
                  maxHeight: 60,
                  child: Container(
                    color: Palette.themecolor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      child: GestureDetector(
                        onTap: () {
                          if (isLoggedIn) {
                            Go.route(
                              context,
                              const ReserveNow(),
                            );
                          } else {
                            Go.route(
                              context,
                              const SignupScreen(),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF004BA0), // Button color
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "RESERVE NOW",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // SliverAppBar with flexible background
              SliverAppBar(
                surfaceTintColor: Palette.themecolor,
                backgroundColor: Palette.themecolor,
                pinned: false,
                expandedHeight: 300,
                elevation: 2,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: FilledBox(
                    width: double.infinity,
                    padding: EdgeInsets.zero,
                    image: const DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          10.kH,
                          banners(size), // Custom banner widget
                          10.kH,
                        ],
                      ),
                    ),
                  ),
                ),
              ),];
          },

          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        setReminderWidget(),
                        howWeWork(),
                        SchoolsWeServeWidget(),
                        TrustedPartner(),
                        SelfMove(),
                        Servey(),
                        setReminderWidget(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget banners(size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageSlider(
            leftMargin: 5,
            rightMargin: 5,
            borderRadius: 7,
            images: const [
              'assets/images/banner1.png',
              'assets/images/banner2.png',
              'assets/images/banner3.png',
            ],
            height: size.height / 100 * 40,
            isNetworkImage: false,
            useShadow: false,
            isShowIndicator: true,
            indicatorPositionBottom: -180,
          ),
        ],
      ),
    );
  }

  // "Set a Reminder" widget
  Widget setReminderWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(1), // Border radius of 1
            border: Border.all(
              color: Palette.themecolor, // Border color
              width: 1, // Border width
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Heading Text
                const Text(
                  "Set a Reminder!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // Description Text
                const Text(
                  "We will remind you to sign up for summer storage",
                  style: TextStyle(fontSize: 17, 
                  color: Colors.grey,
                  fontWeight:normalfontweightvar2,
                  ),
                  textAlign: TextAlign.center,
                ),
                20.kH,
                // Phone Number Input
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      hintText: "Enter your phone number",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                        fontSize: mediumfontsize5,
                        fontWeight: normalfontweightvar1, // Set font weight to normal
                    ),
                  ),
                ),
                15.kH,
                // Email Input
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      hintText: "Enter your email",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                        fontSize: mediumfontsize5,
                        fontWeight: normalfontweightvar1, // Set font weight to normal
                    ),
                  ),
                ),
                // 20.kH,
                // "Remind Me" Button
                Padding(
                  padding: EdgeInsets.all(16),
                  child: LoadingButton(
                    onPressed: () async {
                      if(_emailController.text != '' && _phoneController.text != ''){
                          await _notificationController.registerNotificationUser(_emailController.text,_phoneController.text);
                          CustomSnackBar.show(context, 'Success: Notification Registered');
                      }
                      else{
                          CustomSnackBar.show(context, 'Enter Email and Phone Number');
                      }
                    },
                    text: 'Remind Me',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget howWeWork() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "How We Work",
              style: TextStyle(
                fontSize: largefontsize5,
                fontWeight: boldfontweight,
                color: Palette.themecolor,
              ),
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
                  ? "assets/images/reserve-your-spot.png"
                  : index == 1
                      ? "assets/images/pack-your-item.png"
                      : index == 2
                          ? "assets/images/cart.png"
                          : "assets/images/contact.png",
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
      ],
    );
  }
}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverPersistentHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

