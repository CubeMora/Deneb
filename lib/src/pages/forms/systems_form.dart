// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_astronomy/src/models/celestial_system.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

import 'package:flutter_app_astronomy/src/services/db_helper.dart';
import 'package:flutter_app_astronomy/src/settings/constants/image_constant.dart';

final _formKey = GlobalKey<FormState>();

class AddNewSystemScreen extends StatefulWidget {
  const AddNewSystemScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNewSystemScreen> createState() => _AddNewSystemScreenState();
}

class _AddNewSystemScreenState extends State<AddNewSystemScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: const Text("Add New System"),
          backgroundColor: Colors.orange[50],
          leading: IconButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false),
              icon: const Icon(LineIcons.arrowLeft)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (name) => name!.length < 4
                            ? 'Name should be at least 4 characters'
                            : null,
                        decoration: InputDecoration(
                          hintText: "System Name",
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SvgPicture.asset("assets/icons/heart.svg"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() == true) {
                              _formKey.currentState?.save();

                              final CelestialSystem celestialBody =
                                  CelestialSystem(
                                      name: _nameController.text,
                                      image: ImageConstant.imgTierra);

                              bool saveSuccessful =
                                  await DBHelper.saveCelestialSystem(
                                      celestialBody);

                              if (saveSuccessful) {
                                // Mostrar el SnackBar después de guardar exitosamente
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Saved succesfully'),
                                ));
                                await Future.delayed(Duration(seconds: 1));
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/home', (_) => false);
                              } else {
                                // Mostrar un mensaje en caso de que la operación de guardado falle
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text('Error saving the data. Try again.'),
                                  backgroundColor: Colors.red,
                                ));
                              }
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.5);
                                }
                                return null;
                              },
                            ),
                          ),
                          child: const Text("Confirm"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Future openSinglePickerDialog() async {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Add new photo '),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: ElevatedButton.icon(
  //                 icon: const Icon(Icons.camera),
  //                 label: const Text('Camera'),
  //                 onPressed: () async {
  //                   Navigator.of(context).pop(); // close the dialog
  //                   await _pickImageFromCamera();
  //                 },
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(10.0),
  //               child: ElevatedButton.icon(
  //                 icon: const Icon(Icons.image),
  //                 label: const Text('Gallery'),
  //                 onPressed: () async {
  //                   Navigator.of(context).pop(); // close the dialog
  //                   await _pickImageFromGallery();
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future _pickImageFromCamera() async {
  //   final returnedImage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (returnedImage != null) {
  //     setState(() {
  //       _selectedImage = File(returnedImage.path).toString();
  //     });
  //     return returnedImage.path;
  //   }
  // }

  // Future _pickImageFromGallery() async {
  //   final returnedImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (returnedImage != null) {
  //     setState(() {
  //       _selectedImage = File(returnedImage.path).toString();
  //     });
  //     return returnedImage.path;
  //   }
  // }
}
