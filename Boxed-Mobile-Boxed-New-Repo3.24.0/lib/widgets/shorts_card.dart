// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:vshop/theme/colors.dart';
// import 'package:vshop/theme/font_structures.dart';
// import 'package:vshop/theme/spacing.dart';
// import 'package:vshop/widgets/custom_button.dart';

// class ShortsCard extends StatefulWidget {
//   final String videoLink;
//   final String title;
//   final double height;
//   final double width;
//   const ShortsCard({
//     super.key,
//     required this.videoLink,
//     required this.title,
//     this.height = 300,
//     this.width = 220,
//   });

//   @override
//   State<ShortsCard> createState() => _ShortsCardState();
// }

// class _ShortsCardState extends State<ShortsCard> {
//   late VideoPlayerController _videoController;
//   @override
//   void initState() {
//     super.initState();
//     _videoController = VideoPlayerController.networkUrl(
//       Uri.parse(widget.videoLink),
//     );
//     _videoController.initialize().then((_) => setState(() {}));
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _videoController.dispose();
//   }

//   bool value = false;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.bottomLeft,
//       children: [
//         Container(
//           height: widget.height,
//           width: widget.width,
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
//           width: widget.width,
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Align(
//               alignment: Alignment.bottomLeft,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Row(
//                     children: [
//                       const CircleAvatar(
//                         backgroundColor: Palette.themecolor,
//                         radius: 20,
//                         backgroundImage: NetworkImage(
//                           'https://www.thetimes.co.uk/imageserver/image/%2Fmethode%2Ftimes%2Fprod%2Fweb%2Fbin%2F8b157ac2-06d1-11ee-8502-af592ba32c58.jpg?crop=3584%2C4480%2C1568%2C0',
//                         ),
//                       ),
//                       Spacing.h(),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             widget.title,
//                             style: const TextStyle(
//                               color: themewhitecolor,
//                               fontSize: mediumfontsize3,
//                               fontWeight: boldfontweightvar1,
//                             ),
//                           ),
//                           const Text(
//                             "855k followers",
//                             style: TextStyle(
//                               color: themewhitecolor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Spacing.v(),
//                   const Text(
//                     "Hi, folks see our product by reels and hurry up buy it now",
//                     style: TextStyle(
//                       color: themewhitecolor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );

//     // Container(
//     //   height: 225,
//     //   width: 175,
//     //   decoration: BoxDecoration(
//     //     borderRadius: BorderRadius.circular(12),
//     //     gradient: LinearGradient(
//     //       colors: [
//     //         themeblackcolor.withOpacity(0.2),
//     //         themeblackcolor.withOpacity(0.3),
//     //         themeblackcolor.withOpacity(0.4),
//     //         themeblackcolor.withOpacity(0.8),
//     //       ],
//     //       begin: Alignment.topCenter,
//     //       end: Alignment.bottomCenter,
//     //     ),
//     //   ),
//     //   child: ClipRRect(
//     //     borderRadius: BorderRadius.circular(12),
//     //     child: SizedBox(
//     //       height: 225,
//     //       width: 175,
//     //       child: Stack(
//     //         children: [
//     //           VideoPlayer(_videoController),
//     //           Padding(
//     //             padding: const EdgeInsets.all(8.0),
//     //             child: Column(
//     //               crossAxisAlignment: CrossAxisAlignment.start,
//     //               mainAxisAlignment: MainAxisAlignment.end,
//     //               children: [
//     //                 Text(
//     //                   widget.title,
//     //                   maxLines: 2,
//     //                   style: const TextStyle(
//     //                     color: themewhitecolor,
//     //                     fontSize: smallfontsize1,
//     //                     fontWeight: boldfontweightvar1,
//     //                     overflow: TextOverflow.ellipsis,
//     //                   ),
//     //                 ),
//     //                 Spacing.v(5),
//     //                 const Text(
//     //                   "902k views",
//     //                   maxLines: 1,
//     //                   style: TextStyle(
//     //                     color: themewhitecolor,
//     //                     fontSize: smallfontsize1,
//     //                     fontWeight: boldfontweightvar1,
//     //                     overflow: TextOverflow.ellipsis,
//     //                   ),
//     //                 ),
//     //               ],
//     //             ),
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //   ),
//     // );
//   }
// }
