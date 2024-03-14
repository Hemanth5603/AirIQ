class AQIModel {
  AQIModel({
    required this.status,
    required this.data,
  });
  late final String status;
  late final Data data;
  
  AQIModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.aqi,
    required this.idx,
    required this.attributions,
    required this.city,
    required this.dominentpol,
    required this.iaqi,
    required this.time,
    required this.forecast,
    required this.debug,
  });
  late final double aqi;
  late final double idx;
  late final List<Attributions> attributions;
  late final City city;
  late final String dominentpol;
  late final Iaqi iaqi;
  late final Time time;
  late final Forecast forecast;
  late final Debug debug;
  
  Data.fromJson(Map<String, dynamic> json){
    aqi = json['aqi'];
    idx = json['idx'];
    attributions = List.from(json['attributions']).map((e)=>Attributions.fromJson(e)).toList();
    city = City.fromJson(json['city']);
    dominentpol = json['dominentpol'];
    iaqi = Iaqi.fromJson(json['iaqi']);
    time = Time.fromJson(json['time']);
    forecast = Forecast.fromJson(json['forecast']);
    debug = Debug.fromJson(json['debug']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['aqi'] = aqi;
    _data['idx'] = idx;
    _data['attributions'] = attributions.map((e)=>e.toJson()).toList();
    _data['city'] = city.toJson();
    _data['dominentpol'] = dominentpol;
    _data['iaqi'] = iaqi.toJson();
    _data['time'] = time.toJson();
    _data['forecast'] = forecast.toJson();
    _data['debug'] = debug.toJson();
    return _data;
  }
}

class Attributions {
  Attributions({
    required this.url,
    required this.name,
  });
  late final String url;
  late final String name;
  
  Attributions.fromJson(Map<String, dynamic> json){
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['name'] = name;
    return _data;
  }
}

class City {
  City({
    required this.geo,
    required this.name,
    required this.url,
    required this.location,
  });
  late final List<double> geo;
  late final String name;
  late final String url;
  late final String location;
  
  City.fromJson(Map<String, dynamic> json){
    geo = List.castFrom<dynamic, double>(json['geo']);
    name = json['name'];
    url = json['url'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['geo'] = geo;
    _data['name'] = name;
    _data['url'] = url;
    _data['location'] = location;
    return _data;
  }
}

class Iaqi {
  Iaqi({
    required this.dew,
    required this.h,
    required this.p,
    required this.pm25,
    required this.t,
    required this.w,
    required this.wg,
  });
  late final Dew dew;
  late final H h;
  late final P p;
  late final Pm25 pm25;
  late final T t;
  late final W w;
  late final Wg wg;
  
  Iaqi.fromJson(Map<String, dynamic> json){
    dew = Dew.fromJson(json['dew']);
    h = H.fromJson(json['h']);
    p = P.fromJson(json['p']);
    pm25 = Pm25.fromJson(json['pm25']);
    t = T.fromJson(json['t']);
    w = W.fromJson(json['w']);
    wg = Wg.fromJson(json['wg']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dew'] = dew.toJson();
    _data['h'] = h.toJson();
    _data['p'] = p.toJson();
    _data['pm25'] = pm25.toJson();
    _data['t'] = t.toJson();
    _data['w'] = w.toJson();
    _data['wg'] = wg.toJson();
    return _data;
  }
}

class Dew {
  Dew({
    required this.v,
  });
  late final double v;
  
  Dew.fromJson(Map<String, dynamic> json){
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['v'] = v;
    return _data;
  }
}

class H {
  H({
    required this.v,
  });
  late final int v;
  
  H.fromJson(Map<String, dynamic> json){
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['v'] = v;
    return _data;
  }
}

class P {
  P({
    required this.v,
  });
  late final int v;
  
  P.fromJson(Map<String, dynamic> json){
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['v'] = v;
    return _data;
  }
}

class Pm25 {
  Pm25({
    required this.v,
  });
  late final int v;
  
  Pm25.fromJson(Map<String, dynamic> json){
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['v'] = v;
    return _data;
  }
}

class T {
  T({
    required this.v,
  });
  late final double v;
  
  T.fromJson(Map<String, dynamic> json){
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['v'] = v;
    return _data;
  }
}

class W {
  W({
    required this.v,
  });
  late final double v;
  
  W.fromJson(Map<String, dynamic> json){
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['v'] = v;
    return _data;
  }
}

class Wg {
  Wg({
    required this.v,
  });
  late final double v;
  
  Wg.fromJson(Map<String, dynamic> json){
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['v'] = v;
    return _data;
  }
}

class Time {
  Time({
    required this.s,
    required this.tz,
    required this.v,
    required this.iso,
  });
  late final String s;
  late final String tz;
  late final int v;
  late final String iso;
  
  Time.fromJson(Map<String, dynamic> json){
    s = json['s'];
    tz = json['tz'];
    v = json['v'];
    iso = json['iso'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['s'] = s;
    _data['tz'] = tz;
    _data['v'] = v;
    _data['iso'] = iso;
    return _data;
  }
}

class Forecast {
  Forecast({
    required this.daily,
  });
  late final Daily daily;
  
  Forecast.fromJson(Map<String, dynamic> json){
    daily = Daily.fromJson(json['daily']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['daily'] = daily.toJson();
    return _data;
  }
}

class Daily {
  Daily({
    required this.o3,
    required this.pm10,
    required this.pm25,
  });
  late final List<O3> o3;
  late final List<Pm10> pm10;
  late final List<Pm25> pm25;
  
  Daily.fromJson(Map<String, dynamic> json){
    o3 = List.from(json['o3']).map((e)=>O3.fromJson(e)).toList();
    pm10 = List.from(json['pm10']).map((e)=>Pm10.fromJson(e)).toList();
    pm25 = List.from(json['pm25']).map((e)=>Pm25.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['o3'] = o3.map((e)=>e.toJson()).toList();
    _data['pm10'] = pm10.map((e)=>e.toJson()).toList();
    _data['pm25'] = pm25.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class O3 {
  O3({
    required this.avg,
    required this.day,
    required this.max,
    required this.min,
  });
  late final int avg;
  late final String day;
  late final int max;
  late final int min;
  
  O3.fromJson(Map<String, dynamic> json){
    avg = json['avg'];
    day = json['day'];
    max = json['max'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['avg'] = avg;
    _data['day'] = day;
    _data['max'] = max;
    _data['min'] = min;
    return _data;
  }
}

class Pm10 {
  Pm10({
    required this.avg,
    required this.day,
    required this.max,
    required this.min,
  });
  late final int avg;
  late final String day;
  late final int max;
  late final int min;
  
  Pm10.fromJson(Map<String, dynamic> json){
    avg = json['avg'];
    day = json['day'];
    max = json['max'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['avg'] = avg;
    _data['day'] = day;
    _data['max'] = max;
    _data['min'] = min;
    return _data;
  }
}

class Debug {
  Debug({
    required this.sync,
  });
  late final String sync;
  
  Debug.fromJson(Map<String, dynamic> json){
    sync = json['sync'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['sync'] = sync;
    return _data;
  }
}