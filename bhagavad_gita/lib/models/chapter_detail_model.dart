class ChapterDetailData {
  ChapterDetailData({
    this.gitaChapterById,
  });

  GitaChapterById? gitaChapterById;

  factory ChapterDetailData.fromJson(Map<String, dynamic> json) =>
      ChapterDetailData(
        gitaChapterById: GitaChapterById.fromJson(json["gitaChapterById"]),
      );

  Map<String, dynamic> toJson() => {
        "gitaChapterById": gitaChapterById!.toJson(),
      };
}

class GitaChapterById {
  GitaChapterById({
    this.chapterNumber,
    this.nameTranslated,
    this.name,
    this.chapterSummary,
    this.gitaVersesByChapterId,
  });

  int? chapterNumber;
  String? nameTranslated;
  String? name;
  String? chapterSummary;
  GitaVersesByChapterId? gitaVersesByChapterId;

  factory GitaChapterById.fromJson(Map<String, dynamic> json) =>
      GitaChapterById(
        chapterNumber: json["chapterNumber"],
        nameTranslated: json["nameTranslated"],
        name: json["name"],
        chapterSummary: json["chapterSummary"],
        gitaVersesByChapterId:
            GitaVersesByChapterId.fromJson(json["gitaVersesByChapterId"]),
      );

  Map<String, dynamic> toJson() => {
        "chapterNumber": chapterNumber,
        "nameTranslated": nameTranslated,
        "name": name,
        "chapterSummary": chapterSummary,
        "gitaVersesByChapterId": gitaVersesByChapterId!.toJson(),
      };
}

class GitaVersesByChapterId {
  GitaVersesByChapterId({
    this.nodes,
  });

  List<GitaVersesByChapterIdNode>? nodes;

  factory GitaVersesByChapterId.fromJson(Map<String, dynamic> json) =>
      GitaVersesByChapterId(
        nodes: List<GitaVersesByChapterIdNode>.from(
            json["nodes"].map((x) => GitaVersesByChapterIdNode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nodes": List<dynamic>.from(nodes!.map((x) => x.toJson())),
      };
}

class GitaVersesByChapterIdNode {
  GitaVersesByChapterIdNode({
    this.chapterNumber,
    this.verseNumber,
    this.gitaTranslationsByVerseId,
  });

  int? chapterNumber;
  int? verseNumber;
  GitaTranslationsByVerseId? gitaTranslationsByVerseId;

  factory GitaVersesByChapterIdNode.fromJson(Map<String, dynamic> json) =>
      GitaVersesByChapterIdNode(
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

  List<GitaTranslationsByVerseIdNode>? nodes;

  factory GitaTranslationsByVerseId.fromJson(Map<String, dynamic> json) =>
      GitaTranslationsByVerseId(
        nodes: List<GitaTranslationsByVerseIdNode>.from(json["nodes"]
            .map((x) => GitaTranslationsByVerseIdNode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "nodes": List<dynamic>.from(nodes!.map((x) => x.toJson())),
      };
}

class GitaTranslationsByVerseIdNode {
  GitaTranslationsByVerseIdNode({
        this.description,
        this.verseId,
    });

    String? description;
    int? verseId;

    factory GitaTranslationsByVerseIdNode.fromJson(Map<String, dynamic> json) => GitaTranslationsByVerseIdNode(
        description: json["description"],
        verseId: json["verseId"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "verseId": verseId,
    };
}
