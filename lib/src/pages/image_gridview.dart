import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body_photo.dart';
import 'package:flutter_app_astronomy/src/pages/details/celestial_bodies_image_grid.dart';
import 'package:flutter_app_astronomy/src/services/local_data.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_app_astronomy/src/services/db_helper.dart';


class ImageGridView extends StatefulWidget {
  const ImageGridView({super.key, required this.celestialBody});
  final CelestialBody celestialBody;

  @override
  State<ImageGridView> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
 
  String selectedImg = "";
  final selectedImgNotifier = ValueNotifier<String>('');


  String imgPath = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imgPath == "" ? const FlutterLogo() : Image.file(File(imgPath)),
            //File picking
            ElevatedButton(
                onPressed: () async {
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery, requestFullMetadata: true);

                
                  try {
                    final celestialBodyPhoto = CelestialBodyPhoto(imagePath: image!.path, celestialBodyId: LocalData().celestialBodyList[0].id!);
                    await DBHelper.saveCelestialBodyPhoto(celestialBodyPhoto);

                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Image Uploaded'),
                      ));
                    });

                    //displayImage();
                  } catch (e) {
                    imgPath = "";
                    print("Error: $e c dei");
                  }
                },
                child: const Text("Select Image")),


                //Camera Picking
            ElevatedButton(
                onPressed: () async {
                  final image = await ImagePicker().pickImage(
                      source: ImageSource.camera, requestFullMetadata: true);
                  try {
                    final celestialBodyPhoto = CelestialBodyPhoto(imagePath: image!.path, celestialBodyId: LocalData().celestialBodyList[1].id!);
                    await DBHelper.saveCelestialBodyPhoto(celestialBodyPhoto);

                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Image Uploaded'),
                      ));
                    });
                    
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
                child: const Text("DELETE ALL ROWS")),
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
              child: CelestialBodiesImageGrid(celestialBodyId: 1),
            )
          ],
        ),
      ),
    );
  }



}

