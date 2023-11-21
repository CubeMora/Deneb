import 'dart:io';

import 'package:extended_image/extended_image.dart';
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
  String selectedImg = "";
  final selectedImgNotifier = ValueNotifier<String>('');

  /* @override
  void initState() {
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
      body: Center(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imgPath == "" ? const FlutterLogo() : Image.file(File(imgPath)),
            ElevatedButton(
                onPressed: () async {
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery, requestFullMetadata: true);

                  //TODO: Implement case if the user didn't pick anything or something that is not an Image
                  try {
                    final celestialBody = CelestialBody(
                      name: 'Mars',
                      description: 'Red planet',
                      type: 'Planet',
                      majorityNature: 'Rocky',
                      size: 6779,
                      distanceFromEarth: 5.64,
                      imagePath: image!.path,
                    );
                    await DBHelper.saveCelestialBody(celestialBody);

                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Image Uploaded'),
                      ));
                    });
                    displayImage();
                  } catch (e) {
                    imgPath = "";
                    print("Error: $e c dei");
                  }
                },
                child: const Text("Select Image")),
            ElevatedButton(
                onPressed: () async {
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.camera, requestFullMetadata: true);
                  try {
                    final celestialBody = CelestialBody(
                      name: 'Luna',
                      description: 'Cheese',
                      type: 'Moon',
                      majorityNature: 'Rocky',
                      size: 679,
                      distanceFromEarth: 1.64,
                      imagePath: image!.path,
                    );
                    await DBHelper.saveCelestialBody(celestialBody);

                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Image Uploaded'),
                      ));
                    });
                    displayImage();
                  } catch (e) {
                    imgPath = "";
                    print("Error: $e c dei");
                  }
                },
                child: const Text("Take Picture")),
            Text(
              imgPath != '' ? imgPath : "Not selected",
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    DBHelper.deleteAllRecords();
                    ImageCache().clear();
                  });
                },
                child: Text("DELETE ALL ROWS")),
            ValueListenableBuilder<String>(
              valueListenable: selectedImgNotifier,
              builder: (context, value, child) {
                return Text(
                  value,
                  textAlign: TextAlign.center,
                );
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 300,
              child: getCelestialBodiesImageGrid(),
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<CelestialBody>> getCelestialBodiesImageGrid() {
    return FutureBuilder<List<CelestialBody>>(
      future: DBHelper.getCelestialBodies(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CelestialBody>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Image.asset("assets/images/ckram.gif");
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return GridView.builder(
            shrinkWrap: true,
            clipBehavior: Clip.hardEdge,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return ExtendedImage.file(
                File(snapshot.data![index].imagePath),
                fit: BoxFit.cover,
                filterQuality: FilterQuality.low,
                cacheHeight: 1000,
                cacheWidth: 1000,
                scale: 0.1,
                enableLoadState: true,
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading:
                      //_controller.reset();
                      return Image.asset(
                        "assets/images/ckram.gif",
                        fit: BoxFit.cover,
                      );
                    //break;

                    case LoadState.completed:
                      // _controller.forward();
                      return GestureDetector(
                        onTap: () {
                          selectedImgNotifier.value =
                              snapshot.data![index].toString();
                        },
                        child: ExtendedRawImage(
                          image: state.extendedImageInfo?.image,
                          fit: BoxFit.cover,
                        ),
                      );
                    //break;
                    case LoadState.failed:
                      return GestureDetector(
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.asset(
                              "assets/images/error.png",
                              fit: BoxFit.cover,
                            ),
                            const Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Text(
                                "load image failed, click to reload",
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          state.reLoadImage();
                        },
                      );
                    // break;
                  }
                },
              ); //Image.file(File(snapshot.data![index].imagePath), fit: BoxFit.cover,);
            },
          );
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
