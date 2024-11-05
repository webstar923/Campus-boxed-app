// // import 'package:cached_video_player/cached_video_player.dart';
// import 'dart:async';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:vshop/route_structure/navigator.dart';
// import 'package:vshop/route_structure/routes.dart';
// import 'package:vshop/theme/colors.dart';
// import 'package:vshop/theme/font_structures.dart';
// import 'package:vshop/theme/spacing.dart';
// import 'package:vshop/user/views/reels/add_reels_screen.dart';
// import 'package:vshop/widgets/custom_button.dart';
// import 'package:vshop/widgets/custom_icon_button.dart';
// import 'package:vshop/widgets/custom_text_field.dart';

// class ReelsWidget extends StatefulWidget {
//   final String userImage;
//   final String userName;
//   final String reel;
//   const ReelsWidget({
//     Key? key,
//     required this.userImage,
//     required this.userName,
//     required this.reel,
//   }) : super(key: key);

//   @override
//   State<ReelsWidget> createState() => _ReelsWidgetState();
// }

// class _ReelsWidgetState extends State<ReelsWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController animationController;
//   late VideoPlayerController _videoController;
//   late Animation<double> scaleAnimation;
//   bool isVideoPause = false;

//   @override
//   void initState() {
//     super.initState();
//     animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//     _videoController = VideoPlayerController.networkUrl(
//       Uri.parse(widget.reel),
//     );

//     scaleAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(
//       CurvedAnimation(
//         parent: animationController,
//         curve: Curves.ease,
//         reverseCurve: Curves.ease,
//       ),
//     );

//     _videoController.addListener(() {
//       setState(() {});
//     });
//     _videoController.setLooping(true);
//     _videoController.initialize().then((_) => setState(() {}));
//     _videoController.play();
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();
//     super.dispose();
//   }

