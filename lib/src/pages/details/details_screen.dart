// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/pages/details/celestial_bodies_image_grid.dart';
import 'package:flutter_app_astronomy/src/pages/details/components/custom_painter.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/services/theme_helper.dart';
import 'package:flutter_app_astronomy/src/settings/constants/constants.dart';

import 'components/characteristics.dart';
import 'components/custom_bottom_bar.dart';
import 'components/description.dart';
import 'components/product_title_with_image.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.celestialBody,
  }) : super(key: key);

  final CelestialBody celestialBody;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      final currentContext = navigatorKey.currentContext;
      print(currentContext);
      Navigator.pushNamed(context, getCurrentRoute(type));
      if (currentContext != null) {}
    });
  }

  /// Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Bxplanet:
        return "/";
      case BottomBarEnum.Profile:
        return "/image";
      case BottomBarEnum.Map:
        return "/";
      default:
        return "/";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
              icon: SvgPicture.asset(
                'assets/icons/back.svg',
                height: 30.0,
                color: Colors.white,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/search.svg",
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            const SizedBox(width: kDefaultPaddin),
          ],
        ),
        body: SingleChildScrollView(
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
                          Characteristics(celestialBody: widget.celestialBody),
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
                          ),
                          const SizedBox(height: kDefaultPaddin / 2),
                          SizedBox(
                            height: 120.0,
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                Description(
                                    celestialBody: widget.celestialBody),
                                Description(
                                    celestialBody: widget.celestialBody),
                                Description(
                                    celestialBody: widget.celestialBody),
                              ],
                            ),
                          ),
                          const SizedBox(height: kDefaultPaddin / 2),
                          const SizedBox(height: kDefaultPaddin / 2),
                        ],
                      ),
                    ),
                    CustomPaint(
                      size: Size(
                          MediaQuery.of(context).size.width,
                          ((MediaQuery.of(context).size.height) + 150)
                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: RPSCustomPainter(),
                    ),
                    Hero(
                      tag: widget.celestialBody.id!,
                        child: ProductTitleWithImage(
                            celestialBody: widget.celestialBody)),
                  ],
                ),
              ),
              Container(
                color: appTheme.deepOrange300,
                height: MediaQuery.of(context).size.height - 300,
                child: CelestialBodiesImageGrid(
                    celestialBodyId: widget.celestialBody.id!),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }
}
