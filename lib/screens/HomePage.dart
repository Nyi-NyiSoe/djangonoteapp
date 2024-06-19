import 'package:djangonoteapp/models/Note.dart';
import 'package:djangonoteapp/screens/noteEdit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:djangonoteapp/utils/loadData.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(noteProvider);
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
                            onPressed: () {
                              ref.read(noteProvider.notifier).addNote(
                                    _titleController.text,
                                    _contentController.text,
                                  );
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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: false,
              pinned: true,
              backgroundColor: Colors.blue,
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.all(10),
                centerTitle: true,
                background: Container(
                  color: Colors.deepPurpleAccent,
                ),
                title: const Text(
                  'D j a n g o N o t e',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            data.isEmpty
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: Text('Empty notes'),
                    ),
                  )
                : SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 1.0,
                        crossAxisCount: 2),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            title: Text(data[index].title),
                            subtitle: Text(data[index].content),
                          ),
                        ),
                      );
                    }, childCount: data.length),
                  )
          ],
        ),
      ),
    );
  }
}
