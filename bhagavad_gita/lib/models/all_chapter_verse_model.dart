import 'dart:convert';

GetAllChapterVerseResponseModel getAllChapterVerseResponseModelFromJson(String str) => GetAllChapterVerseResponseModel.fromJson(json.decode(str));

String getAllChapterVerseResponseModelToJson(GetAllChapterVerseResponseModel data) => json.encode(data.toJson());

class GetAllChapterVerseResponseModel {
    GetAllChapterVerseResponseModel({
        this.gitaChapterById,
    });

    GitaChapterById? gitaChapterById;

    factory GetAllChapterVerseResponseModel.fromJson(Map<String, dynamic> json) => GetAllChapterVerseResponseModel(
        gitaChapterById: GitaChapterById.fromJson(json["gitaChapterById"]),
    );

    Map<String, dynamic> toJson() => {
        "gitaChapterById": gitaChapterById!.toJson(),
    };
}

class GitaChapterById {
    GitaChapterById({
        this.versesCount,
        this.gitaVersesByChapterId,
    });

    int? versesCount;
    GitaVersesByChapterId? gitaVersesByChapterId;

    factory GitaChapterById.fromJson(Map<String, dynamic> json) => GitaChapterById(
        versesCount: json["versesCount"],
        gitaVersesByChapterId: GitaVersesByChapterId.fromJson(json["gitaVersesByChapterId"]),
    );

    Map<String, dynamic> toJson() => {
        "versesCount": versesCount,
        "gitaVersesByChapterId": gitaVersesByChapterId!.toJson(),
    };
}

class GitaVersesByChapterId {
    GitaVersesByChapterId({
        this.nodes,
    });

    List<ChapterVerseInfo>? nodes;

    factory GitaVersesByChapterId.fromJson(Map<String, dynamic> json) => GitaVersesByChapterId(
        nodes: List<ChapterVerseInfo>.from(json["nodes"].map((x) => ChapterVerseInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nodes": List<dynamic>.from(nodes!.map((x) => x.toJson())),
    };
}

class ChapterVerseInfo {
    ChapterVerseInfo({
        this.id,
        this.verseNumber,
    });

    int? id;
    int? verseNumber;

    factory ChapterVerseInfo.fromJson(Map<String, dynamic> json) => ChapterVerseInfo(
        id: json["id"],
        verseNumber: json["verseNumber"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "verseNumber": verseNumber,
    };
}