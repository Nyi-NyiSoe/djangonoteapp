import 'dart:async';
import 'dart:convert';
import 'package:riverpod/riverpod.dart';
import 'package:djangonoteapp/models/Note.dart';
import 'package:http/http.dart' as http;

final noteProvider = StateNotifierProvider<LoadData, List<Note>>((ref) {
  return LoadData([]);
}); 
class LoadData extends StateNotifier<List<Note>> {
  static const String urlHeader = 'http://10.0.2.2:8000';
  static const String getAllNotesUrl = '/notes/';
  static const String addNoteUrl = '/notes/add';
  static const String deleteNoteUrl = '/notes/delete/';

  final http.Client client = http.Client();

  LoadData(List<Note> state) :  super(state) {
    getNotes();
  }

  Future<void> getNotes() async {
    try {
      final response = await client.get(Uri.parse(urlHeader + getAllNotesUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        for (var note in data) {
          state = [...state, Note.fromJson(note)];
        }
      } else {
        throw Exception('Failed to load notes');
      }
    } catch (e) {
      print('Error loading notes: $e');
    }
  }

  Future<void> addNote(String title, String content) async {
    try {
      final response = await client.post(
        Uri.parse(urlHeader + addNoteUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"title": title, "content": content}),
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        state = [...state, Note.fromJson(data)];
      } else {
        throw Exception('Failed to add note');
      }
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      final response = await client.delete(Uri.parse(urlHeader + deleteNoteUrl + id));
      if (response.statusCode == 200) {
        if (state.isEmpty) {
          return;
        }
        state = state.where((note) => note.id.toString() != id).toList();
      } else {
        throw Exception('Failed to delete note');
      }
    } catch (e) {
      print('Error deleting note: $e');
    }
  }
}
