import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/pages/add_new_note.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
        centerTitle: true,
      ),
      body:(notesProvider.isLoading == false)? SafeArea(
        child:(notesProvider.notes.length > 0) ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: notesProvider.notes.length,
            itemBuilder: (context, index) {
              Note currentNote = notesProvider.notes[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          AddNewNote(isUpdate: true, note: currentNote),
                    ),
                  );
                },
                onLongPress: () {
                  notesProvider.deleteNote(currentNote);
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade200, width: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentNote.title!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        currentNote.content!,
                        style: TextStyle(fontSize: 16),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            }): Center(child: Text("No Notes yet",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
      ): Center(child: CircularProgressIndicator(color: Colors.blue.shade200, strokeWidth: 2,)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AddNewNote(
                        isUpdate: false,
                      )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
