import 'package:flutter/material.dart';
import 'package:boxed_project/theme/colors.dart';
import 'package:boxed_project/theme/font_structures.dart';
import 'package:boxed_project/theme/spacing.dart';
import 'package:boxed_project/views/home/widget/card_trusted.dart';
class TrustedPartner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Your Trusted Partner for Convenient and Reliable Student Storage",
              style: TextStyle(
                fontSize: largefontsize5,
                fontWeight: boldfontweight,
                color: Palette.themecolor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        15.kH,
        ListView.separated(
          itemCount: 3,
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            return CardTrusted(
              image: index == 0
                  ? "assets/images/transparent-pricing.png"
                  : index == 1
                      ? "assets/images/exceptional-service.png"
                          : "assets/images/customer-satisfaction.png",
              title: index == 0
                  ? "Transparent Pricing"
                  : index == 1
                      ? "Exceptional Service"
                          : "Customer Satisfaction",
              subtitle: index == 0
                  ? "If it fits…that’s it! Storage is priced by cart or box, ensuring you are only charged for what you need. We provide complementary moving boxes and our College Cart for the most efficient of moves."
                  : index == 1
                      ? "In addition to providing you with the supplies needed to pack everything, we act as a liaison and coordinate your pickup with a professional moving company. After your pick-up, we then move your items to a climate-controlled storage unit, where they await until drop-off in the fall."
                          : "We partner with you to assist with a seamless and hassle-free moving experience. You roll our College Cart to us with your packed goods, and we will take care of the rest! You can now enjoy your summer until we see you again to deliver your goods back on campus next fall.",
            );
          },
          separatorBuilder: (context, seprator) {
            return 25.kH;
          },
        ),
      ],
    );
}
}