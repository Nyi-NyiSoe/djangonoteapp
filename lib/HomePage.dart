import 'package:djangonoteapp/models/Note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:djangonoteapp/utils/loadData.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  data = ref.watch(noteProvider);
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _contentController = TextEditingController();
    return SafeArea(
        child: Scaffold(
      floatingActionButton: ElevatedButton(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(Colors.blue),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                content: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            hintText: "Title",
                          ),
                        ),
                        TextField(
                          controller: _contentController,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Write something here..",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                             ref.read(noteProvider.notifier).addNote(
                              _titleController.text,
                              _contentController.text, ); 
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Django Note App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: data.isEmpty
          ? const Center(
              child: Text('No notes available'),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].title),
                  subtitle: Text(data[index].content),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async{
                      await ref.read(noteProvider.notifier).deleteNote(
                        data[index].id.toString(),
                      );
                    },
                  ),
                );
              },
            ),  
          
    ));
  }
}
