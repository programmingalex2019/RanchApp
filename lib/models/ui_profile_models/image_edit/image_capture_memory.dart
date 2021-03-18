import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/models/ui_profile_models/image_edit/image_uploader_memory.dart';

/// Widget to capture and crop the image
class ImageCaptureMemory extends StatefulWidget {
  final RanchUser ranchUser;

  const ImageCaptureMemory({Key key, this.ranchUser}) : super(key: key);

  createState() => _ImageCaptureMemoryState();
}

class _ImageCaptureMemoryState extends State<ImageCaptureMemory> {
  /// Active image file
  File _imageFile;

  /// Cropper plugin
  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected =
        await ImagePicker.pickImage(source: source, imageQuality: 30);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Select an image from the camera or gallery
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomAppBar(
          elevation: 2.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.photo_camera,
                  size: 40.0,
                ),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
              IconButton(
                icon: Icon(
                  Icons.photo_library,
                  size: 40.0,
                ),
                onPressed: () => _pickImage(
                  ImageSource.gallery,
                ),
              ),
            ],
          ),
        ),
      ),

      // Preview the image and crop it
      body: _imageFile != null
          ? Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ListView(
                children: <Widget>[
                  if (_imageFile != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(36.0),
                          child: Image.file(_imageFile)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FlatButton(
                            child: Icon(Icons.crop),
                            onPressed: _cropImage,
                          ),
                          FlatButton(
                            child: Icon(Icons.refresh),
                            onPressed: _clear,
                          ),
                        ],
                      ),
                    ),
                    UploaderMemory(
                        file: _imageFile, ranchUser: widget.ranchUser)
                  ]
                ],
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Make sure you are \n connected to the internet',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(fontSize: 30.0),
                ),
              ),
            ),
    );
  }
}
