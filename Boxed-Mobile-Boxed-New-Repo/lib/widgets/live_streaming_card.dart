// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:vshop/theme/colors.dart';
// import 'package:vshop/theme/font_structures.dart';
// import 'package:vshop/theme/spacing.dart';
// import 'package:vshop/widgets/filled_box.dart';

// class LiveStreamingCard extends StatefulWidget {
//   final String userImage;
//   final String userName;
//   final String videoLink;
//   final double height;
//   final double width;
//   const LiveStreamingCard({
//     super.key,
//     required this.userImage,
//     required this.userName,
//     required this.videoLink,
//     this.height = 200,
//     this.width = 350,
//   });

//   @override
//   State<LiveStreamingCard> createState() => _LiveStreamingCardState();
// }

// class _LiveStreamingCardState extends State<LiveStreamingCard> {
//   late VideoPlayerController _videoController;
//   @override
//   void initState() {
//     super.initState();
//     _videoController = VideoPlayerController.networkUrl(
//       Uri.parse(widget.videoLink),
//     );
//     _videoController.initialize().then((_) {
//       // setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _videoController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: widget.height,
//           width: widget.width,
//           // padding: const EdgeInsets.symmetric(
//           //   vertical: 10,
//           //   horizontal: 15,
//           // ),
//           foregroundDecoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             gradient: LinearGradient(
//               colors: [
//                 themeblackcolor.withOpacity(0.3),
//                 themeblackcolor.withOpacity(0.4),
//                 themeblackcolor.withOpacity(0.5),
//                 themeblackcolor.withOpacity(0.8),
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: VideoPlayer(_videoController),
//           ),
//         ),
//         SizedBox(
//           height: widget.height,
//           width: widget.width,
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     FilledBox(
//                       height: 25,
//                       width: 60,
//                       padding: EdgeInsets.zero,
//                       color: themeredcolor,
//                       borderRadius: BorderRadius.circular(30),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const CircleAvatar(
//                             radius: 3,
//                           ),
//                           Spacing.h(5),
//                           const Text(
//                             "Live",
//                             style: TextStyle(
//                               color: themewhitecolor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     FilledBox(
//                       height: 25,
//                       width: 60,
//                       padding: EdgeInsets.zero,
//                       color: Palette.themecolor,
//                       borderRadius: BorderRadius.circular(30),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const Icon(
//                             Icons.remove_red_eye,
//                             color: themewhitecolor,
//                             size: 15,
//                           ),
//                           Spacing.h(5),
//                           const Text(
//                             "1.3k",
//                             style: TextStyle(
//                               color: themewhitecolor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 16,
//                       backgroundImage: NetworkImage(
//                         widget.userImage,
//                       ),
//                     ),
//                     Spacing.h(),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.userName,
//                           style: const TextStyle(
//                             color: themewhitecolor,
//                             fontSize: mediumfontsize5,
//                             fontWeight: boldfontweight,
//                           ),
//                         ),
//                         const Text(
//                           "Alpha",
//                           style: TextStyle(
//                             color: themewhitecolor,
//                             fontSize: smallfontsize2,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),

//         // Container(
//         //   height: 225,
//         //   width: 170,
//         //   decoration: BoxDecoration(
//         //     borderRadius: BorderRadius.circular(12),
//         //     image: const DecorationImage(
//         //       image: NetworkImage(
//         //         "https://engine.com.pk/cdn/shop/files/Men_Sweatshirt.png?v=1698753383",
//         //       ),
//         //       fit: BoxFit.cover,
//         //     ),
//         //   ),
//         //   child: Container(
//         //     padding: const EdgeInsets.symmetric(
//         //       vertical: 10,
//         //       horizontal: 15,
//         //     ),
//         //     decoration: BoxDecoration(
//         //       borderRadius: BorderRadius.circular(12),
//         //       gradient: LinearGradient(
//         //         colors: [
//         //           themeblackcolor.withOpacity(0.2),
//         //           themeblackcolor.withOpacity(0.3),
//         //           themeblackcolor.withOpacity(0.4),
//         //           themeblackcolor.withOpacity(0.8),
//         //         ],
//         //         begin: Alignment.topCenter,
//         //         end: Alignment.bottomCenter,
//         //       ),
//         //     ),
//         //     child: Column(
//         //       crossAxisAlignment: CrossAxisAlignment.start,
//         //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //       children: [
//         //         Row(
//         //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //           children: [
//         //             FilledBox(
//         //               height: 25,
//         //               width: 60,
//         //               padding: EdgeInsets.zero,
//         //               color: themeredcolor,
//         //               borderRadius: BorderRadius.circular(30),
//         //               child: Row(
//         //                 mainAxisAlignment: MainAxisAlignment.center,
//         //                 children: [
//         //                   const CircleAvatar(
//         //                     radius: 3,
//         //                   ),
//         //                   Spacing.h(5),
//         //                   const Text(
//         //                     "Live",
//         //                     style: TextStyle(
//         //                       color: themewhitecolor,
//         //                     ),
//         //                   ),
//         //                 ],
//         //               ),
//         //             ),
//         //             FilledBox(
//         //               height: 25,
//         //               width: 60,
//         //               padding: EdgeInsets.zero,
//         //               color: Palette.themecolor,
//         //               borderRadius: BorderRadius.circular(30),
//         //               child: Row(
//         //                 mainAxisAlignment: MainAxisAlignment.center,
//         //                 children: [
//         //                   const Icon(
//         //                     Icons.remove_red_eye,
//         //                     color: themewhitecolor,
//         //                     size: 15,
//         //                   ),
//         //                   Spacing.h(5),
//         //                   const Text(
//         //                     "1.3k",
//         //                     style: TextStyle(
//         //                       color: themewhitecolor,
//         //                     ),
//         //                   ),
//         //                 ],
//         //               ),
//         //             ),
//         //           ],
//         //         ),
//         //         Row(
//         //           children: [
//         //             const CircleAvatar(
//         //               radius: 16,
//         //               backgroundImage: NetworkImage(
//         //                 "https://www.thetimes.co.uk/imageserver/image/%2Fmethode%2Ftimes%2Fprod%2Fweb%2Fbin%2F8b157ac2-06d1-11ee-8502-af592ba32c58.jpg?crop=3584%2C4480%2C1568%2C0",
//         //               ),
//         //             ),
//         //             Spacing.h(),
//         //             const Column(
//         //               crossAxisAlignment: CrossAxisAlignment.start,
//         //               children: [
//         //                 Text(
//         //                   "Fall Guys",
//         //                   style: TextStyle(
//         //                     color: themewhitecolor,
//         //                     fontSize: mediumfontsize5,
//         //                     fontWeight: boldfontweight,
//         //                   ),
//         //                 ),
//         //                 Text(
//         //                   "Alpha",
//         //                   style: TextStyle(
//         //                     color: themewhitecolor,
//         //                     fontSize: smallfontsize2,
//         //                   ),
//         //                 ),
//         //               ],
//         //             ),
//         //           ],
//         //         ),
//         //       ],
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }

