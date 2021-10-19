import 'package:flutter/material.dart';

import '../../screens/SynchronizeScreen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Rodgers'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(
              Icons.agriculture,
            ),
            title: const Text('HOMEPAGE'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.sync,
            ),
            title: const Text(
              'SYNCHRONIZE',
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(SynchronizeScreen.routeName);
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
