// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:taxi/route_structure/go_navigator.dart';
// import 'package:taxi/theme/colors.dart';
// import 'package:taxi/theme/font_structures.dart';
// import 'package:taxi/theme/spacing.dart';
// import 'package:taxi/widgets/custom_button.dart';
// import 'package:taxi/widgets/custom_cached_network_image.dart';
// import 'package:taxi/widgets/custom_icon_button.dart';
// import 'package:taxi/widgets/filled_box.dart';

// class bids101Card extends StatefulWidget {
//   final double? width;
//   const bids101Card({
//     super.key,
//     this.width,
//   });

//   @override
//   State<bids101Card> createState() => _bids101CardState();
// }

// class _bids101CardState extends State<bids101Card> {
//   bool isFavorite = false;
//   @override
//   Widget build(BuildContext context) {
//     return CustomCachedNetworkImage(
//       animChild: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 150,
//             width: widget.width,
//             decoration: BoxDecoration(
//               color: themegreycolor,
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           Spacing.v(5),
//           Container(
//             height: 15,
//             width: 100,
//             decoration: BoxDecoration(
//               color: themegreycolor,
//               borderRadius: BorderRadius.circular(30),
//             ),
//           ),
//           Spacing.v(5),
//           Container(
//             height: 20,
//             width: 100,
//             decoration: BoxDecoration(
//               color: themegreycolor,
//               borderRadius: BorderRadius.circular(30),
//             ),
//           ),
//           Spacing.v(10),
//           Container(
//             height: 20,
//             width: 100,
//             decoration: BoxDecoration(
//               color: themegreycolor,
//               borderRadius: BorderRadius.circular(30),
//             ),
//           ),
//           Spacing.v(10),
//           Container(
//             height: 30,
//             width: widget.width,
//             decoration: BoxDecoration(
//               color: themegreycolor,
//               borderRadius: BorderRadius.circular(30),
//             ),
//           ),
//         ],
//       ),
//       imageUrl:
//           'https://shahzebsaeed.com/cdn/shop/files/SF015-2_800x.jpg?v=1691493985',
//       imageBuilder: (context, imageProvider) => FilledBox(
//         width: widget.width,
//         padding: EdgeInsets.zero,
//         color: themelightgreycolor,
//         onTap: () {
//           Go.route(
//             context,
//             const bids101DetailsScreen(
//               professionalImage:
//                   "https://shahzebsaeed.com/cdn/shop/files/SF015-2_800x.jpg?v=1691493985",
//               professionalTitle: "M.Tufail",
//             ),
//           );
//         },
//         child: Column(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image(
//                 image: imageProvider,
//                 height: 150,
//                 width: widget.width,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Lawyer",
//                             style: TextStyle(
//                               color: themegreytextcolor,
//                               fontSize: smallfontsize1,
//                               fontWeight: boldfontweight,
//                             ),
//                           ),
//                           Text(
//                             'M.Tufail',
//                             maxLines: 1,
//                             style: TextStyle(
//                               fontSize: mediumfontsize3,
//                               fontWeight: boldfontweight,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                       if (isFavorite)
//                         ElasticIn(
//                           duration: const Duration(milliseconds: 700),
//                           child: FilledBox(
//                             color:
//                                 isFavorite ? themeredcolor : Palette.themecolor,
//                             height: 40,
//                             width: 40,
//                             padding: EdgeInsets.zero,
//                             child: CustomIconButton(
//                               onTap: () {
//                                 setState(() {
//                                   isFavorite = !isFavorite;
//                                 });
//                               },
//                               child: Icon(
//                                 isFavorite
//                                     ? Icons.favorite
//                                     : Icons.favorite_border,
//                                 color: themewhitecolor,
//                               ),
//                             ),
//                           ),
//                         ),
//                       if (isFavorite == false)
//                         ZoomIn(
//                           child: FilledBox(
//                             color:
//                                 isFavorite ? themeredcolor : Palette.themecolor,
//                             height: 40,
//                             width: 40,
//                             padding: EdgeInsets.zero,
//                             child: CustomIconButton(
//                               onTap: () {
//                                 setState(() {
//                                   isFavorite = !isFavorite;
//                                 });
//                               },
//                               child: Icon(
//                                 isFavorite
//                                     ? Icons.favorite
//                                     : Icons.favorite_border,
//                                 color: themewhitecolor,
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                   Spacing.v(5),
//                   const Row(
//                     children: [
//                       Icon(
//                         Icons.star,
//                         color: themeyellowcolor,
//                         size: 18,
//                       ),
//                       Text(
//                         "4.9 | 2356",
//                         style: TextStyle(
//                           color: themegreytextcolor,
//                           fontSize: smallfontsize1,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Spacing.v(),
//                   CustomButton(
//                     onTap: () {
//                       Go.route(
//                         context,
//                         const OrderDetailsScreen(),
//                       );
//                     },
//                     height: 35,
//                     width: widget.width,
//                     borderRadius: BorderRadius.circular(30),
//                     child: const Text(
//                       "Hire",
//                       style: TextStyle(
//                         color: themewhitecolor,
//                         fontSize: mediumfontsize3,
//                         fontWeight: boldfontweight,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
