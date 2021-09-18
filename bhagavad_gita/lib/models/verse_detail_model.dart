class Data {
    Data({
        this.gitaVerseById,
    });

    GitaVerseById? gitaVerseById;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        this.text,
        this.gitaTranslationsByVerseId,
        this.gitaCommentariesByVerseId,
    });

    int? chapterNumber;
    int? verseNumber;
    String? text;
    GitaSByVerseId? gitaTranslationsByVerseId;
    GitaSByVerseId? gitaCommentariesByVerseId;

    factory GitaVerseById.fromJson(Map<String, dynamic> json) => GitaVerseById(
        chapterNumber: json["chapterNumber"],
        verseNumber: json["verseNumber"],
        text: json["text"],
        gitaTranslationsByVerseId: GitaSByVerseId.fromJson(json["gitaTranslationsByVerseId"]),
        gitaCommentariesByVerseId: GitaSByVerseId.fromJson(json["gitaCommentariesByVerseId"]),
    );

    Map<String, dynamic> toJson() => {
        "chapterNumber": chapterNumber,
        "verseNumber": verseNumber,
        "text": text,
        "gitaTranslationsByVerseId": gitaTranslationsByVerseId!.toJson(),
        "gitaCommentariesByVerseId": gitaCommentariesByVerseId!.toJson(),
    };
}

class GitaSByVerseId {
    GitaSByVerseId({
        this.nodes,
    });

    List<Node>? nodes;

    factory GitaSByVerseId.fromJson(Map<String, dynamic> json) => GitaSByVerseId(
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
