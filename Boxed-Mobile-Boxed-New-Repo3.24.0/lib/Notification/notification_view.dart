import 'package:flutter/material.dart';
import 'package:boxed_project/Notification/news.dart';
import 'package:boxed_project/Notification/offers.dart';
import 'package:boxed_project/Utility/color_constant.dart';
import 'package:boxed_project/Notification/your_trips.dart';

class NotficationView extends StatefulWidget {
  @override
  _NotficationViewState createState() => _NotficationViewState();
}

class _NotficationViewState extends State<NotficationView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isTripsBadge = false;
  bool isOfferBadge = true;
  bool isNewsBadge = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 140,
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            color: ColorConstants.primaryColor, // Adjust the color as needed
            child: Column(children: [
              const SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 8.0),
                  const Text(
                    'Notification',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ]),
          ),
          Container(
              height: 60,
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
              color: ColorConstants.primaryColor,
              child: TabBar(
                indicatorColor: Colors.white,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                dividerHeight: 0.0,
                controller: _tabController,
                indicatorWeight: 3.0,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Your Orders',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(width: 4.0),
                        if (isTripsBadge)
                          Container(
                            width: 9.0,
                            height: 9.0,
                            decoration: const BoxDecoration(
                              color:
                                  Colors.orange, // Adjust the color as needed
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Offers',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            )),
                        const SizedBox(width: 4.0),
                        if (isOfferBadge)
                          Container(
                            width: 9.0,
                            height: 9.0,
                            decoration: const BoxDecoration(
                              color:
                                  Colors.orange, // Adjust the color as needed
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [NewsScreen(), OfferScreen()],
            ),
          ),
        ],
      ),
    );
  }
}
