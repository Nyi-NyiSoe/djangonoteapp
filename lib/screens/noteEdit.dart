import 'package:djangonoteapp/utils/loadData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoteEdit extends ConsumerWidget {
  const NoteEdit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _contentController = TextEditingController();
    final data = ref.watch(noteProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Edit Note'),
        ),
        body: Column(
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
    );
  }
}
