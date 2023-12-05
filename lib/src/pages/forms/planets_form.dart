import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app_astronomy/src/services/image_picker.dart';
import 'package:flutter_app_astronomy/src/services/db_helper.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/settings/constants/image_constant.dart';
import 'package:image_picker/image_picker.dart';

final _formKey = GlobalKey<FormState>();

class AddNewPlanetScreen extends StatefulWidget {
  const AddNewPlanetScreen({Key? key}) : super(key: key);

  @override
  State<AddNewPlanetScreen> createState() => _AddNewPlanetScreenState();
}

class _AddNewPlanetScreenState extends State<AddNewPlanetScreen> {
  File? _selectedImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();

  final List<Color> colorOptions = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow
  ];
  final List<String> majorityNatureOptions = ['Rock', 'Gas', 'Ice'];
  final List<String> typeOptions = ['Rocky', 'Gas Giant', 'Ice Giant'];

  Color selectedColor = Colors.red; // color
  String selectedMajorityNature = 'Rock'; // Default majorityNature
  String selectedType = 'Rocky'; // Default type
  String selectedColorName = 'Red'; // Set a default color name
  String? selectedImagePath;

  String _getColorName(Color color) {
    if (color == Colors.red) {
      return 'Red';
    } else if (color == Colors.blue) {
      return 'Blue';
    } else if (color == Colors.green) {
      return 'Green';
    } else if (color == Colors.yellow) {
      return 'Yellow';
    } else {
      // Handle other colors as needed
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text("Add New Planet"),
        backgroundColor: Colors.orange[50],
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
                        hintText: "Planet Name",
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SvgPicture.asset("assets/icons/heart.svg"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: _descriptionController,
                        validator: (description) => description!.length < 10
                            ? 'Description should be at least 10 characters'
                            : null,
                        decoration: InputDecoration(
                          hintText: "Description",
                          prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SvgPicture.asset("assets/icons/heart.svg"),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _sizeController,
                            keyboardType: TextInputType.number,
                            validator: (size) => size!.isEmpty
                                ? 'This input is mandatory'
                                : null,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: "Size (KM)",
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _distanceController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (distance) => distance!.isEmpty
                                ? 'This input is mandatory'
                                : null,
                            decoration: InputDecoration(
                              hintText: "Distance from earth (KM)",
                            ),
                          ),
                        ),
                      ],
                    ),

                    // selecting color
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: DropdownButtonFormField<String>(
                        value: selectedColorName,
                        items: colorOptions.map((Color color) {
                          String colorName = _getColorName(color);
                          return DropdownMenuItem<String>(
                            value: colorName,
                            child: Text(colorName),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedColorName = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Color',
                        ),
                      ),
                    ),

                    //  majorityNature
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: DropdownButtonFormField<String>(
                        value: selectedMajorityNature,
                        items: majorityNatureOptions.map((String nature) {
                          return DropdownMenuItem<String>(
                            value: nature,
                            child: Text(nature),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedMajorityNature = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Majority Nature',
                        ),
                      ),
                    ),

                    // selecting type
                    DropdownButtonFormField<String>(
                      value: selectedType,
                      items: typeOptions.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          selectedType = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Type',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _selectedImage != null
                    ? Image.file(_selectedImage!)
                    : Text("Please Select an image"),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: OutlinedButton.icon(
                  icon: SvgPicture.asset("assets/icons/heart.svg"),
                  label: Text("Upload Photo"),
                  onPressed: () async {
                    selectedImagePath = await openSinglePickerDialog();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Selected'),
                    ));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() == true) {
                      _formKey.currentState?.save();

                      final CelestialBody celestialBody = CelestialBody(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        size: double.parse(_sizeController.text),
                        distanceFromEarth:
                            double.parse(_distanceController.text),
                        image: selectedImagePath ?? ImageConstant.gifKram,
                        color:
                            selectedColor, // Utiliza el color seleccionado del dropdown
                        majorityNature:
                            selectedMajorityNature, // Utiliza la naturaleza seleccionada del dropdown
                        type:
                            selectedType, // Utiliza el tipo seleccionado del dropdown
                      );

                      bool saveSuccessful =
                          await DBHelper.saveCelestialBody(celestialBody);

                      if (saveSuccessful) {
                        // Mostrar el SnackBar después de guardar exitosamente
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Guardado exitosamente'),
                        ));
                      } else {
                        // Mostrar un mensaje en caso de que la operación de guardado falle
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text('Error al guardar. Inténtalo de nuevo.'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
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
                  child: Text("Confirm"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future openSinglePickerDialog() async {
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
                    await _pickImageFromCamera();
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
                    await _pickImageFromGallery();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
      return returnedImage.path;
    }
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        _selectedImage = File(returnedImage.path);
      });
      return returnedImage.path;
    }
  }
}
