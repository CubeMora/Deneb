import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/pages/forms/planets_form.dart';
import 'package:flutter_app_astronomy/src/services/screen_reference.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      // case '/image':
      //   return MaterialPageRoute(builder: (_) => const ImageGridView());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/addPlanet':
        if (args is int) {
          return MaterialPageRoute(
              builder: (_) => AddNewPlanetScreen(systemId: args));
        }

        return _errorRoute();
      case '/image':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => ImageViewerScreen(
                    imageProvider: args,
                  ));
        }
        return _errorRoute();
      case '/details':
        if (args is CelestialBody) {
          return MaterialPageRoute(
              builder: (_) => DetailsScreen(
                    celestialBody: args,
                  ));
        }
        return _errorRoute();

      case '/addSystem':
        return MaterialPageRoute(builder: (_) => AddNewSystemScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
