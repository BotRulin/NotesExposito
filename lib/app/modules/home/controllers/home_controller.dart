import 'package:get/get.dart';
import 'package:supabase_example/app/data/models/notes_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  RxList allNotes = List<Notes>.empty().obs;
  SupabaseClient client = Supabase.instance.client;

  Future<void> getAllNotes() async {
    var notes = await client.from("notes").select().match(
      {"user_id": client.auth.currentUser!.id}, //get all notes data with match user id
    );
    List<Notes> notesData = Notes.fromJsonList((notes as List));
    allNotes(notesData);
    allNotes.refresh();
  }

  Future<void> deleteNote(int id) async {
    await client.from("notes").delete().match({
      "id": id,
    });
    getAllNotes();
  }
}
