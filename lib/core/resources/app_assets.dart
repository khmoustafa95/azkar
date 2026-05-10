const String imagePath = "assets/images";
const String jsonPath = "assets/json";
const String quranData = "assets/quran_data/";

class ImageAssets {
  static const String background = "$imagePath/background.jpeg";
  static const String icon = "$imagePath/icon.jpg";
  static const String border = "$imagePath/border2.jpeg";
  static const String tasbih = "$imagePath/tasbih.png";
  static const String dua = "$imagePath/dua2.png";
  static const String sadqat = "$imagePath/sadqat.png";
  static const String salah = "$imagePath/salah.png";
  static const String quran = "$imagePath/quran.png";
  static const String home = "$imagePath/home.png";
  static const String arrow = "$imagePath/arrow.png";
  static const String azkarSabah = "$imagePath/azkarSabah.png";
  static const String azkarMasaa = "$imagePath/azkarMasaa.png";
  static const String hadith = "$imagePath/hadith.png";
  static const String hesnMuslim = "$imagePath/hesnMuslim.png";
  static const String tasbihCounter = "$imagePath/tasbihCounter.png";
  static const String star = "$imagePath/star.png";
  static const String quranStop = "$imagePath/quranStop.png";
  static const String sadaqatLogo = "$imagePath/sadaqatLogo.png";
  static const String werdLogo = "$imagePath/imam.png";
  static const String mosque = "$imagePath/mosque.png";
  static const String loading = "$imagePath/dua.png";
  static const String dayWheel = "$imagePath/infaq.png";
  static const String dayWheelBorder = "$imagePath/wheel-border.png";
  static const String dayWheelMark = "$imagePath/label.png";
  static const String generalIhdaa = "$imagePath/ihdaa_back2.jpeg";
  static const String ramadanIhdaa = "$imagePath/ihdaa_back.jpeg";
  static const String ihdaa = "$imagePath/moon.png";
  static const String agzaa = "$imagePath/agzaa.png";
  static const String settings = "$imagePath/settings.png";
  static const String about = "$imagePath/about.png";
  static const String rating = "$imagePath/rating.png";
  static const String share = "$imagePath/share.png";
  static const String werd = "$imagePath/werd.png";
}

class JsonAssets {
  static const String homeAvatar = "$jsonPath/home_avatar.json";
  static const String salahAvatar = "$jsonPath/salah.json";
}

const String membersAssetPath = "assets/members";
const String groupsAssetPath = "assets/groups";

/// Member headshots under [membersAssetPath]. Prefer these over raw paths
/// so typos are caught at compile time.
class MemberImageAssets {
  MemberImageAssets._();

  static const String _b = membersAssetPath;

  static const String almasi0 = "$_b/almasi0.png";
  static const String almasi1 = "$_b/almasi1.png";
  static const String almasi2 = "$_b/almasi2.png";
  static const String almasi3 = "$_b/almasi3.png";
  static const String almasi4 = "$_b/almasi4.png";
  static const String almasi5 = "$_b/almasi5.png";
  static const String almasi6 = "$_b/almasi6.png";
  static const String almasi7 = "$_b/almasi7.png";
  static const String almasi8 = "$_b/almasi8.png";

  static const String othman1 = "$_b/othman1.png";
  static const String othman2 = "$_b/othman2.png";
  static const String othman3 = "$_b/othman3.png";

  static const String tasnim1 = "$_b/tasnim1.png";
  static const String tasnim2 = "$_b/tasnim2.png";
  static const String tasnim3 = "$_b/tasnim3.png";

  static const String alnour1 = "$_b/alnour1.png";
  static const String alnour2 = "$_b/alnour2.png";
  static const String alnour3 = "$_b/alnour3.png";

  static const String rohama1 = "$_b/rohama1.png";
  static const String rohama2 = "$_b/rohama2.png";
  static const String rohama3 = "$_b/rohama3.png";

  static const String awn1 = "$_b/awn1.png";
  static const String awn2 = "$_b/awn2.png";
  static const String awn3 = "$_b/awn3.png";

