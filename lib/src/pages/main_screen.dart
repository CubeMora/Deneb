import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app_astronomy/src/services/db_helper.dart';
import 'package:camera/camera.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late CameraController controller;
  var cameras;

  /* @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prepareCamera();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
    
  }*/

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String imgPath = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker'),
      ),
      body: Center(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imgPath == "" ? FlutterLogo() : Image.file(File(imgPath)),
            ElevatedButton(
                onPressed: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  final celestialBody = CelestialBody(
                    id: 1,
                    name: 'Mars',
                    description: 'Red planet',
                    type: 'Planet',
                    majorityNature: 'Rocky',
                    size: 6779,
                    distanceFromEarth: 5.64,
                    imagePath: image!.path,
                  );
                  await DBHelper.saveCelestialBody(celestialBody);
                  displayImage();
                },
                child: Text("Select Image")),
            ElevatedButton(
                onPressed: () async {/*CameraPreview(controller);*/},
                child: Text("Take Picture")),
            Text(
              imgPath != '' ? imgPath : "Not selected",
              textAlign: TextAlign.center,
            ),
            getCelestialBodiesText(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<CelestialBody>> getCelestialBodiesText() {
    return FutureBuilder<List<CelestialBody>>(
            future: DBHelper.getCelestialBodies(),
            builder: (BuildContext context,
                AsyncSnapshot<List<CelestialBody>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Image.file(File(snapshot.data![0].imagePath));
              }
            },
          );
  }

  void displayImage() async {
    final celestialBodies = await DBHelper.getCelestialBodies();
    for (var celestialBody in celestialBodies) {
      setState(() {
        imgPath = celestialBody.imagePath;
      });
    }
  }

  void prepareCamera() async {
    cameras = await availableCameras();
  }
}
