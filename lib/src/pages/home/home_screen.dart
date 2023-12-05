import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_app_astronomy/src/services/image_picker.dart';

import 'package:flutter_app_astronomy/src/services/local_data.dart';
import 'package:flutter_app_astronomy/src/services/theme_helper.dart';
import 'package:flutter_app_astronomy/src/settings/constants/constants.dart';
import 'package:flutter_app_astronomy/src/settings/constants/image_constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'components/custom_app_bar.dart';
import 'components/homepage_item_widget.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    LocalData().insertDefaultCelestialBodies();
  }

  final ColorFilter _colorFilter =
      const ColorFilter.mode(Colors.grey, BlendMode.srcIn);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: appTheme.orange50,
      appBar: _buildAppBar(context),
      body: FutureBuilder(
          future: LocalData().celestialBodyList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: LoadingAnimationWidget.beat(color: Colors.black, size: 60.0));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 20),
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(snapshot.data.length + 1,
                                (index) {
                          if (index == snapshot.data.length) {
                            // This is the extra container with the plus icon
                            return GestureDetector(
                              onTap: () {
                                //ImagePickerService(context).openPickerDialog();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Added'),
                                ));
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                    color: const Color(0XFFF9DB80),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      CupertinoIcons.add,
                                      size: 50.0,
                                    ),
                                  )),
                            );
                          }

                          final celestialBody = snapshot.data[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/details',
                                  arguments: celestialBody);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 15),
                              decoration: BoxDecoration(
                                color: const Color(0XFFF9DB80),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Hero(
                                tag: celestialBody.id!,
                                child: Image.asset(
                                  celestialBody.image,
                                  height: 353,
                                  width: 249,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          )
                              .animate()
                              .moveX(
                                  begin: 80.0,
                                  delay: Duration(milliseconds: 300 * index))
                              .fadeIn(
                                  duration:
                                      Duration(milliseconds: 220 * index));
                        })
                            .animate()
                            .moveX(
                                begin: 30.0,
                                delay: const Duration(milliseconds: 100))
                            .fadeIn(
                                duration: const Duration(milliseconds: 220)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 29),
                  _buildHomeActions(context),
                  _buildHomePage(context)
                ],
              );
            }
          }),
    );
  }

  /// Section Widget
  Widget _buildHomePage(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 207,
        child: ListView.separated(
          padding: const EdgeInsets.only(left: 25),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (
            context,
            index,
          ) {
            return const SizedBox(
              width: 14,
            );
          },
          itemCount: LocalData().celestialBodyListForSection.length,
          itemBuilder: (context, index) {
            final celestialBody = LocalData().celestialBodyListForSection;
            return HomepageItemWidget(
              celestialBody: celestialBody[index],
            );
          },
        ),
      ),
    );
  }

  ///+Makes the appbar based on a custom app bar located on local custom widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: const Padding(
        padding: EdgeInsets.only(left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Planets",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30),
            ),
            Text(
              "Solar system",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcIn),
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
                ImageConstant.svgBxPlanetBlack900,
                colorFilter: _colorFilter,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/search.svg",
                colorFilter:
                    const ColorFilter.mode(kTextColor, BlendMode.srcIn),
              ),
              onPressed: () {},
            ),
            const Spacer(),
            IconButton(
              icon: SvgPicture.asset(ImageConstant.svgBxPlanetBlack900),
              onPressed: () {
                Navigator.pushNamed(context, '/addPlanet');
              },
            ),
          ]),
    );
  }
}
