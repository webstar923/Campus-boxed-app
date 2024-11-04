import 'package:flutter/material.dart';
import 'package:boxed_project/Home/home_view.dart';
import 'package:boxed_project/FAQs/faqs_screen.dart';
import 'package:boxed_project/TabBar/help_screen.dart';
import 'package:boxed_project/ContactUs/contact_us.dart';
import 'package:boxed_project/pricing/pricing_screen.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/ReservationScreens/reservation_qrcode_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController animationController;
  late Animation<double> animation;

  // GlobalKey for HomePage

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        // Reset HomePage when the Home tab is selected
        // _homePageKey.currentState?.resetPage();
      }
      setState(() {});
    });
    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.decelerate,
    );
    animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    animationController.dispose();
    super.dispose();
  }

  Widget buildTabNavigator(
      GlobalKey<NavigatorState> key, Widget initialScreen) {
    return Navigator(
      key: key,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => initialScreen,
        );
      },
    );
  }

  final GlobalKey<NavigatorState> homeNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> profilenNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> chatNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> pricingNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          buildTabNavigator(homeNavigatorKey, const HomePage()),
          buildTabNavigator(profilenNavigatorKey, const PricingScreen()),
          buildTabNavigator(chatNavigatorKey, const FaqsScreen()),
          buildTabNavigator(pricingNavigatorKey, const ContactUs()),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFFFCFCFC),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        elevation: 0,
        child: TabBar(
          indicatorColor: Colors.red,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          dividerHeight: 0.0,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 0.1, color: Colors.transparent),
          ),
          controller: _tabController,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              icon: Image.asset(
                _tabController.index == 0
                    ? 'assets/images/home_colored.png'
                    : 'assets/images/home_grey.png',
                height: 24,
                width: 24,
              ),
              text: 'Home',
            ),
            Tab(
              icon: Image.asset(
                _tabController.index == 1
                    ? 'assets/images/pricing_colored.png'
                    : 'assets/images/pricing_grey.png',
                height: 24,
                width: 24,
              ),
              child: const FittedBox(
                fit: BoxFit.none,
                child: Text('Pricing'),
              ),
            ),
            Tab(
              icon: Image.asset(
                _tabController.index == 2
                    ? 'assets/images/faqBlue.png'
                    : 'assets/images/faqGrey.png',
                height: 24,
                width: 24,
              ),
              text: 'FAQs',
            ),
            Tab(
              icon: Image.asset(
                _tabController.index == 3
                    ? 'assets/images/phoneBlue.png'
                    : 'assets/images/phoneGrey.png',
                height: 24,
                width: 24,
              ),
              text: 'Contact Us',
            ),
          ],
        ),
      ),
    );
  }
}
