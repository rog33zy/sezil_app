import 'package:flutter/material.dart';

import '../components/UI/AppDrawer.dart';


class SynchronizeScreen extends StatefulWidget {
  static const routeName = '/synchronize-screen';
  
  const SynchronizeScreen({Key? key}) : super(key: key);

  @override
  _SynchronizeScreenState createState() => _SynchronizeScreenState();
}

class _SynchronizeScreenState extends State<SynchronizeScreen> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {

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
              child: Text(
                  'There are 0 items to be synced.'),),
       
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
                      onPressed: (){},
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
