class PrecautionShortModel {
  PrecautionShortModel({
    required this.topic,
    required this.p1,
    required this.p2,
    required this.p3,
  });
  late final String topic;
  late final String p1;
  late final String p2;
  late final String p3;
  
  PrecautionShortModel.fromJson(Map<String, dynamic> json){
    topic = json['topic'];
    p1 = json['p1'];
    p2 = json['p2'];
    p3 = json['p3'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['topic'] = topic;
    _data['p1'] = p1;
    _data['p2'] = p2;
    _data['p3'] = p3;
    return _data;
  }
}