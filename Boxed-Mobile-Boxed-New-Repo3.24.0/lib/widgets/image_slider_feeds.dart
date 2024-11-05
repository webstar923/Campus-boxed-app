// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:teal/route_structure/navigator.dart';
// import 'package:teal/theme/colors.dart';
// import 'package:teal/theme/font_structures.dart';

// class ActiveDot extends StatelessWidget {
//   const ActiveDot({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 3, right: 3),
//       height: 7,
//       width: 7,
//       decoration: BoxDecoration(
//         color: Palette.themecolor,
//         borderRadius: BorderRadius.circular(50),
//       ),
//     );
//   }
// }

// class InactiveDot extends StatelessWidget {
//   const InactiveDot({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(left: 3, right: 3),
//       height: 7,
//       width: 7,
//       decoration: BoxDecoration(
//         color: Colors.grey.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(50),
//       ),
//     );
//   }
// }

// class FeedImageSlider extends StatefulWidget {
//   // final List items;
//   const FeedImageSlider({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _FeedImageSliderState createState() => _FeedImageSliderState();
// }

// class _FeedImageSliderState extends State<FeedImageSlider> {
//   int activeIndex = 0;

//   setActiveDot(index) {
//     setState(() {
//       activeIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Stack(
//       clipBehavior: Clip.none,
//       alignment: Alignment.topCenter,
//       children: <Widget>[
//         CarouselSlider(
//           options: CarouselOptions(
//             autoPlayInterval: const Duration(seconds: 5),
//             autoPlay: true,
//             height: 300,
//             autoPlayCurve: Curves.fastLinearToSlowEaseIn,
//             autoPlayAnimationDuration: const Duration(seconds: 2),
//             viewportFraction: 1,
//             onPageChanged: (index, reason) {
//               setActiveDot(index);
//             },
//           ),
//           items: List.generate(
//             imageslidercontent.length,
//             (index) {
//               return InkWell(
//                 onTap: () {
//                   Go.named(context, 'view-post');
//                 },
//                 child: Container(
//                   height: 300,
//                   width: size.width,
//                   decoration: const BoxDecoration(
//                     // borderRadius: BorderRadius.circular(20),
//                     image: DecorationImage(
//                       image: NetworkImage(
//                         "https://www.eatingwell.com/thmb/m5xUzIOmhWSoXZnY-oZcO9SdArQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/article_291139_the-top-10-healthiest-foods-for-kids_-02-4b745e57928c4786a61b47d8ba920058.jpg",
//                       ),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       // borderRadius: BorderRadius.circular(20),
//                       gradient: LinearGradient(
//                         colors: [
//                           themeblackcolor.withOpacity(0.2),
//                           themeblackcolor.withOpacity(0.4),
//                           themeblackcolor.withOpacity(0.6),
//                           themeblackcolor.withOpacity(0.9),
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.favorite_border,
//                               color: themewhitecolor,
//                             ),
//                             Space.horizspace(),
//                             const Text(
//                               "22",
//                               style: TextStyle(
//                                 color: themewhitecolor,
//                                 fontWeight: boldfontweight,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Space.horizspace(20),
//                         Row(
//                           children: [
//                             const Icon(
//                               CupertinoIcons.bubble_middle_bottom,
//                               color: themewhitecolor,
//                             ),
//                             Space.horizspace(),
//                             const Text(
//                               "12",
//                               style: TextStyle(
//                                 color: themewhitecolor,
//                                 fontWeight: boldfontweight,
//                               ),
//                             ),
//                           ],
//                         ),
//                         Space.horizspace(20),
//                         Row(
//                           children: [
//                             const Icon(
//                               CupertinoIcons.share,
//                               color: themewhitecolor,
//                             ),
//                             Space.horizspace(),
//                             const Text(
//                               "3",
//                               style: TextStyle(
//                                 color: themewhitecolor,
//                                 fontWeight: boldfontweight,
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Spacer(),
//                         const Icon(
//                           Icons.bookmark_outline,
//                           color: themewhitecolor,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         Positioned(
//           bottom: -25,
//           right: 0,
//           left: 0,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               imageslidercontent.length,
//               (idx) {
//                 return activeIndex == idx
//                     ? const ActiveDot()
//                     : const InactiveDot();
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class FeedImageSliderModel {
//   final String image;
//   FeedImageSliderModel({
//     required this.image,
//   });
// }

// List<FeedImageSliderModel> imageslidercontent = [
//   FeedImageSliderModel(
//     image:
//         "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/29/ea/99/11/exterior.jpg?w=700&h=-1&s=1",
//   ),
//   FeedImageSliderModel(
//     image:
//         "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/23/b2/2e/64/atlantis-the-palm.jpg?w=700&h=-1&s=1",
//   ),
//   FeedImageSliderModel(
//     image:
//         "https://cf.bstatic.com/xdata/images/hotel/max1024x768/445419839.jpg?k=6278d7b2759917b85b4f9cb75210ad7861f64426986a76d077c2ce5dd3023529&o=&hp=1",
//   ),
// ];
