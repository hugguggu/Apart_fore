class Apart {
  final String kaptCode;
  final String kaptName;
  final String bjdCode;
  final String as1;
  final String as2;
  final String as3;

  Apart(
      {this.kaptCode,
      this.kaptName,
      this.bjdCode,
      this.as1,
      this.as2,
      this.as3});

  factory Apart.fromJson(Map<String, dynamic> json) {
    return Apart(
      kaptCode: json['kaptCode'] as String,
      kaptName: json['kaptName'] as String,
      bjdCode: json['bjdCode'] as String,
      as1: json['as1'] as String,
      as2: json['as2'] as String,
      as3: json['as3'] as String,
    );
  }
}
