import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNote extends StatefulWidget {
  final bool isUpdate;
  final Note? note;

  const AddNewNote({Key? key, required this.isUpdate, this.note})
      : super(key: key);

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  FocusNode noteFocus = FocusNode();

  void addNewNote() {
    Note newNote = Note(
        id: Uuid().v1(),
        userid: "anurag82",
        title: titleController.text,
        content: contentController.text,
        dateAdded: DateTime.now());
    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }
  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.dateAdded = DateTime.now();
    Provider.of<NotesProvider>(context, listen: false)
        .updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (widget.isUpdate) {
                  updateNote();
                } else {
                  addNewNote();
                }
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                autofocus: (widget.isUpdate == true) ? false : true,
                onSubmitted: (val) {
                  if (val != "") {
                    noteFocus.requestFocus();
                  }
                },
                decoration: InputDecoration(
                    hintText: "Title", border: InputBorder.none),
              ),
              Expanded(
                child: TextField(
                  maxLines: null,
                  controller: contentController,
                  focusNode: noteFocus,
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                      hintText: "Note", border: InputBorder.none),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
