import 'package:flutter/cupertino.dart';
import 'package:notes_app/services/api_service.dart';

import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];

  NotesProvider(){
    fetchNotes();
  }

  void sortNotes(){
    notes.sort((a, b) => b.dateAdded!.compareTo(a.dateAdded!));
  }

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiServices.deleteNote(note);
  }

  void fetchNotes()async{
    notes = await ApiServices.fetchNotes("anurag82");
    sortNotes();
    isLoading = false;
    notifyListeners();
  }


}