// // class LiveStreamingModels {
// //   final String userImage;
// //   final String userName;
// //   final String reel;
// //   LiveStreamingModels({
// //     required this.userImage,
// //     required this.userName,
// //     required this.reel,
// //   });
// // }

// // List<LiveStreamingModels> reelsmodel = [
// //   LiveStreamingModels(
// //     userImage:
// //         "https://www.thetimes.co.uk/imageserver/image/%2Fmethode%2Ftimes%2Fprod%2Fweb%2Fbin%2F8b157ac2-06d1-11ee-8502-af592ba32c58.jpg?crop=3584%2C4480%2C1568%2C0",
// //     userName: "Mark Timber",
// //     reel: "https://video.elliptical.website/video/7.mp4",
// //   ),
// //   LiveStreamingModels(
// //     userImage:
// //         "https://assets.myntassets.com/dpr_1.5,q_60,w_400,c_limit,fl_progressive/assets/images/19596256/2022/8/22/b7cb2e4a-0ca3-48be-aa38-8dcaecc673aa1661161282162MenNavyThreePieceSuit1.jpg",
// //     userName: "Scott Spencer",
// //     reel: "https://video.elliptical.website/video/2.mp4",
// //   ),
// //   LiveStreamingModels(
// //     userImage:
// //         "https://diners.com.pk/cdn/shop/files/DA999-BLACK-02.webp?v=1699531777",
// //     userName: "Steve Wood",
// //     reel: "https://video.elliptical.website/video/3.mp4",
// //   ),
// //   LiveStreamingModels(
// //     userImage:
// //         "https://www.suitsexpert.com/wp-content/uploads/2019/04/men-suit-styles-differences-and-types.jpg",
// //     userName: "Alex Notts",
// //     reel: "https://video.elliptical.website/video/4.mp4",
// //   ),
// //   LiveStreamingModels(
// //     userImage:
// //         "https://i.pinimg.com/236x/46/cf/fe/46cffe44e2bbf84f6ad92979a979ef22.jpg",
// //     userName: "Yazdan Shaikh",
// //     reel: "https://video.elliptical.website/video/5.mp4",
// //   ),
// //   LiveStreamingModels(
// //     userImage:
// //         "https://qph.cf2.quoracdn.net/main-qimg-d1998d5fd56a01576e1e32e0bdba5b8b-lq",
// //     userName: "Saim Yousuf",
// //     reel: "https://video.elliptical.website/video/6.mp4",
// //   ),
// //   LiveStreamingModels(
// //     userImage:
// //         "https://essentia.com.pk/cdn/shop/files/D71A7713w1.jpg?v=1697119502",
// //     userName: "Huzaifa Khan",
// //     reel: "https://video.elliptical.website/video/7.mp4",
// //   ),
// //   LiveStreamingModels(
// //     userImage:
// //         "https://www.bonsoir.co.in/cdn/shop/products/SUITSA-119_1_large.jpg?v=1648619429",
// //     userName: "Hassan Shaikh",
// //     reel: "https://video.elliptical.website/video/8.mp4",
// //   ),
// // ];