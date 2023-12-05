import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app_astronomy/src/services/image_picker.dart';
import 'package:flutter_app_astronomy/src/services/db_helper.dart';
import 'package:flutter_app_astronomy/src/models/celestial_body.dart';
import 'package:flutter_app_astronomy/src/settings/constants/image_constant.dart';

final _formKey = GlobalKey<FormState>();

class AddNewPlanetScreen extends StatefulWidget {
  const AddNewPlanetScreen({Key? key}) : super(key: key);

  @override
  State<AddNewPlanetScreen> createState() => _AddNewPlanetScreenState();
}

class _AddNewPlanetScreenState extends State<AddNewPlanetScreen> {
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

  Color selectedColor = Colors.red; // Default color
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
      body: Padding(
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          validator: (size) =>
                              size!.isEmpty ? 'This input is mandatory' : null,
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
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: OutlinedButton.icon(
                icon: SvgPicture.asset("assets/icons/heart.svg"),
                label: Text("Upload Photo"),
                onPressed: () async {
                  selectedImagePath = await ImagePickerService(context)
                      .openPickerDialogAddPlanet();

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Selected'),
                  ));
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() == true) {
                  _formKey.currentState?.save();

                  final CelestialBody celestialBody = CelestialBody(
                    name: _nameController.text,
                    description: _descriptionController.text,
                    size: double.parse(_sizeController.text),
                    distanceFromEarth: double.parse(_distanceController.text),
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
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Guardado exitosamente'),
                    ));
                  } else {
                    // Mostrar un mensaje en caso de que la operación de guardado falle
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Error al guardar. Inténtalo de nuevo.'),
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
          ],
        ),
      ),
    );
  }
}
