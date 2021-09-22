class Chapter {
  Chapter({
    this.chapterNumber,
    this.nameTranslated,
    this.versesCount,
  });

  int? chapterNumber;
  String? nameTranslated;
  int? versesCount;
  bool? isExpanded = false;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
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
