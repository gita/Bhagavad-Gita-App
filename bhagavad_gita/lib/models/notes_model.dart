import 'package:bhagavad_gita/models/verse_detail_model.dart';

class VerseNotes {
  String? verseID;
  GitaVerseById? gitaVerseById;
  DateTime addedDate = DateTime.now();
  String verseNote;

  VerseNotes({this.verseID, this.gitaVerseById, required this.verseNote});

  factory VerseNotes.fromJson(Map<String, dynamic> json) => VerseNotes(
      gitaVerseById: GitaVerseById.fromJson(json["gitaVerseById"]),
      verseID: json["verseID"],
      verseNote: json["verseNote"]);

  Map<String, dynamic> toJson() => {
        "verseID": verseID,
        "gitaVerseById": gitaVerseById,
        "verseNote": verseNote
      };
}
