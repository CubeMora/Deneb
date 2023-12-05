// ignore_for_file: use_build_context_synchronously

import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body_photo.dart';
import 'package:flutter_app_astronomy/src/services/db_helper.dart';
import 'package:flutter_app_astronomy/src/services/local_data.dart';
import 'package:flutter_app_astronomy/src/services/theme_helper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  ImagePickerService(this.context);

  final BuildContext context;
  int selectedCelestialBody = 0;
  String? selectedImagePath; // Add this variable

  // Future<void> openPickerDialog() async {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Add new photo'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             SingleChildScrollView(
  //               scrollDirection: Axis.horizontal,
  //               child: Row(
  //                 children: List.generate(
  //                   LocalData().celestialBodyList.length,
  //                   (index) {
  //                     final CelestialBody celestialBody =
  //                         LocalData().celestialBodyList[index];
  //                     return GestureDetector(
  //                       onTap: () {
  //                         selectedCelestialBody = celestialBody.id!;
  //                       },
  //                       child: Padding(
  //                         padding: const EdgeInsets.all(12.0),
  //                         child: Card(
  //                           margin: EdgeInsets.all(20.0),
  //                           color: appTheme.orange50,
  //                           elevation: 3.0,
  //                           child: Text(celestialBody.id.toString()),
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //             ),
  //             ElevatedButton.icon(
  //               icon: const Icon(Icons.camera),
  //               label: const Text('Camera'),
  //               onPressed: () async {
  //                 Navigator.of(context).pop(); // close the dialog
  //                 await pickImageByCamera(selectedId: selectedCelestialBody);
  //                 showDialog(
  //                   context: context,
  //                   builder: (BuildContext context) {
  //                     return const AlertDialog(
  //                       title: Text('Success'),
  //                       content: Text('Image uploaded successfully'),
  //                     );
  //                   },
  //                 );
  //               },
  //             ),
  //             ElevatedButton.icon(
  //               icon: const Icon(Icons.image),
  //               label: const Text('Gallery'),
  //               onPressed: () async {
  //                 Navigator.of(context).pop(); // close the dialog
  //                 await pickImageByFile(selectedId: selectedCelestialBody);

  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> openSinglePickerDialog(int celestialBody) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add new photo '),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'),
                  onPressed: () async {
                    Navigator.of(context).pop(); // close the dialog
                    await pickImageByCamera(selectedId: celestialBody);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery'),
                  onPressed: () async {
                    Navigator.of(context).pop(); // close the dialog
                    await pickImageByFile(selectedId: celestialBody);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String?> openPickerDialogAddPlanet() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new photo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'),
                  onPressed: () async {
                    Navigator.of(context).pop(); // close the dialog
                    return await pickImageByCamera(
                        selectedId: selectedCelestialBody);
                  },
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop(); // close the dialog
                  return await pickImageByFile(
                      selectedId: selectedCelestialBody);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImageByFile({required int selectedId}) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, requestFullMetadata: true);

    try {
      final celestialBodyPhoto = CelestialBodyPhoto(
          imagePath: image!.path, celestialBodyId: selectedId);
      await DBHelper.saveCelestialBodyPhoto(celestialBodyPhoto);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error uploading the image: $e'),
      ));
    }
  }

  Future<void> pickImageByCamera({required int selectedId}) async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, requestFullMetadata: true);

    try {
      final celestialBodyPhoto = CelestialBodyPhoto(
          imagePath: image!.path, celestialBodyId: selectedId);
      await DBHelper.saveCelestialBodyPhoto(celestialBodyPhoto);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error uploading the image: $e'),
      ));
    }
  }
}
