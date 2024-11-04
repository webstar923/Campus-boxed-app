import 'package:flutter/material.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';
import 'package:boxed_project/widgets/custom_text_field.dart';

class ChattingScreen extends StatefulWidget {
  final String username;
  final String userImage;
  const ChattingScreen({
    super.key,
    required this.username,
    required this.userImage,
  });

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.themecolor,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: themewhitecolor,
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.userImage),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              widget.username,
              style: const TextStyle(
                color: themewhitecolor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          messages(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              decoration: const BoxDecoration(
                // color: themewhitecolor,
                border: Border(
                  top: BorderSide(
                    color: themegreytextcolor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      onChanged: (onChanged) {
                        setState(() {
                          message = onChanged;
                        });
                      },
                      textInputType: TextInputType.text,
                      hintText: "Type Message",
                      fillColor: themelightgreycolor,
                      filled: true,
                      borderWidth: 1.5,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  15.kW,
                  CustomIconButton(
                    onTap: () {},
                    child: const CircleAvatar(
                      radius: 20,
                      child: Icon(
                        Icons.send,
                        color: Palette.themecolor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget messages() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 250,
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: themegreycolor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              "Anybody affected by coronavirus",
              style: TextStyle(
                color: themeblackcolor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 250,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Palette.themecolor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                "At our office 3 people are affected We Work from home",
                style: TextStyle(
                  color: themewhitecolor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 250,
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              color: themegreycolor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              "All good here. We wash hands and stay home",
              style: TextStyle(
                color: themeblackcolor,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 250,
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Palette.themecolor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                "This is our new manager, She will join chat. Her name is Ola. This is our new manager, She will join chat. Her name is Ola.",
                style: TextStyle(
                  color: themewhitecolor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
