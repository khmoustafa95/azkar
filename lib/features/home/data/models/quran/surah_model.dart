class SurahModel {
  const SurahModel({
    required this.id,
    required this.name,
    required this.type,
    required this.ayatNumber,
    required this.pageNumber,
  });

  final int id;
  final String name;
  final String type;
  final int ayatNumber;
  final int pageNumber;

  factory SurahModel.fromJson(Map<String, dynamic> json) {
    return SurahModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      ayatNumber: (json['ayatNumber'] as num).toInt(),
      pageNumber: (json['pageNumber'] as num).toInt(),
    );
  }
}