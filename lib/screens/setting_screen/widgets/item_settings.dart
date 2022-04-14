import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/provider_theme.dart';

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
