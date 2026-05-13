/// One of the thirty parts (أجزاء) of the Quran in the Madinah mushaf layout.
class JuzhModel {
  const JuzhModel({
    required this.id,
    required this.name,
    required this.startPage,
    required this.endPage,
  });

  final int id;
  final String name;
  final int startPage;
  final int endPage;
}
