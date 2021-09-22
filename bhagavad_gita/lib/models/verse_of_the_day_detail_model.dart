import 'dart:convert';

VerseOTheDayDetailResponseModel verseOTheDayDetailResponseModelFromJson(
        String str) =>
    VerseOTheDayDetailResponseModel.fromJson(json.decode(str));

String verseOTheDayDetailResponseModelToJson(
        VerseOTheDayDetailResponseModel data) =>
    json.encode(data.toJson());

class VerseOTheDayDetailResponseModel {
  VerseOTheDayDetailResponseModel({
    this.gitaVerseById,
  });

  GitaVerseById? gitaVerseById;

  factory VerseOTheDayDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      VerseOTheDayDetailResponseModel(
        gitaVerseById: GitaVerseById.fromJson(json["gitaVerseById"]),
      );

  Map<String, dynamic> toJson() => {
        "gitaVerseById": gitaVerseById!.toJson(),
      };
}

class GitaVerseById {
  GitaVerseById({
    this.chapterNumber,
    this.verseNumber,
    this.gitaTranslationsByVerseId,
  });

  int? chapterNumber;
  int? verseNumber;
  GitaTranslationsByVerseId? gitaTranslationsByVerseId;

  factory GitaVerseById.fromJson(Map<String, dynamic> json) => GitaVerseById(
        chapterNumber: json["chapterNumber"],
        verseNumber: json["verseNumber"],
        gitaTranslationsByVerseId: GitaTranslationsByVerseId.fromJson(
            json["gitaTranslationsByVerseId"]),
      );

  Map<String, dynamic> toJson() => {
        "chapterNumber": chapterNumber,
        "verseNumber": verseNumber,
        "gitaTranslationsByVerseId": gitaTranslationsByVerseId!.toJson(),
      };
}

class GitaTranslationsByVerseId {
  GitaTranslationsByVerseId({
    this.nodes,
  });

  List<Node>? nodes;

  factory GitaTranslationsByVerseId.fromJson(Map<String, dynamic> json) =>
      GitaTranslationsByVerseId(
        nodes: List<Node>.from(json["nodes"].map((x) => Node.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nodes": List<dynamic>.from(nodes!.map((x) => x.toJson())),
      };
}

class Node {
  Node({
    this.description,
  });

  String? description;

  factory Node.fromJson(Map<String, dynamic> json) => Node(
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
      };
}
