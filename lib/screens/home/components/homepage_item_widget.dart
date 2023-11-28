import 'package:flutter/material.dart';
import 'package:denep_app/image_constant.dart';

// ignore: must_be_immutable
class HomepageItemWidget extends StatelessWidget {
  const HomepageItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          children: [
            Container(
              height: 115,
              width: 115,
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 9,
              ),
              child: Image.asset(
                ImageConstant.imgImage,
                height: 96,
                width: 96,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(height: 9),
            Text(
              "Planeta",
            ),
          ],
        ),
      ),
    );
  }
}
