import 'dart:convert';
import 'dart:developer';

import '../models/note.dart';
import 'package:http/http.dart' as http;

class ApiServices {

  static String _baseUrl = "https://notes-app-server-ril9.onrender.com/notes";

 static Future<void> addNote(Note note)async{
    Uri requestUri = Uri.parse(_baseUrl + "/add");
   var response =  await http.post(requestUri, body: note.toMap());
    var decode = jsonDecode(response.body);
    log(decode.toString());
  }

  static Future<void> deleteNote(Note note)async{
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response =  await http.post(requestUri, body: note.toMap());
    var decode = jsonDecode(response.body);
    log(decode.toString());
  }

  static Future<List<Note>> fetchNotes(String userid) async{
    Uri requestUri = Uri.parse(_baseUrl + "/list");
    var response =  await http.post(requestUri, body: {"userid": userid});
    var decode = jsonDecode(response.body);
    log(decode.toString());

    List<Note> notes = [];
    for(var noteMap in decode){
      Note newNotes = Note.fromMap(noteMap);
      notes.add(newNotes);
    }
    return notes;
  }

}