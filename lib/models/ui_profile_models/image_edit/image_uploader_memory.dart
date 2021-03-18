import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:the_ranch_app/design/constants.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/services/database.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UploaderMemory extends StatefulWidget {
  final File file;
  final RanchUser ranchUser;

  UploaderMemory({@required this.file, @required this.ranchUser});

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<UploaderMemory> {
  String memoryDescription = '';

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://ranch-2dcc8.appspot.com');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  StorageUploadTask _uploadTask;

  String getCurrentTime() {
    initializeDateFormatting();
    var time = DateTime.now();
    var formatTime = DateFormat('yyyy-MM-dd – kk:mm');
    String currentTime = formatTime.format(time);
    return currentTime;
  }

  bool validator(String value) {
    return value.isNotEmpty;
  }

  /// Starts an upload task
  void _startUpload(BuildContext context) async {
    /// Unique file name for the file
    String filePath = 'memories/${getCurrentTime()}.png';

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
          await database.addMemory(memoryDescription,
              'memories/${getCurrentTime()}.png', widget.ranchUser);
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
      return Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: kTextFieldDesign.copyWith(
                    filled: true, hintText: 'Enter a description'),
                validator: (value) => value.isNotEmpty ? null : 'Cant be empty',
                onSaved: (value) {
                  setState(() {
                    memoryDescription = value;
                  });
                },
              ),
            ),
          ),
          FlatButton.icon(
              label: Text('Send it to the Ranch'),
              icon: Icon(Icons.cloud_upload),
              onPressed: () {
                _formKey.currentState.validate();
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  _startUpload(context);
                }
              }),
        ],
      );
    }
  }
}