//   bool value = false;
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           InkWell(
//             onTap: () {
//               // playVideo();
//               setState(() {
//                 if (_videoController.value.isPlaying) {
//                   setState(() {
//                     isVideoPause = true;
//                   });
//                   _videoController.pause();
//                   animationController.forward().then(
//                         (value) => Timer(
//                           const Duration(milliseconds: 300),
//                           () {
//                             setState(() {
//                               isVideoPause = false;
//                             });
//                           },
//                         ),
//                       );
//                 } else {
//                   setState(() {
//                     isVideoPause = true;
//                   });
//                   _videoController.play();
//                   animationController.reverse().then(
//                         (value) => Timer(
//                           const Duration(milliseconds: 500),
//                           () {
//                             setState(() {
//                               isVideoPause = false;
//                             });
//                           },
//                         ),
//                       );
//                 }
//               });
//             },
//             child: Container(
//               foregroundDecoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     themeblackcolor.withOpacity(0.0),
//                     themeblackcolor.withOpacity(0.0),
//                     themeblackcolor.withOpacity(0.3),
//                     themeblackcolor.withOpacity(0.8),
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               child: VideoPlayer(_videoController),
//             ),
//           ),
//           Visibility(
//             visible: isVideoPause,
//             child: ScaleTransition(
//               scale: scaleAnimation,
//               alignment: Alignment.center,
//               child: Align(
//                 alignment: Alignment.center,
//                 child: CircleAvatar(
//                   radius: 40,
//                   backgroundColor: themeblackcolor.withOpacity(0.5),
//                   child: Icon(
//                     _videoController.value.isPlaying
//                         ? Icons.play_arrow
//                         : Icons.pause,
//                     color: themewhitecolor,
//                     size: 35,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Flexible(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: Palette.themecolor,
//                                   radius: 20,
//                                   backgroundImage: NetworkImage(
//                                     widget.userImage,
//                                   ),
//                                 ),
//                                 Spacing.h(),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       widget.userName,
//                                       style: const TextStyle(
//                                         color: themewhitecolor,
//                                         fontSize: mediumfontsize3,
//                                         fontWeight: boldfontweightvar1,
//                                       ),
//                                     ),
//                                     const Text(
//                                       "855k followers",
//                                       style: TextStyle(
//                                         color: themewhitecolor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Spacing.h(),
//                                 CustomButton(
//                                   height: 35,
//                                   width: 80,
//                                   borderRadius: BorderRadius.circular(30),
//                                   buttoncolor: value == true
//                                       ? themewhitecolor
//                                       : Palette.themecolor,
//                                   child: Text(
//                                     value == true ? "Unfollow" : "Follow",
//                                     style: TextStyle(
//                                       color: value == true
//                                           ? themeblackcolor
//                                           : themewhitecolor,
//                                       fontWeight: boldfontweight,
//                                     ),
//                                   ),
//                                   onTap: () {
//                                     setState(() {
//                                       if (value == true) {
//                                         value = false;
//                                       } else {
//                                         value = true;
//                                       }
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                             Spacing.v(5),
//                             const Text(
//                               "This is the very long description of the videos which has many lines This is the very long description of the videos which has many lines This is the very long description of the videos which has many lines This is the very long description of the videos which has many lines",
//                               overflow: TextOverflow.ellipsis,
//                               softWrap: true,
//                               maxLines: 2,
//                               style: TextStyle(color: themewhitecolor),
//                             ),
//                             Spacing.v(5),
//                             const Text(
//                               "#shorts #jogging #somewhere",
//                               style: TextStyle(color: themewhitecolor),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Spacing.h(20),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 20.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             CustomIconButton(
//                               onTap: () {
//                                 Go.push(
//                                   context,
//                                   const AddReelsScreen(),
//                                 );
//                               },
//                               child: CircleAvatar(
//                                 radius: 22,
//                                 backgroundColor:
//                                     themewhitecolor.withOpacity(0.2),
//                                 child: const Icon(
//                                   Icons.add,
//                                   color: themewhitecolor,
//                                   size: 22,
//                                 ),
//                               ),
//                             ),
//                             Spacing.v(20),
//                             CustomIconButton(
//                               onTap: () {},
//                               child: CircleAvatar(
//                                 radius: 22,
//                                 backgroundColor:
//                                     themewhitecolor.withOpacity(0.2),
//                                 child: const Icon(
//                                   Icons.thumb_up_outlined,
//                                   color: themewhitecolor,
//                                   size: 22,
//                                 ),
//                               ),
//                             ),
//                             const Text(
//                               "33k",
//                               style: TextStyle(
//                                 color: themewhitecolor,
//                                 fontSize: mediumfontsize5,
//                                 fontWeight: boldfontweightvar1,
//                               ),
//                             ),
//                             Spacing.v(20),
//                             CustomIconButton(
//                               onTap: () {
//                                 comments(size);
//                               },
//                               child: CircleAvatar(
//                                 radius: 22,
//                                 backgroundColor:
//                                     themewhitecolor.withOpacity(0.2),
//                                 child: const Icon(
//                                   Icons.chat_bubble,
//                                   color: themewhitecolor,
//                                   size: 22,
//                                 ),
//                               ),
//                             ),
//                             const Text(
//                               "150",
//                               style: TextStyle(
//                                 color: themewhitecolor,
//                                 fontSize: mediumfontsize5,
//                                 fontWeight: boldfontweightvar1,
//                               ),
//                             ),
//                             Spacing.v(20),
//                             CustomIconButton(
//                               onTap: () {},
//                               child: CircleAvatar(
//                                 radius: 22,
//                                 backgroundColor:
//                                     themewhitecolor.withOpacity(0.2),
//                                 child: const Icon(
//                                   CupertinoIcons.arrowshape_turn_up_right_fill,
//                                   color: themewhitecolor,
//                                   size: 22,
//                                 ),
//                               ),
//                             ),
//                             const Text(
//                               "Share",
//                               style: TextStyle(
//                                 color: themewhitecolor,
//                                 fontSize: mediumfontsize5,
//                                 fontWeight: boldfontweightvar1,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Theme(
//                   data: Theme.of(context).copyWith(
//                     dividerColor: Colors.transparent,
//                     listTileTheme: ListTileTheme.of(context).copyWith(
//                       minVerticalPadding: 10,
//                       // contentPadding: EdgeInsets.zero,
//                     ),
//                   ),
//                   child: ExpansionTile(
//                     title: const Text("Shop Now"),
//                     collapsedTextColor: themewhitecolor,
//                     textColor: themewhitecolor,
//                     collapsedIconColor: themewhitecolor,
//                     iconColor: themewhitecolor,
//                     children: [
//                       Column(
//                         children: [
//                           SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                               ),
//                               child: Row(
//                                 children: List.generate(
//                                   10,
//                                   (index) => Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                       horizontal: 8,
//                                     ),
//                                     child: Container(
//                                       height: 80,
//                                       width: 80,
//                                       decoration: BoxDecoration(
//                                         color: themewhitecolor,
//                                         borderRadius: BorderRadius.circular(8),
//                                         image: const DecorationImage(
//                                           image: NetworkImage(
//                                             "https://nasonga.com/wp-content/uploads/2022/08/Simu-ya-Inifinix.jpg",
//                                           ),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Spacing.v(),
//                           CustomButton(
//                             height: 50,
//                             width: size.width / 100 * 95,
//                             borderRadius: BorderRadius.circular(30),
//                             buttoncolor: Palette.themecolor,
//                             child: const Text(
//                               "Buy Now",
//                               style: TextStyle(
//                                 color: themewhitecolor,
//                                 fontWeight: boldfontweight,
//                               ),
//                             ),
//                             onTap: () {
//                               Go.pushNamed(
//                                 context,
//                                 AppRoutes.userLogin,
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Spacing.v(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<Object?> comments(size) {
//     return showModalBottomSheet(
//       backgroundColor: themewhitecolor,
//       isScrollControlled: true,
//       useSafeArea: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       context: context,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Padding(
//               padding:
//                   MediaQuery.of(context).viewInsets,
//               child: Container(
//                 height: size.height / 100 * 70,
//                 width: size.width,
//                 decoration: const BoxDecoration(
//                   color: themewhitecolor,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           child: Container(
//                             height: 5,
//                             width: 50,
//                             decoration: BoxDecoration(
//                               color: themegreycolor,
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 "Comments",
//                                 style: TextStyle(
//                                   fontSize: largefontsize6,
//                                   fontWeight: boldfontweight,
//                                 ),
//                               ),
//                               CustomIconButton(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Icon(Icons.close),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Spacing.v(),
//                         const Divider(
//                           height: 0,
//                         ),
//                         Expanded(
//                           child: SingleChildScrollView(
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                 left: 20,
//                                 right: 20,
//                                 top: 10,
//                                 bottom: 10,
//                               ),
//                               child: Column(
//                                 children: List.generate(
//                                   20,
//                                   (index) => Padding(
//                                     padding:
//                                         const EdgeInsets.only(bottom: 15.0),
//                                     child: Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const CircleAvatar(
//                                           backgroundImage: NetworkImage(
//                                             "https://media.npr.org/assets/img/2022/11/08/ap22312071681283-0d9c328f69a7c7f15320e8750d6ea447532dff66.jpg",
//                                           ),
//                                         ),
//                                         Spacing.h(),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               const Text(
//                                                 "User name • 21 hr ago",
//                                                 style: TextStyle(
//                                                   color: themegreytextcolor,
//                                                 ),
//                                               ),
//                                               const Text(
//                                                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
//                                                 style: TextStyle(
//                                                   fontSize: mediumfontsize3,
//                                                 ),
//                                               ),
//                                               Spacing.v(),
//                                               const Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.thumb_up_outlined,
//                                                     size: 18,
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Spacing.v(40),
//                       ],
//                     ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 8,
//                           horizontal: 12,
//                         ),
//                         decoration: const BoxDecoration(
//                           color: themewhitecolor,
//                           border: Border(
//                             top: BorderSide(
//                               color: themegreycolor,
//                             ),
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             const CircleAvatar(
//                               radius: 18,
//                               backgroundImage: NetworkImage(
//                                 "https://www.realmenrealstyle.com/wp-content/uploads/2023/07/Glasses-for-Oval-shape.jpg",
//                               ),
//                             ),
//                             Spacing.h(),
//                             const Expanded(
//                               child: CustomTextField(
//                                 textInputType: TextInputType.text,
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 8,
//                                   horizontal: 12,
//                                 ),
//                                 hintText: "Add a comment..",
//                                 filled: true,
//                                 fillColor: themetextfieldcolor,
//                                 isOutlinedInputBorder: true,
//                                 focusedBorderColor: Palette.themecolor,
//                                 borderWidth: 1.5,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
