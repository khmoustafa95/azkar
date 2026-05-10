/// Tab / section keys for [DuaaModel.category] (Hajj content groups).
abstract class DuaaContentCategory {
  DuaaContentCategory._();

  static const fiqhHajj = 'fiqh_hajj';
  static const audioDuas = 'audio_duas';
  static const fiqhMessages = 'fiqh_messages';
  static const pilgrimAdvice = 'pilgrim_advice';

  /// Older payloads without [category] map legacy [type] to a default tab.
  static String inferFromLegacyType(String type) =>
      type == 'audio' ? audioDuas : fiqhHajj;
}

class DuaaModel {
  final int id;
  final String name;
  final String url;
  final String type;
  /// Which main tab lists this item (see [DuaaContentCategory]).
  final String category;
  final List<DuaaModel>? subDuaas;

  DuaaModel({
    required this.id,
    required this.name,
    required this.type,
    required this.url,
    required this.category,
    this.subDuaas,
  });

  factory DuaaModel.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return DuaaModel(
      id: json['id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
      type: type,
      category: json['category'] as String? ??
          DuaaContentCategory.inferFromLegacyType(type),
      subDuaas: json['subDuaas'] != null
          ? (json['subDuaas'] as List)
              .map((e) => DuaaModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'type': type,
      'category': category,
      'subDuaas': subDuaas?.map((e) => e.toJson()).toList(),
    };
  }
}

// class DuaaModel {
//   final int id;
//   final String name;
//   final String url;
//
//   final String type;
//   final List<DuaaModel>? subDuaas;
//
//   DuaaModel(
//       {required this.id,
//       required this.name,
//       required this.type,
//       required this.url,
//       this.subDuaas});
// }
