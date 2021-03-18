import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_ranch_app/models/memory_models/memory_model.dart';
import 'package:the_ranch_app/models/ranch_user.dart';
import 'package:the_ranch_app/models/ui_profile_models/image_edit/image_capture_memory.dart';
import 'package:the_ranch_app/services/database.dart';

class MemoriesScreen extends StatefulWidget {
  final RanchUser ranchUser;

  const MemoriesScreen({Key key, this.ranchUser}) : super(key: key);

  @override
  _MemoriesScreenState createState() => _MemoriesScreenState();
}

class _MemoriesScreenState extends State<MemoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('MemoriesScreen'),
      ),
      body: StreamBuilder<List<MemoryModel>>(
          stream: database.getMemories,
          builder: (context, snapshot) {
            List<MemoryModel> memoryModels = snapshot.data;

            return ListView.builder(
                itemCount: memoryModels?.length ?? 0,
                itemBuilder: (context, index) {
                  MemoryModel memory = memoryModels[index];

                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          height: 500,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 10.0,
                              ),
                              bottom: BorderSide(
                                width: 10.0,
                              ),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                  flex: 5,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.network(
                                            memory.image,
                                            fit: BoxFit.fill,
                                          ) ??
                                          Text('Image failed'),
                                    ),
                                  )),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    memory.description ??
                                        'Description not found',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textSelectionColor,
                                        fontSize: 24),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Added by:   ${memory.addedBy ?? 'not stated'}',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textSelectionColor,
                                        fontSize: 15),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ImageCaptureMemory(ranchUser: widget.ranchUser),
                ),
              );
            }),
      ),
    );
  }
}
