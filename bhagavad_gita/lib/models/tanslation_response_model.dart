import 'dart:convert';

List<TranslationResponseModel> translationResponseModelFromJson(String str) =>
    List<TranslationResponseModel>.from(
        json.decode(str).map((x) => TranslationResponseModel.fromJson(x)));

String translationResponseModelToJson(List<TranslationResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TranslationResponseModel {
  TranslationResponseModel({
    this.authorName,
    this.language,
    this.title,
  });

  String? authorName;
  String? language;
  String? title;

  factory TranslationResponseModel.fromJson(Map<String, dynamic> json) =>
      TranslationResponseModel(
        authorName: json["authorName"],
        language: json["language"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "authorName": authorName,
        "language": language,
        "title": title,
      };
}
