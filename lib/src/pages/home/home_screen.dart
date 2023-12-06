import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_app_astronomy/src/models/celestial_system.dart';
import 'package:flutter_app_astronomy/src/services/db_helper.dart';
import 'package:flutter_app_astronomy/src/services/local_data.dart';
import 'package:flutter_app_astronomy/src/services/theme_helper.dart';
import 'package:flutter_app_astronomy/src/settings/constants/image_constant.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'components/custom_app_bar.dart';
import 'components/homepage_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedSystem = 1;
  String systemName = "";
  String? filter = '';
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
          future: DBHelper.getCelestialBodies(selectedSystem, type: filter!),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: LoadingAnimationWidget.beat(
                      color: Colors.black, size: 60.0));
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
                                Navigator.pushNamed(context, '/addPlanet',
                                    arguments: selectedSystem);
                              },
                              child: Container(
                                  height: 353,
                                  width: 249,
                                  margin: const EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(97, 147, 147, 147),
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
                                color: const Color.fromARGB(97, 147, 147, 147),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Hero(
                                  tag: celestialBody.id!,
                                  child: celestialBody.isUserPhoto
                                      ? Image.file(
                                          File(celestialBody.image),
                                          height: 353,
                                          width: 249,
                                          cacheHeight: (MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4)
                                              .toInt(),
                                          cacheWidth: (MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6)
                                              .toInt(),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        )
                                      : Image.asset(
                                          celestialBody.image,
                                          height: 353,
                                          width: 249,
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
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
    return FutureBuilder<List<CelestialSystem>>(
      future: DBHelper.getAllCelestialSystems(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CelestialSystem>> snapshot) {
        if (snapshot.hasData) {
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
                itemCount: snapshot.data!.length + 1, // Add 1 to the itemCount
                itemBuilder: (context, index) {
                  if (index < snapshot.data!.length) {
                    // If the index is less than the length of the data
                    final celestialSystem = snapshot.data;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedSystem = celestialSystem[index].id!;
                          systemName = celestialSystem[index].name;
                        });
                      },
                      child: HomepageItemWidget(
                        celestialSystem: celestialSystem![index],
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/addSystem');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                            height: 10,
                            width: 120,
                            margin: const EdgeInsets.only(
                                right: 15, bottom: 60, top: 10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(97, 147, 147, 147),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: const Center(
                              child: Icon(
                                CupertinoIcons.add,
                                size: 50.0,
                              ),
                            )),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  ///+Makes the appbar based on a custom app bar located on local custom widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Planets",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30),
            ),
            Text(
              systemName != "" ? systemName : "Solar System",
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.grey),
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
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/search.svg",
                  colorFilter:
                      const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Select Filter'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              title: const Text('Clear Filter'),
                              leading: const Icon(LineIcons.trash),
                              selected: filter == '',
                              onTap: () {
                                setState(() {
                                  filter = '';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: const Text('Star'),
                              leading: const Icon(LineIcons.star),
                              selected: filter == 'Star',
                              onTap: () {
                                setState(() {
                                  filter = 'Star';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: const Text('Planet'),
                              leading: const Icon(LineIcons.globe),
                              selected: filter == 'Planet',
                              onTap: () {
                                setState(() {
                                  filter = 'Planet';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: const Text('Asteroid'),
                              leading: const Icon(LineIcons.cogs),
                              selected: filter == 'Asteroid',
                              onTap: () {
                                setState(() {
                                  filter = 'Asteroid';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: const Text('Comet'),
                              leading: const Icon(LineIcons.meteor),
                              selected: filter == 'Comet',
                              onTap: () {
                                setState(() {
                                  filter = 'Comet';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: const Text('Moon'),
                              leading: const Icon(LineIcons.moon),
                              selected: filter == 'Moon',
                              onTap: () {
                                setState(() {
                                  filter = 'Moon';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            ListTile(
                              title: const Text('Unknown'),
                              selected: filter == 'Unknown',
                              leading: const Icon(LineIcons.question),
                              onTap: () {
                                setState(() {
                                  filter = 'Unknown';
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Text(filter!.isNotEmpty ? "Filter: $filter" : ""),
            const Spacer(),
            IconButton(
              icon: SvgPicture.asset(ImageConstant.svgBxPlanetBlack900),
              onPressed: () {},
            ),
          ]),
    );
  }
}
