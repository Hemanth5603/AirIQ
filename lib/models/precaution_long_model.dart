class PrecautionLongModel {
  PrecautionLongModel({
    required this.title,
    required this.paragraphs,
  });
  late final String title;
  late final List<String> paragraphs;
  
  PrecautionLongModel.fromJson(Map<String, dynamic> json){
    title = json['title'];
    paragraphs = List.castFrom<dynamic, String>(json['paragraphs']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['paragraphs'] = paragraphs;
    return _data;
  }
}