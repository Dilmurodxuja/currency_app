class CodeModel {
  CodeModel({
    required this.ccn3,
    required this.flag,
  });

  final String ccn3;
  final String flag;

  factory CodeModel.fromJson(Map<String, dynamic> json) => CodeModel(
    ccn3: json["ccn3"],
    flag: json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "ccn3": ccn3,
    "flag": flag,
  };
}