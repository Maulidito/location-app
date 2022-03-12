import 'package:flutter/material.dart';

import 'package:location_app/providers/provider_place.dart';
import 'package:location_app/screens/add_address_screen/add_address_view_model.dart';
import './widget/location_input.dart';
import './widget/image_input.dart';
import './widget/bottomsheet_verification.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);
  static const routeName = "/add-address";

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  late FocusNode _textFocus;

  @override
  void initState() {
    // TODO: implement initState
    _textFocus = FocusNode();
    debugPrint("/Add Address initialization...");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = AddAddressViewModel();
    debugPrint("Building ${AddAddressScreen.routeName}...");
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Places"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      focusNode: _textFocus,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), label: Text("Title")),
                      controller: viewModel.titleTextControll,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(
                        onSelectImage: (data) => viewModel.setImage = data),
                    const SizedBox(
                      height: 20,
                    ),
                    LocationInput(
                        saveLocation: (data) => viewModel.setLocation = data)
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                if (viewModel.checkNull()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Insert Title & Image")));
                  return;
                }
                _textFocus.nextFocus();
                final result = await showModalBottomSheet<bool>(
                    isDismissible: false,
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15))),
                    builder: (context) => Scaffold(
                          backgroundColor: Colors.transparent,
                          body: BottomSheetVerification(
                            title: viewModel.getTitle!,
                            image: viewModel.getImage!,
                            location: viewModel.getLocation!,
                          ),
                        ));

                if (result == false) {
                  debugPrint("return botomsheet false..");
                  return;
                }
                if (result == null) {
                  return;
                }

                Provider.of<AllPlaces>(context, listen: false).addPlace(
                    viewModel.titleTextControll.text, viewModel.getImage!);
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.add),
              label: Text("Add Place"),
              style: ElevatedButton.styleFrom(
                  elevation: 0, fixedSize: Size(double.infinity, 50)),
            )
          ],
        ),
      ),
    );
  }
}
