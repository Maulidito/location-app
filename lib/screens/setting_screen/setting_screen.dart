import 'package:flutter/material.dart';
import 'package:location_app/constant/constants.dart';
import 'package:location_app/providers/provider_list_style.dart';
import 'package:location_app/providers/provider_theme.dart';
import 'package:location_app/screens/setting_screen/widgets/item_settings.dart';
import 'package:location_app/screens/setting_screen/widgets/viewing_style_example.dart';
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
          builder: (ctx, constraints) => SingleChildScrollView(
            child: Column(
              children: [
                ViewingStyleExample(constraints: constraints),
                SizedBox(height: 50),
                ListTile(
                  title: Text("Viewing Style"),
                  trailing: IconButton(
                      onPressed: () async {
                        final provider = Provider.of<ProviderListStyle>(context,
                            listen: false);
                        if (provider.listMode == LISTMODE) {
                          return await provider.changeMode(CAROUSELMODE);
                        }
                        return await Provider.of<ProviderListStyle>(context,
                                listen: false)
                            .changeMode(LISTMODE);
                      },
                      icon: Icon(
                          Provider.of<ProviderListStyle>(context).listMode ==
                                  LISTMODE
                              ? Icons.view_list
                              : Icons.view_carousel)),
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
          ),
        ));
  }
}
