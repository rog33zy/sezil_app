import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:recase/recase.dart';

import '../providers/RegisterSezilFarmerProvider.dart';

import '../models/UserModel.dart';

import '../components/UI/AppDrawer.dart';
import '../components/forms/GenericTextField.dart';
import '../components/forms/DropdownTextField.dart';

class RegisterSezilFarmerScreen extends StatefulWidget {
  const RegisterSezilFarmerScreen({Key? key}) : super(key: key);

  static const routeName = '/register-farmer';

  @override
  State<RegisterSezilFarmerScreen> createState() =>
      _RegisterSezilFarmerScreenState();
}

class _RegisterSezilFarmerScreenState extends State<RegisterSezilFarmerScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  String _errorMessage = "";

  UserModel newUserObject = UserModel();

  String? Function(String?) _generalValidator() {
    return (value) {
      if (value!.isEmpty) {
        return 'Please enter value';
      }
      return null;
    };
  }

  void Function()? updateFirstNameValue(String value) {
    newUserObject.firstName = value.titleCase;
  }

  void Function()? updateLastNameValue(String value) {
    newUserObject.lastName = value.titleCase;
  }

  void Function()? updateEmailValue(String value) {
    newUserObject.email = value;
  }

  void Function()? updateFarmerIdValue(String value) {
    newUserObject.farmerId = value.toUpperCase();
  }

  void Function()? updateCropValue(String value) {
    newUserObject.crop = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Farmer'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              GenericTextField(
                labelText: 'First Name',
                validator: _generalValidator(),
                updateTextFieldInAllInputsMap: updateFirstNameValue,
              ),
              GenericTextField(
                labelText: 'Last Name',
                validator: _generalValidator(),
                updateTextFieldInAllInputsMap: updateLastNameValue,
              ),
              GenericTextField(
                labelText: 'Email',
                validator: _generalValidator(),
                updateTextFieldInAllInputsMap: updateEmailValue,
              ),
              GenericTextField(
                labelText: 'Farmer ID',
                validator: _generalValidator(),
                updateTextFieldInAllInputsMap: updateFarmerIdValue,
              ),
              DropdownTextField(
                labelText: 'Crop',
                listOfValues: <String>[
                  'Maize',
                  'Beans',
                  'Sorghum',
                  'Sunflower',
                ],
                hintText: 'Please select crop',
                updateDropDownValuesInAllInputsMap: updateCropValue,
              ),
              if (_isLoading) const CircularProgressIndicator(),
              if (!_isLoading)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 10,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints.tightFor(
                        width: 240,
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            await Provider.of<RegisterSezilFarmerProvider>(
                              context,
                              listen: false,
                            )
                                .registerFarmer(newUserObject)
                                .then(
                                  (_) => {
                                    setState(
                                      () {
                                        _isLoading = false;
                                      },
                                    ),
                                    Navigator.of(context)
                                        .pushReplacementNamed('/'),
                                  },
                                )
                                .catchError((error) {
                              setState(() {
                                _isLoading = false;
                                _errorMessage = error.toString();
                              });
                            });
                          }
                        },
                        child: const Text('Register Farmer'),
                      ),
                    ),
                  ),
                ),
              Text(_errorMessage),
            ],
          ),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