  static const String dura1 = "$_b/dura1.png";
  static const String dura2 = "$_b/dura2.png";

  static const String enaya1 = "$_b/enaya1.png";
  static const String enaya2 = "$_b/enaya2.png";

  static const String nema1 = "$_b/nema1.png";
  static const String nema2 = "$_b/nema2.png";

  static const String ishraq1 = "$_b/ishraq1.png";
  static const String ishraq2 = "$_b/ishraq2.png";

  static const String mawasem1 = "$_b/mawasem1.png";
  static const String mawasem2 = "$_b/mawasem2.png";

  /// All [MemberImageAssets] paths — keep in sync when adding a new field above.
  /// Used by [allBundledMemberAndGroupImagePaths] and `tool/verify_assets.dart`.
  static List<String> get bundledPaths => [
        almasi0,
        almasi1,
        almasi2,
        almasi3,
        almasi4,
        almasi5,
        almasi6,
        almasi7,
        almasi8,
        othman1,
        othman2,
        othman3,
        tasnim1,
        tasnim2,
        tasnim3,
        alnour1,
        alnour2,
        alnour3,
        rohama1,
        rohama2,
        rohama3,
        awn1,
        awn2,
        awn3,
        dura1,
        dura2,
        enaya1,
        enaya2,
        nema1,
        nema2,
        ishraq1,
        ishraq2,
        mawasem1,
        mawasem2,
      ];
}

/// Group logos and cover photos under [groupsAssetPath].
class GroupImageAssets {
  GroupImageAssets._();

  static const String _b = groupsAssetPath;

  static const String almasiLogo = "$_b/almasi_logo.png";
  static const String almasiPhoto = "$_b/almasi_photo.png";

  static const String othmanLogo = "$_b/othman_logo.png";
  static const String othmanPhoto = "$_b/othman_photo.png";

  static const String tasnimLogo = "$_b/tasnim_logo.png";
  static const String tasnimPhoto = "$_b/tasnim_photo.png";

  static const String awnLogo = "$_b/awn_logo.png";
  static const String awnPhoto = "$_b/awn_photo.png";

  static const String alnourLogo = "$_b/alnour_logo.png";
  static const String alnourPhoto = "$_b/alnour_photo.png";

  static const String rohamaLogo = "$_b/rohama_logo.png";
  static const String rohamaPhoto = "$_b/rohama_photo.png";

  static const String nemaLogo = "$_b/nema_logo.png";
  static const String nemaPhoto = "$_b/nema_photo.png";

  /// File on disk is `mawasm_logo.png` (see `assets/groups/`).
  static const String mawasemLogo = "$_b/mawasm_logo.png";
  static const String mawasemPhoto = "$_b/mawasem_photo.png";

  static const String enayaLogo = "$_b/enaya_logo.png";
  static const String enayaPhoto = "$_b/enaya_photo.png";

  static const String duraLogo = "$_b/dura_logo.png";
  static const String duraPhoto = "$_b/dura_photo.png";

  static const String ishraqLogo = "$_b/ishraq_logo.png";
  static const String ishraqPhoto = "$_b/ishraq_photo.png";

  /// All [GroupImageAssets] paths — keep in sync when adding a new field above.
  static List<String> get bundledPaths => [
        almasiLogo,
        almasiPhoto,
        othmanLogo,
        othmanPhoto,
        tasnimLogo,
        tasnimPhoto,
        awnLogo,
        awnPhoto,
        alnourLogo,
        alnourPhoto,
        rohamaLogo,
        rohamaPhoto,
        nemaLogo,
        nemaPhoto,
        mawasemLogo,
        mawasemPhoto,
        enayaLogo,
        enayaPhoto,
        duraLogo,
        duraPhoto,
        ishraqLogo,
        ishraqPhoto,
      ];
}

/// Registered member + group raster paths (for tests / asset verification).
List<String> allBundledMemberAndGroupImagePaths() => [
      ...MemberImageAssets.bundledPaths,
      ...GroupImageAssets.bundledPaths,
    ];
