import 'package:flutter/material.dart';
import 'package:kandostum2/app/modules/login/pages/sign_in_page.dart';
import 'package:kandostum2/app/modules/profile/controllers/settings_controller.dart';
import 'package:kandostum2/app/shared/widgets/dialogs/back_dialog.dart';
import 'package:provider/provider.dart';

class ProfileSettingsPage extends StatefulWidget {
  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  SettingsController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller ??= Provider.of<SettingsController>(context);
  }

  _logOut() {
    showDialog(
      context: context,
      builder: (context) {
        return BackDialog(
          onConfirm: () => Navigator.of(context).pop(false),
          onCancel: () => _controller.signOut().then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          }),
          title: 'Sign Out',
          msg: 'Quit Application',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Sign Out'),
        icon: Icon(Icons.exit_to_app),
        onPressed: _logOut,
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('Dark Mode'),
            value: Theme.of(context).brightness == Brightness.dark,
            activeColor: Theme.of(context).accentColor,
            onChanged: (value) {
              _controller.changeBrightness(context, value);
            },
          ),
          SwitchListTile(
            title: Text('Get notifications only about my blood type?'),
            value: false,
            activeColor: Theme.of(context).accentColor,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
