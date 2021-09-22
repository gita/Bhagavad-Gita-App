import 'dart:convert';

AllVerseOTheDayResponseModel allVerseOTheDayResponseModelFromJson(String str) => AllVerseOTheDayResponseModel.fromJson(json.decode(str));

String allVerseOTheDayResponseModelToJson(AllVerseOTheDayResponseModel data) => json.encode(data.toJson());

class AllVerseOTheDayResponseModel {
    AllVerseOTheDayResponseModel({
        this.allVerseOfTheDays,
    });

    AllVerseOfTheDays? allVerseOfTheDays;

    factory AllVerseOTheDayResponseModel.fromJson(Map<String, dynamic> json) => AllVerseOTheDayResponseModel(
        allVerseOfTheDays: AllVerseOfTheDays.fromJson(json["allVerseOfTheDays"]),
    );

    Map<String, dynamic> toJson() => {
        "allVerseOfTheDays": allVerseOfTheDays!.toJson(),
    };
}

class AllVerseOfTheDays {
    AllVerseOfTheDays({
        this.nodes,
    });

    List<AllVerseOfTheDaysNode>? nodes;

    factory AllVerseOfTheDays.fromJson(Map<String, dynamic> json) => AllVerseOfTheDays(
        nodes: List<AllVerseOfTheDaysNode>.from(json["nodes"].map((x) => AllVerseOfTheDaysNode.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nodes": List<dynamic>.from(nodes!.map((x) => x.toJson())),
    };
}

class AllVerseOfTheDaysNode {
    AllVerseOfTheDaysNode({
        this.verseOrder,
    });

    int? verseOrder;

    factory AllVerseOfTheDaysNode.fromJson(Map<String, dynamic> json) => AllVerseOfTheDaysNode(
        verseOrder: json["verseOrder"],
    );

    Map<String, dynamic> toJson() => {
        "verseOrder": verseOrder,
    };
}
