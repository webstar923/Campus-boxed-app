import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/widgets/custom_button.dart';
import 'package:boxed_project/widgets/custom_icon_button.dart';
import 'package:boxed_project/widgets/filled_box.dart';

class CustomFavortieButton extends StatefulWidget {
  const CustomFavortieButton({
    super.key,
  });

  @override
  State<CustomFavortieButton> createState() => _CustomFavortieButtonState();
}

class _CustomFavortieButtonState extends State<CustomFavortieButton> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isFavorite)
          ElasticIn(
            duration: const Duration(milliseconds: 700),
            child: FilledBox(
              color: isFavorite ? themeredcolor : Palette.themecolor,
              height: 40,
              width: 40,
              padding: EdgeInsets.zero,
              child: CustomIconButton(
                onTap: () {
                  setState(() {
                    if (isFavorite == true) {
                      isFavorite = false;
                    } else {
                      isFavorite = true;
                    }
                  });
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: themewhitecolor,
                ),
              ),
            ),
          ),
        if (isFavorite == false)
          ZoomIn(
            child: FilledBox(
              color:
                  isFavorite ? themeredcolor : themewhitecolor,
              height: 40,
              width: 40,
              padding: EdgeInsets.zero,
              child: CustomIconButton(
                onTap: () {
                  setState(() {
                    if (isFavorite == true) {
                      isFavorite = false;
                    } else {
                      isFavorite = true;
                    }
                  });
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: themeblackcolor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CustomCheckListButton extends StatefulWidget {
  final String text;
  const CustomCheckListButton({
    super.key,
    required this.text,
  });

  @override
  State<CustomCheckListButton> createState() => _CustomCheckListButtonState();
}

class _CustomCheckListButtonState extends State<CustomCheckListButton> {
  bool? check = false;
  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onTap: () {},
      child: CheckboxListTile(
        activeColor: Palette.themecolor,
        value: check,
        onChanged: (bool? value) {
          setState(() {
            check = value;
          });
        },
        contentPadding: EdgeInsets.zero,
        title: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 14,
            color: themeblackcolor,
            fontWeight: FontWeight.w300,
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}

class CustomCheckButton extends StatefulWidget {
  const CustomCheckButton({super.key});

  @override
  State<CustomCheckButton> createState() => _CustomCheckButtonState();
}

class _CustomCheckButtonState extends State<CustomCheckButton> {
  bool? check = false;
  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      onTap: () {},
      child: Checkbox(
        activeColor: Palette.themecolor,
        value: check,
        onChanged: (bool? value) {
          setState(() {
            check = value;
          });
        },
      ),
    );
  }
}

class CustomIncrementButton extends StatefulWidget {
  const CustomIncrementButton({super.key});

  @override
  State<CustomIncrementButton> createState() => _CustomIncrementButtonState();
}

class _CustomIncrementButtonState extends State<CustomIncrementButton> {
  int counter = 0;

  void incrementcounter() {
    setState(() {
      counter++;
    });
  }

  void decrementcounter() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          onTap: () {
            decrementcounter();
          },
          height: 30,
          width: 30,
          buttoncolor: themeblackcolor,
          borderRadius: BorderRadius.circular(10),
          child: const Icon(
            Icons.remove,
            color: themewhitecolor,
            size: 25,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Text(
          "${counter}",
          style: const TextStyle(
            fontSize: 17,
            color: themeblackcolor,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        CustomButton(
          onTap: () {
            incrementcounter();
          },
          height: 30,
          width: 30,
          buttoncolor: themeblackcolor,
          borderRadius: BorderRadius.circular(10),
          child: const Icon(
            Icons.add,
            color: themewhitecolor,
            size: 25,
          ),
        ),
      ],
    );
  }
}
