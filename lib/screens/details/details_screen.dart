import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:denep_app/constants.dart';
import 'package:denep_app/models/Planet.dart';
import 'package:denep_app/theme_helper.dart';

import 'components/description.dart';
import 'components/characteristics.dart';
import 'components/custom_bottom_bar.dart';

import 'components/product_title_with_image.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.planet}) : super(key: key);

  final Planet planet;

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
      if (currentContext != null) {
        Navigator.pushNamed(currentContext, getCurrentRoute(type));
      }
    });
  }

  /// Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Bxplanet:
        return "/";
      case BottomBarEnum.Profile:
        return "/";
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/back.svg',
                color: Colors.black,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset(
                "assets/icons/search.svg",
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            SizedBox(width: kDefaultPaddin),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.2),
                      padding: EdgeInsets.only(
                        top: size.height * 0.2,
                        left: kSecondaryPaddin,
                        right: kSecondaryPaddin,
                      ),
                      decoration: BoxDecoration(
                        color: appTheme.orange50,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          Characteristics(planet: widget.planet),
                          TabBar(
                            controller: tabController,
                            labelPadding: EdgeInsets.zero,
                            labelColor: appTheme.amber200,
                            labelStyle: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600),
                            unselectedLabelColor: appTheme.gray600,
                            unselectedLabelStyle: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400),
                            indicatorColor: appTheme.amber200,
                            tabs: [
                              Tab(text: "Description"),
                              Tab(text: "VR Tour"),
                              Tab(text: "Map"),
                            ],
                          ),
                          SizedBox(height: kDefaultPaddin / 2),
                          Container(
                            height: 120.0,
                            child: TabBarView(
                              controller: tabController,
                              children: [
                                Description(planet: widget.planet),
                                Description(planet: widget.planet),
                                Description(planet: widget.planet),
                              ],
                            ),
                          ),
                          SizedBox(height: kDefaultPaddin / 2),
                          SizedBox(height: kDefaultPaddin / 2),
                        ],
                      ),
                    ),
                    ProductTitleWithImage(planet: widget.planet),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }
}
