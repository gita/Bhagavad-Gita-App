class ChapterListModel {
    ChapterListModel({
        this.data,
    });

    Data? data;

    factory ChapterListModel.fromJson(Map<String, dynamic> json) => ChapterListModel(
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.allGitaChapters,
    });

    AllGitaChapters? allGitaChapters;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        allGitaChapters: AllGitaChapters.fromJson(json["allGitaChapters"]),
    );

    Map<String, dynamic> toJson() => {
        "allGitaChapters": allGitaChapters!.toJson(),
    };
}

class AllGitaChapters {
    AllGitaChapters({
        this.nodes,
    });

    List<Node>? nodes;

    factory AllGitaChapters.fromJson(Map<String, dynamic> json) => AllGitaChapters(
        nodes: List<Node>.from(json["nodes"].map((x) => Node.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nodes": List<dynamic>.from(nodes!.map((x) => x.toJson())),
    };
}

class Node {
    Node({
        this.chapterNumber,
        this.nameTranslated,
        this.versesCount,
    });

    int? chapterNumber;
    String? nameTranslated;
    int? versesCount;

    factory Node.fromJson(Map<String, dynamic> json) => Node(
        chapterNumber: json["chapterNumber"],
        nameTranslated: json["nameTranslated"],
        versesCount: json["versesCount"],
    );

    Map<String, dynamic> toJson() => {
        "chapterNumber": chapterNumber,
        "nameTranslated": nameTranslated,
        "versesCount": versesCount,
    };
}
