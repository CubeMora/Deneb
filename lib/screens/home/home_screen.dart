import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:denep_app/constants.dart';
import 'package:denep_app/screens/details/details_screen.dart';
import 'package:denep_app/models/Planet.dart';
import 'package:denep_app/image_constant.dart';
import 'package:denep_app/theme_helper.dart';
import 'components/custom_app_bar.dart';
import 'components/homepage_item_widget.dart';

class HomeScreen extends StatelessWidget {
  ColorFilter _colorFilter = ColorFilter.mode(Colors.grey, BlendMode.srcIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.orange50,
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // SizedBox(height: 29),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 20),
            child: IntrinsicWidth(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(Planets.length, (index) {
                  final planet = Planets[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(planet: planet),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: Color(0XFFF9DB80),

                        borderRadius: BorderRadius.circular(15.0), // radio
                      ),
                      child: Image.asset(
                        planet.image,
                        height: 353,
                        width: 249,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 29),
          _buildHomeActions(context),
          _buildHomePage(context)
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30),
        child: Divider(
          color: Colors.grey.shade700,
          thickness: 5,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildHomePage(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 147,
        child: ListView.separated(
          padding: EdgeInsets.only(left: 25),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (
            context,
            index,
          ) {
            return SizedBox(
              width: 14,
            );
          },
          itemCount: 4,
          itemBuilder: (context, index) {
            return HomepageItemWidget();
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Padding(
        padding: EdgeInsets.only(left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Planets",
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30),
            ),
            Text(
              "Solar system",
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.grey),
            )

            // AppbarSubtitle(
            //   text: "Solar system",
            //   margin: EdgeInsets.only(right: 20),
            // ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildHomeActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: SvgPicture.asset(
                ImageConstant.imgBxPlanetBlack900,
                colorFilter: _colorFilter,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/search.svg",
                colorFilter: ColorFilter.mode(kTextColor, BlendMode.srcIn),
              ),
              onPressed: () {},
            ),
            Spacer(),
            IconButton(
              icon: SvgPicture.asset(ImageConstant.imgBxPlanetBlack900),
              onPressed: () {},
            ),
          ]),
    );
  }
}
