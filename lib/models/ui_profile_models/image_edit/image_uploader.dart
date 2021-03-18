import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:the_ranch_app/services/auth.dart';
import 'package:the_ranch_app/services/database.dart';

class Uploader extends StatefulWidget {
  final File file;

  Uploader({@required this.file});

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://ranch-2dcc8.appspot.com');

  StorageUploadTask _uploadTask;

  /// Starts an upload task
  void _startUpload(BuildContext context) async {
    Auth auth = Auth();

    /// Unique file name for the file
    String uid = await auth.currentUser
        .then((currentUser) => currentUser.uid.toString());
    String filePath = 'images/$uid.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  Widget uploadTaskWidget(BuildContext context, StorageUploadTask task) {
    if (task.isComplete)
      return FlatButton(
        child: Text('Go Back'),
        onPressed: () async {
          Database database = Database();
          await database.addPathToDatabase();
          Navigator.pop(context);
        },
      );
    else if (task.isPaused)
      return FlatButton(
        child: Icon(Icons.play_arrow),
        onPressed: _uploadTask.resume,
      );
    else if (task.isInProgress)
      return FlatButton(
        child: Icon(Icons.pause),
        onPressed: _uploadTask.pause,
      );
    else {
      return Text('Task Cancelled');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              children: [
                uploadTaskWidget(context, _uploadTask),
                // Progress bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LinearProgressIndicator(value: progressPercent),
                ),
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return FlatButton.icon(
        label: Text('Send It to the Ranch'),
        icon: Icon(Icons.cloud_upload),
        onPressed: () => _startUpload(context),
      );
    }
  }
}
