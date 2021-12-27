class Chapter {
  Chapter({
    this.chapterNumber,
    this.nameTranslated,
    this.name,
    this.versesCount,
  });

  int? chapterNumber;
  String? nameTranslated;
  String? name;
  int? versesCount;
  bool? isExpanded = false;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterNumber: json["chapterNumber"],
        name: json["name"],
        nameTranslated: json["nameTranslated"],
        versesCount: json["versesCount"],
      );

  Map<String, dynamic> toJson() => {
        "chapterNumber": chapterNumber,
        "name": name,
        "nameTranslated": nameTranslated,
        "versesCount": versesCount,
      };
}
