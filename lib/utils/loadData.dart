import 'dart:async';
import 'dart:convert';

import 'package:djangonoteapp/models/Note.dart';
import 'package:http/http.dart' as http;

class LoadData {
  static const urlHeader = 'http://10.0.2.2:8000';
  static const getAllNotesUrl = '/notes/';
  static const getSingleNote = '/notes/';
  static const addNoteUrl = '/notes/add/';
  static const updateNoteUrl = '/notes/update/';
  static const deleteNoteUrl = '/notes/delete/';

  http.Client client = http.Client();

  final StreamController<List<dynamic>> noteController =
      StreamController<List<dynamic>>.broadcast();

  Stream<List<dynamic>> get notes => noteController.stream;

  LoadData() {
    getAllNotes();
  }

  Future<void> getAllNotes() async {
    final response = await client.get(Uri.parse(urlHeader + getAllNotesUrl));
    if (response.statusCode == 200) {
      final List<dynamic> notes = jsonDecode(response.body);
      noteController.add(notes);
    } else {
      throw Exception('Failed to load notes');
    }
  }

  Future<void> addNote(Note note) async {
    final response = await client.post(Uri.parse(urlHeader + addNoteUrl),
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(note));

    if (response.statusCode == 201) {
      // Note successfully added
      await getAllNotes(); // Refresh the notes
    } else {
      throw Exception('Failed to add note');
    }
  }
}
