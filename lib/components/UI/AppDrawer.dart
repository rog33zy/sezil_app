import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../providers/AuthProvider.dart';

import '../../screens/SynchronizeScreen.dart';
import '../../screens/RegisterSezilFarmerScreen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello ${authProvider.firstName![0]}Farmer'),
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
            leading: Icon(
              Icons.app_registration,
            ),
            title: const Text('REGISTER FARMER'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                RegisterSezilFarmerScreen.routeName,
              );
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
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
            ),
            title: const Text(
              'LOGOUT',
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              authProvider.logout();
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
