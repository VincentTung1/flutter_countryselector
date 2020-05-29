
class Country {
  int code;
  String tw;
  String en;
  String locale;
  String zh;

  Country({this.code, this.tw, this.en, this.locale, this.zh});

  Country.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    tw = json['tw'];
    en = json['en'];
    locale = json['locale'];
    zh = json['zh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['tw'] = this.tw;
    data['en'] = this.en;
    data['locale'] = this.locale;
    data['zh'] = this.zh;
    return data;
  }
}