import 'package:flutter/foundation.dart';

/// Group names aligned with [GroupModel.id] in `group_view_body.dart`.
@immutable
class CommunicationGroupOption {
  const CommunicationGroupOption({required this.id, required this.name});

  final int id;
  final String name;
}

/// Same order/labels as the groups carousel (for picker consistency).
const List<CommunicationGroupOption> kCommunicationGroupOptions = [
  CommunicationGroupOption(id: 0, name: 'تكتل الماسي'),
  CommunicationGroupOption(id: 1, name: 'مجموعة العناية'),
  CommunicationGroupOption(id: 2, name: 'مجموعة إشراق'),
  CommunicationGroupOption(id: 3, name: 'مجموعة نماء'),
  CommunicationGroupOption(id: 4, name: 'مجموعة مواسم'),
  CommunicationGroupOption(id: 5, name: 'مجموعة النور'),
  CommunicationGroupOption(id: 6, name: 'مجموعة عزائم'),
  CommunicationGroupOption(id: 7, name: 'مجموعة معالم'),
  CommunicationGroupOption(id: 8, name: 'مجموعة التحرير'),
  CommunicationGroupOption(id: 9, name: 'مجموعة الشقروق'),
  CommunicationGroupOption(id: 10, name: 'مجموعة ويس و ملا'),
  CommunicationGroupOption(id: 11, name: 'مجموعة الحرم الشريف'),
];
