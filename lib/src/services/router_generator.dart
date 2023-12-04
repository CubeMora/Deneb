import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
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
      case '/details':
        if (args is CelestialBody) {
          return MaterialPageRoute(
              builder: (_) => DetailsScreen(
                    celestialBody: args,
                  ));
        }
        return _errorRoute();

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
