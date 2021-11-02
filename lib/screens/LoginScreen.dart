import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';

import '../models/UserModel.dart';

import '../components/forms/GenericTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  UserModel userObject = UserModel();

  var _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'An error occured',
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Okay'),
          )
        ],
      ),
    );
  }

  String? Function(String?) _addCredentialsValidator() {
    return (value) {
      if (value!.isEmpty) {
        return 'Please enter value';
      }
    };
  }

  void Function()? _updateUsernameValue(String value) {
    userObject.username = value;
  }

  void Function()? _updatePasswordValue(String value) {
    userObject.password = value;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          height: deviceSize.height * 0.4,
          margin: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 8.0,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GenericTextField(
                      labelText: 'Username',
                      validator: _addCredentialsValidator(),
                      updateTextFieldInAllInputsMap: _updateUsernameValue,
                    ),
                    GenericTextField(
                      labelText: 'Password',
                      validator: _addCredentialsValidator(),
                      updateTextFieldInAllInputsMap: _updatePasswordValue,
                    ),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 10,
                        ),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints.tightFor(
                              width: 240,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFF6C00),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(
                                    () {
                                      _isLoading = true;
                                    },
                                  );
                                  try {
                                    await Provider.of<AuthProvider>(
                                      context,
                                      listen: false,
                                    ).login(userObject);
                                  } catch (error) {
                                    _showErrorDialog(
                                      'Kindly check you\'ve entered the right credentials and that you\'re connected to the internet',
                                    );
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    throw error;
                                  }
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              child: const Text('Login'),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
