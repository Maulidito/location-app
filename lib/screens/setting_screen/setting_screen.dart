import 'package:flutter/material.dart';
import 'package:location_app/providers/provider_theme.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);
  static const routename = "/setting";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Setting"),
        ),
        body: LayoutBuilder(
          builder: (ctx, constraints) => Column(
            children: [
              Container(
                width: double.infinity,
                height: constraints.maxHeight * 0.5,
                color: Colors.blueGrey,
              ),
              SizedBox(height: 50),
              ListTile(
                title: Text("Viewing Style"),
                trailing:
                    IconButton(onPressed: () {}, icon: Icon(Icons.view_list)),
              ),
              Divider(),
              itemSettings(),
              Divider(),
              ListTile(
                title: Text("Reset Data & Configuration"),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.replay_circle_filled_outlined)),
              ),
              Divider(),
            ],
          ),
        ));
  }
}

class itemSettings extends StatefulWidget {
  const itemSettings({
    Key? key,
  }) : super(key: key);

  @override
  State<itemSettings> createState() => _itemSettingsState();
}

class _itemSettingsState extends State<itemSettings> {
  @override
  Widget build(BuildContext context) {
    final providerTheme = Provider.of<ProviderTheme>(context, listen: false);
    return ListTile(
      title: Text("Dark Mode"),
      trailing: IconButton(
          onPressed: () async {
            await providerTheme.changeTheme(!providerTheme.themeMode!);
          },
          icon: providerTheme.themeMode!
              ? Icon(Icons.dark_mode)
              : Icon(Icons.light_mode)),
    );
  }
}
