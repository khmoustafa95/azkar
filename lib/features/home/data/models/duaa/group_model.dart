class GroupModel {
  final int id;
  final String name;
  final String officer;
  final String logo;
  final String photo;
  final String phone;
  final String? saPhone;
  final List<MemberModel> members;

  GroupModel(
      {required this.id,
      required this.name,
      required this.logo,
      required this.phone,
      required this.photo,
      required this.officer,
      required this.members,
      this.saPhone});

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      phone: json['phone'],
      photo: json['photo'],
      officer: json['officer'],
      members: List<MemberModel>.from(
          json['members'].map((x) => MemberModel.fromJson(x))),
      saPhone: json['saPhone']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'logo': logo,
        'phone': phone,
        'photo': photo,
        'officer': officer,
        'members':
            List<Map<String, dynamic>>.from(members.map((x) => x.toJson())),
        'saPhone': saPhone,
        };
}

class MemberModel {
  final int id;
  final String name;
  final String position;
  final String photo;
  final String syPhone;
  final String? trPhone;
  final String? saPhone;

  MemberModel(
      {required this.id,
      required this.name,
      required this.syPhone,
      this.trPhone,
      this.saPhone,
      required this.photo,
      required this.position});

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
      id: json['id'],
      name: json['name'],
      syPhone: json['syPhone'],
      trPhone: json['trPhone'],
      saPhone: json['saPhone'],
      photo: json['photo'],
      position: json['position']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'syPhone': syPhone,
        'trPhone': trPhone,
        'saPhone': saPhone,
        'photo': photo,
        'position': position,
      };
}
