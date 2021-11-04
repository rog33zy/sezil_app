import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/AuthProvider.dart';
import '../providers/SynchronizeTraitsProvider.dart';

import '../components/UI/AppDrawer.dart';

class SynchronizeScreen extends StatefulWidget {
  static const routeName = '/synchronize-screen';

  const SynchronizeScreen({Key? key}) : super(key: key);

  @override
  _SynchronizeScreenState createState() => _SynchronizeScreenState();
}

class _SynchronizeScreenState extends State<SynchronizeScreen> {
  var _isLoading = false;
  var _errorMessage;
  @override
  Widget build(BuildContext context) {
    final int numberOfItemsToBeSynced = Provider.of<SynchronizeTraitsProvider>(
      context,
      listen: true,
    ).totalNumberOfItemsToBeSynced;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Synchronize'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Center(
            child:
                Text('There are $numberOfItemsToBeSynced items to be synced.'),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                width: 240,
              ),
              child: _isLoading
                  ? Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Center(
                        child: LinearProgressIndicator(),
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFFF6C00),
                      ),
                      onPressed: numberOfItemsToBeSynced == 0
                          ? null
                          : () async {
                              setState(
                                () {
                                  _isLoading = true;
                                },
                              );
                              await Provider.of<AuthProvider>(
                                context,
                                listen: false,
                              ).refreshToken();
                              await Provider.of<SynchronizeTraitsProvider>(
                                context,
                                listen: false,
                              ).postPostPlantingObjectsToServer();
                              //     .catchError((error) {
                              //   setState(() {
                              //     _errorMessage = error;
                              //   });
                              // });
                              Navigator.of(context).pushReplacementNamed('/');
                            },
                      child: const Text('Sync'),
                    ),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
    );
  }
}
