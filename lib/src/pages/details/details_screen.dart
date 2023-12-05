// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_app_astronomy/src/pages/details/celestial_bodies_image_grid.dart';
import 'package:flutter_app_astronomy/src/pages/details/components/custom_painter.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/services/theme_helper.dart';
import 'package:flutter_app_astronomy/src/settings/constants/constants.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'components/characteristics.dart';
import 'components/description.dart';
import 'components/product_title_with_image.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.celestialBody})
      : super(key: key);

  final CelestialBody celestialBody;

  @override
  // ignore: library_private_types_in_public_api
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
      GlobalKey refreshKey = GlobalKey();
  late TabController tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      planetOverall(MediaQuery.of(context).size, context),
      CelestialBodiesImageGrid(celestialBodyId: widget.celestialBody.id!, ),
      const Center(child: Text("c deisote"))
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: appTheme.orange50,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: IconButton(
              icon: Icon(LineIcons.arrowLeft,
                  color: selectedIndex == 0 ? Colors.white : Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/search.svg",
                color: selectedIndex == 0 ? Colors.white : Colors.black,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: kDefaultPaddin),
          ],
        ),
        body: widgetOptions.elementAt(selectedIndex),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: _buildBottomBar2(context),
        ),
      ),
    );
  }

  Widget _buildBottomBar2(BuildContext context) {
    return GNav(
      haptic: true,
      curve: Curves.easeOutExpo,
      duration: const Duration(milliseconds: 900),
      gap: 5,
      activeColor: Colors.deepOrange,
      iconSize: 20,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      tabs: const [
        GButton(
          icon: LineIcons.globe,
          iconColor: Colors.black38,
          iconSize: 30,
        ),
        GButton(
          icon: LineIcons.image,
          iconColor: Colors.black38,
          iconSize: 30,
        ),
        GButton(
          icon: LineIcons.mapMarked,
          iconColor: Colors.black38,
          iconSize: 30,
        ),
      ],
      selectedIndex: selectedIndex,
      onTabChange: (index) {
        selectedIndex = index;

        setState(() {});
      },
    );
  }

  Widget celestialBodyPhotosScreen() {
    return Container(
      color: appTheme.deepOrange300,
      height: MediaQuery.of(context).size.height - 200,
      child: CelestialBodiesImageGrid(
        
          celestialBodyId: widget.celestialBody.id!), //This is an image grid
    );
  }

  Widget planetOverall(Size size, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            // height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.4),
                  padding: EdgeInsets.only(
                    top: size.height * 0.2,
                    left: kSecondaryPaddin,
                    right: kSecondaryPaddin,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.orange50,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Characteristics(celestialBody: widget.celestialBody)
                          ,
                      TabBar(
                        controller: tabController,
                        labelPadding: EdgeInsets.zero,
                        labelColor: appTheme.amber200,
                        labelStyle: const TextStyle(
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600),
                        unselectedLabelColor: appTheme.gray600,
                        unselectedLabelStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400),
                        indicatorColor: appTheme.amber200,
                        tabs: const [
                          Tab(text: "Description"),
                          Tab(text: "VR Tour"),
                          Tab(text: "Map"),
                        ],
                      )
                          .animate()
                          .fadeIn(duration: const Duration(milliseconds: 400)),
                      const SizedBox(height: kDefaultPaddin / 2),
                      SizedBox(
                        height: 120.0,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            Description(celestialBody: widget.celestialBody),
                            Description(celestialBody: widget.celestialBody),
                            Description(celestialBody: widget.celestialBody),
                          ],
                        ),
                      ),
                      const SizedBox(height: kDefaultPaddin / 2),
                      const SizedBox(height: kDefaultPaddin / 2),
                    ],
                  ),
                ).animate()
                          .fadeIn(duration: const Duration(milliseconds: 600))
                          .moveY(begin: 40, curve: Curves.ease),
                IgnorePointer(
                  ignoring: true,
                  child: CustomPaint(
                    size: Size(
                        MediaQuery.of(context).size.width,
                        ((MediaQuery.of(context).size.height) + 150)
                            .toDouble()),
                    painter: RPSCustomPainter(gradientColor:  widget.celestialBody.color),
                  ).animate()
                          .fadeIn(duration: const Duration(milliseconds: 600))
                          .moveY(begin: -100, curve: Curves.ease),
                ),
                Hero(
                    tag: widget.celestialBody.id!,
                    child: ProductTitleWithImage(
                        celestialBody: widget.celestialBody)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
