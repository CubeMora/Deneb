import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app_astronomy/src/services/image_picker.dart';
import 'package:flutter_app_astronomy/src/services/local_data.dart';

final _formKey = GlobalKey<FormState>();

class AddNewPlanetScreen extends StatefulWidget {
  const AddNewPlanetScreen({Key? key}) : super(key: key);

  @override
  State<AddNewPlanetScreen> createState() => _AddNewPlanetScreenState();
}

class _AddNewPlanetScreenState extends State<AddNewPlanetScreen> {
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
        child: Column(children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (name) => name!.length < 4
                        ? 'Name should be at least 4 characters'
                        : null,
                    decoration: InputDecoration(
                        hintText: "Planet Name",
                        prefixIcon: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SvgPicture.asset("assets/icons/heart.svg"))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      validator: (description) => description!.length < 10
                          ? 'Description should be at least 10 characters'
                          : null,
                      decoration: InputDecoration(
                          hintText: "Description",
                          prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child:
                                  SvgPicture.asset("assets/icons/heart.svg"))),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (description) => description!.length < 1
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
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (description) => description!.length < 1
                            ? 'This input is mandatory'
                            : null,
                        decoration: InputDecoration(
                          hintText: "Distance from earth (KM)",
                        ),
                      ))
                    ],
                  ),
                ],
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: OutlinedButton.icon(
              icon: SvgPicture.asset("assets/icons/heart.svg"),
              label: Text("Upload Photo"),
              onPressed: () {
                _formKey.currentState!.validate();

                ImagePickerService(
                  context,
                ).openSinglePickerDialog();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Added'),
                ));
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              _formKey.currentState!.validate();
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
                  return null; // Use the component's default.
                },
              ),
            ),
            child: Text("Confirm"),
          ),
        ]),
      ),
    );
  }
}
