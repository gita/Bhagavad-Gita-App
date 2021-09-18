class Chapter {
    Chapter({
        this.chapterNumber,
        this.nameTranslated,
        this.slug,
        this.versesCount,
    });

    int? chapterNumber;
    String? nameTranslated;
    String? slug;
    int? versesCount;

    factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapterNumber: json["chapterNumber"],
        nameTranslated: json["nameTranslated"],
        slug: json["slug"],
        versesCount: json["versesCount"],
    );

    Map<String, dynamic> toJson() => {
        "chapterNumber": chapterNumber,
        "nameTranslated": nameTranslated,
        "slug": slug,
        "versesCount": versesCount,
    };
}
