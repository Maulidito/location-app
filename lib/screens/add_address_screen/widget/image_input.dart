import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:location_app/widgets/frame_image.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  const ImageInput({Key? key, required this.onSelectImage}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        FrameImage(
          child: _storedImage != null
              ? Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: [
                      Image.file(
                        _storedImage!,
                        fit: BoxFit.cover,
                      ),
                      PositionedDirectional(
                          end: 1,
                          top: 1,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _storedImage = null;
                                });
                              },
                              icon: Icon(
                                Icons.close_outlined,
                                color: Colors.white,
                              )))
                    ])
              : Material(
                  color: Colors.grey[200],
                  child: InkWell(
                    splashColor: Theme.of(context).colorScheme.primary,
                    onTap: () async {
                      try {
                        final image = await _picker.pickImage(
                          source: ImageSource.gallery,
                          maxWidth: 600,
                        );

                        if (image != null) {
                          setState(() {
                            _storedImage = File(image.path);
                          });
                          widget.onSelectImage(File(image.path));
                        }
                      } catch (e) {
                        debugPrint("Show Snack Bar");
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("error ${e.toString()}")));
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_rounded,
                          size: 50,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Text(
                          "Take From Gallery",
                          style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).colorScheme.primary),
                        )
                      ],
                    ),
                  ),
                ),
        ),
        Expanded(
            child: SizedBox(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextButton.icon(
                onPressed: () async {
                  try {
                    final image =
                        await _picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      setState(() {
                        _storedImage = File(image.path);
                      });

                      final appDir =
                          await syspath.getApplicationDocumentsDirectory();
                      final fileName = path.basename(image.path);
                      final savedImage = await File(image.path)
                          .copy('${appDir.path}/$fileName');
                      widget.onSelectImage(savedImage);
                      debugPrint("image save to ${savedImage.path}");
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                icon: Icon(Icons.camera),
                label: Text(
                  "Take Camera",
                  style: TextStyle(fontSize: 18),
                )),
          ),
        ))
      ],
    );
  }
}
