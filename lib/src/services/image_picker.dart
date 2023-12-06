// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body_photo.dart';
import 'package:flutter_app_astronomy/src/services/db_helper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  ImagePickerService(this.context);

  final BuildContext context;
  int selectedCelestialBody = 0;
  String? selectedImagePath; // Add this variable
  String? imagePath;

  Future<void> openSinglePickerDialog(int celestialBody) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add new photo '),
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
    final Completer<String?> completer = Completer();

    showDialog(
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
                    final path = await pickImageCameraForm();
                    completer.complete(path);
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
                onPressed: () async {
                  final path = await pickImageFileForm();
                  completer.complete(path);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );

    return completer.future;
  }

  Future<String> pickImageFileForm() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.gallery, requestFullMetadata: true);
    return image!.path;
  }

  Future<String> pickImageCameraForm() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, requestFullMetadata: true);
    return image!.path;
  }


///Pick image opening the gallery just for the celestialBody photos usage
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

///Pick image opening the camera just for the celestialBody photos usage
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
