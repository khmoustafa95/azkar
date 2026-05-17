const String imagePath = "assets/images";
const String iconPath = "assets/icon";
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

  /// Front face of the printed Hajj card (branding + partner logos).
  static const String frontCard = "$imagePath/front_card.png";

  /// Back face of the printed Hajj card (hotel info, leader, address).
  static const String backCard = "$imagePath/back_card.png";
}

/// App launcher / branding icons under [iconPath].
class IconAssets {
  static const String appIcon = "$iconPath/icon.png";
  static const String mawasemLogo = "$iconPath/mawasem_logo.png";

  static const String icon1 = "$iconPath/icon1.png";
  static const String icon2 = "$iconPath/icon2.png";
  static const String icon3 = "$iconPath/icon3.png";
  static const String icon4 = "$iconPath/icon4.png";
  static const String icon5 = "$iconPath/icon5.png";
  static const String icon6 = "$iconPath/icon6.png";
  static const String icon7 = "$iconPath/icon7.png";
  static const String icon8 = "$iconPath/icon8.png";
  static const String icon9 = "$iconPath/icon9.png";
  static const String icon10 = "$iconPath/icon10.png";
  static const String icon11 = "$iconPath/icon11.png";
  static const String icon12 = "$iconPath/icon12.png";
  static const String icon13 = "$iconPath/icon13.png";
  static const String icon14 = "$iconPath/icon14.png";
  static const String icon15 = "$iconPath/icon15.png";
  static const String icon16 = "$iconPath/icon16.png";
  static const String doknow = "$iconPath/do_know.png";
  static const String duaaText = "$iconPath/duaa_text.png";
  static const String steps = "$iconPath/steps.png";
  static const String manask = "$iconPath/manask.png";
  static const String mareiat = "$iconPath/mareiat.png";
  static const String quran = "$iconPath/quran.png";
  static const String duaaVoice = "$iconPath/duaa_voice.png";
  static const String duaa = "$iconPath/duaa1.png";

  // /// Home grid tiles in [DuaaViewBody] (زاد المناسك).
  // static const String tileQuran = quran;
  // static const String tileHajjTracker = steps;
  // static const String tileFiqhHajj = mareiat;
  // static const String tileAdiya = duaaVoice;
  // static const String tileFiqhMessages = duaaText;
  // static const String tilePilgrimAdvice = doknow;

  static const List<String> all = [
    appIcon,
    mawasemLogo,
    doknow,
    duaaText,
    steps,
    manask,
    mareiat,
    quran,
    duaaVoice,
    duaa,
    icon1,
    icon2,
    icon3,
    icon4,
    icon5,
    icon6,
    icon7,
    icon8,
    icon9,
    icon10,
    icon11,
    icon12,
    icon13,
    icon14,
    icon15,
    icon16,
  ];
}

class JsonAssets {
  static const String homeAvatar = "$jsonPath/home_avatar.json";
  static const String salahAvatar = "$jsonPath/salah.json";
}

const String videosAssetPath = "assets/videos";

class VideoAssets {
  VideoAssets._();

  /// Introductory "who we are" coalition video shown on the Contact page.
  static const String whoWeAre = "$videosAssetPath/who_we_are.mp4";
}

/// Madinah mushaf page raster images (`1.png` … `604.png`) under [quranData].
class QuranMushafPageAssets {
  QuranMushafPageAssets._();

  /// Single page path, [page] in `1…604`.
  static String pathForPage(int page) {
    assert(page >= 1 && page <= 604, 'Mushaf page must be 1–604');
    return '$quranData$page.png';
  }

  /// All 604 asset paths — built once, unmodifiable (avoid rebuilding in cubit).
  static final List<String> allPaths = List<String>.unmodifiable(
    List.generate(604, (i) => '$quranData${i + 1}.png'),
  );
}

const String membersAssetPath = "assets/members";
const String groupsAssetPath = "assets/groups";
const String groupsSvgAssetPath = "assets/groups/svg";

/// Administrative instruction images (Hajj coalition slides).
const String adminInstructionsAssetPath = "assets/admin_instructions";

/// Administrative advice images (numbered advice cards).
const String adminAdvicesAssetPath = "assets/admin_advices";

/// Audio duas for Hajj & Umrah (`assets/sound_prayers/*.mp3`).
const String soundPrayersAssetPath = "assets/sound_prayers";

/// Text dua cards as WebP images (`assets/text_prayers/1.webp` … `10.webp`).
const String textPrayersAssetPath = "assets/text_prayers";

/// «مع الحاج» educational videos (`with_hajj1.mp4` … `with_hajj41.mp4`).
const String withHajjAssetPath = "assets/with_hajj";

/// «هل تعلم» short videos (`do_you_know1.mp4` … `do_you_know11.mp4`).
const String doYouKnowAssetPath = "assets/do_you_know";

/// Fiqh of Hajj — part 2 videos (`figh_hajj13.mp4` … `figh_hajj19.mp4`).
const String fighHajj2AssetPath = "assets/figh_hajj2";

/// Fiqh of Hajj — part 1 videos (`figh_hajj1.mp4` … `figh_hajj12.mp4`).
const String fiqhHajj1AssetPath = "assets/fiqh_hajj1";

/// Typed paths for MP3 files under [soundPrayersAssetPath].
class SoundPrayerAudioAssets {
  SoundPrayerAudioAssets._();

  static const String _b = soundPrayersAssetPath;

  static const String leavingHomeDua = "$_b/leaving_home_dua.mp3";
  static const String travel = "$_b/travel.mp3";
  static const String enterMasjed = "$_b/enter_masjed.mp3";
  static const String seeKaabeh = "$_b/see_kaabeh.mp3";
  static const String ihramTalbia = "$_b/ihram_talbia.mp3";
  static const String startTawaf = "$_b/start_tawaf.mp3";
  static const String startHejjer = "$_b/start_hejjer.mp3";
  static const String raknYamani = "$_b/rakn_yamani.mp3";
  static const String mailain = "$_b/mailain.mp3";
  static const String drinkZamzam = "$_b/drink_zamzam.mp3";
  static const String tawaf1Dua = "$_b/tawaf1_dua.mp3";
  static const String tawaf2Dua = "$_b/tawaf2_dua.mp3";
  static const String tawaf3Dua = "$_b/tawaf3_dua.mp3";
  static const String safaMarwa = "$_b/safa_marwa.mp3";
  static const String saai1Dua = "$_b/saai1_dua.mp3";
  static const String saai2Dua = "$_b/saai2_dua.mp3";
  static const String saai3Dua = "$_b/saai3_dua.mp3";
  static const String tawafEfada = "$_b/tawaf_efada.mp3";
  static const String tarwia = "$_b/tarwia.mp3";
  static const String walkingArafa = "$_b/walking_arafa.mp3";
  static const String yaumArafa = "$_b/yaum_arafa.mp3";
  static const String yaumArafa1 = "$_b/yaum_arafa1.mp3";
  static const String arafa1Dua = "$_b/arafa1_dua.mp3";
  static const String arafa2Dua = "$_b/arafa2_dua.mp3";
  static const String selected1Dua = "$_b/selected1_dua.mp3";
  static const String selected2Dua = "$_b/selected2_dua.mp3";

  static List<String> get bundledPaths => [
        leavingHomeDua,
        travel,
        enterMasjed,
        seeKaabeh,
        ihramTalbia,
        startTawaf,
        startHejjer,
        raknYamani,
        mailain,
        drinkZamzam,
        tawaf1Dua,
        tawaf2Dua,
        tawaf3Dua,
        safaMarwa,
        saai1Dua,
        saai2Dua,
        saai3Dua,
        tawafEfada,
        tarwia,
        walkingArafa,
        yaumArafa,
        yaumArafa1,
        arafa1Dua,
        arafa2Dua,
        selected1Dua,
        selected2Dua,
      ];
}

/// Text dua WebP cards under [textPrayersAssetPath] (`1.webp` … `10.webp`).
class TextPrayerImageAssets {
  TextPrayerImageAssets._();

  static String pathForPage(int page) {
    assert(page >= 1 && page <= 10, 'Text prayer page must be 1–10');
    return '$textPrayersAssetPath/$page.webp';
  }

  static final List<String> bundledPaths = List<String>.unmodifiable(
    List.generate(10, (i) => pathForPage(i + 1)),
  );
}

/// «مع الحاج» videos under [withHajjAssetPath] (`with_hajj1.mp4` … `with_hajj41.mp4`).
class WithHajjVideoAssets {
  WithHajjVideoAssets._();

  static String pathForIndex(int index) {
    assert(index >= 1 && index <= 41, 'With-hajj video index must be 1–41');
    return '$withHajjAssetPath/with_hajj$index.mp4';
  }

  static final List<String> bundledPaths = List<String>.unmodifiable(
    List.generate(41, (i) => pathForIndex(i + 1)),
  );
}

/// «هل تعلم» videos under [doYouKnowAssetPath].
class DoYouKnowVideoAssets {
  DoYouKnowVideoAssets._();

  static String pathForIndex(int index) {
    assert(index >= 1 && index <= 11, 'Do-you-know video index must be 1–11');
    return '$doYouKnowAssetPath/do_you_know$index.mp4';
  }

  static final List<String> bundledPaths = List<String>.unmodifiable(
    List.generate(11, (i) => pathForIndex(i + 1)),
  );
}

/// Fiqh of Hajj part 2 — disk filenames use `figh_hajj13` … `figh_hajj19`.
class FighHajj2VideoAssets {
  FighHajj2VideoAssets._();

  static const List<int> indices = [13, 14, 15, 16, 17, 18, 19];

  static String pathForIndex(int index) {
    assert(indices.contains(index), 'Fiqh hajj2 index must be 13–19');
    return '$fighHajj2AssetPath/figh_hajj$index.mp4';
  }

  static final List<String> bundledPaths = List<String>.unmodifiable(
    indices.map(pathForIndex).toList(growable: false),
  );
}

/// Fiqh of Hajj part 1 — disk filenames use `figh_hajj1` … `figh_hajj12`.
class FiqhHajj1VideoAssets {
  FiqhHajj1VideoAssets._();

  static String pathForIndex(int index) {
    assert(index >= 1 && index <= 12, 'Fiqh hajj1 index must be 1–12');
    return '$fiqhHajj1AssetPath/figh_hajj$index.mp4';
  }

  static final List<String> bundledPaths = List<String>.unmodifiable(
    List.generate(12, (i) => pathForIndex(i + 1)),
  );
}

/// Typed paths for files under [adminInstructionsAssetPath].
///
/// Filenames match the assets on disk exactly (including spelling such as
/// `resturant.jpeg` and `mousque.jpeg`).
class AdminInstructionImageAssets {
  AdminInstructionImageAssets._();

  static const String _b = adminInstructionsAssetPath;

  static const String beforeTravel = "$_b/before_travel.jpeg";
  static const String airport = "$_b/airport.jpeg";
  static const String arrivingAirport = "$_b/arriving_airport.jpeg";
  static const String arrivingHotel = "$_b/arriving_hotel.jpeg";
  static const String insidePlane = "$_b/inside_plane.jpeg";

  /// Disk filename is `resturant.jpeg`.
  static const String restaurant = "$_b/resturant.jpeg";

  /// Disk filename is `mousque.jpeg`.
  static const String mosque = "$_b/mousque.jpeg";
  static const String washing = "$_b/washing.jpeg";
  static const String arafatCamp = "$_b/arafat_camp.jpeg";
  static const String walking = "$_b/walking.jpeg";
  static const String loss = "$_b/loss.jpeg";
  static const String backMadinah = "$_b/back_madinah.jpeg";
  static const String leavingMakkah = "$_b/leaving_makkah.jpeg";
  static const String elevator = "$_b/elevator.jpeg";
  static const String drugs = "$_b/drugs.jpeg";
  static const String contentBug = "$_b/content_bug.jpeg";
  static const String generalAdvice = "$_b/general_advice.jpg";

  static List<String> get bundledPaths => [
        beforeTravel,
        airport,
        arrivingAirport,
        arrivingHotel,
        insidePlane,
        restaurant,
        mosque,
        washing,
        arafatCamp,
        walking,
        loss,
        backMadinah,
        leavingMakkah,
        elevator,
        drugs,
        contentBug,
        generalAdvice,
      ];
}

/// Typed paths for files under [adminAdvicesAssetPath] (`advice1.jpeg` … `advice15.jpeg`).
class AdminAdviceImageAssets {
  AdminAdviceImageAssets._();

  static const String _b = adminAdvicesAssetPath;

  static const String advice1 = "$_b/advice1.jpeg";
  static const String advice2 = "$_b/advice2.jpeg";
  static const String advice3 = "$_b/advice3.jpeg";
  static const String advice4 = "$_b/advice4.jpeg";
  static const String advice5 = "$_b/advice5.jpeg";
  static const String advice6 = "$_b/advice6.jpeg";
  static const String advice7 = "$_b/advice7.jpeg";
  static const String advice8 = "$_b/advice8.jpeg";
  static const String advice9 = "$_b/advice9.jpeg";
  static const String advice10 = "$_b/advice10.jpeg";
  static const String advice11 = "$_b/advice11.jpeg";
  static const String advice12 = "$_b/advice12.jpeg";
  static const String advice13 = "$_b/advice13.jpeg";
  static const String advice14 = "$_b/advice14.jpeg";
  static const String advice15 = "$_b/advice15.jpeg";

  static List<String> get bundledPaths => [
        advice1,
        advice2,
        advice3,
        advice4,
        advice5,
        advice6,
        advice7,
        advice8,
        advice9,
        advice10,
        advice11,
        advice12,
        advice13,
        advice14,
        advice15,
      ];
}

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

  // ---------- Named member portraits (jpg) ----------

  // Al-Masi
  static const String almasiIbrahimBadran = "$_b/almasi_ibrahim_badran.jpg";
  static const String almasiKhaledOlabi = "$_b/almasi_khaled_olabi.jpg";
  static const String almasiMahmoudHaddad = "$_b/almasi_mahmoud_haddad.jpg";
  static const String almasiMahmoudHajji = "$_b/almasi_mahmoud_hajji.jpg";
  static const String almasiMohammadHannoura =
      "$_b/almasi_mohammad_hannoura.jpg";

  // Al-Nour
  static const String alnourAbdoulrahmanShabak =
      "$_b/alnour_abdoulrahman_shabak.jpg";
  static const String alnourAnasKhalaf = "$_b/alnour_anas_khalaf.jpg";
  static const String alnourMohammadAboud = "$_b/alnour_mohammad_aboud.jpg";
  static const String alnourOsamaMouri = "$_b/alnour_osama_mouri.jpg";

  // Azaem
  static const String azaemAbdulbasetZaleq = "$_b/azaem_abdulbaset_zaleq.jpg";
  static const String azaemAbdulrahmanHayani =
      "$_b/azaem_abdulrahman_hayani.jpg";

  // Enaya
  static const String enayaMohammadNader = "$_b/enaya_mohammad_nader.jpg";
  static const String enayaMohammadObaid = "$_b/enaya_mohammad_obaid.jpg";
  static const String enayaYasserKesheh = "$_b/enaya_yasser_kesheh.jpg";

  // Haram
  static const String haramAbdKurdi = "$_b/haram_abd_kurdi.jpg";
  static const String haramAdnanKurdi = "$_b/haram_adnan_kurdi.jpg";
  static const String haramHussamHout = "$_b/haram_hussam_hout.jpg";
  static const String haramKarimSawas = "$_b/haram_karim_sawas.jpg";

  // Ishraq
  static const String ishraqAliOthman = "$_b/ishraq_ali_othman.jpg";
  static const String ishraqAmmarAliso = "$_b/ishraq_ammar_aliso.jpg";
  static const String ishraqMohammadAkil = "$_b/ishraq_mohammad_akil.jpg";
  static const String ishraqMohammadIsmail = "$_b/ishraq_mohammad_ismail.jpg";

  // Maalem
  static const String maalemAbdulrahmanNadaf =
      "$_b/maalem_abdulrahman_nadaf.jpg";
  static const String maalemFaroukSaleh = "$_b/maalem_farouk_saleh.jpg";

  // Mawasem
  static const String mawasemMohammadHajji = "$_b/mawasem_mohammad_hajji.jpg";
  static const String mawasemOmarAbboud = "$_b/mawasem_omar_abboud.jpg";
  static const String mawasemSafaBahlwan = "$_b/mawasem_safa_bahlwan.jpg";

  // Nemaa
  static const String nemaaAbdoBadr = "$_b/nemaa_abdo_badr.jpg";
  static const String nemaaMohammadDerbala = "$_b/nemaa_mohammad_derbala.jpg";
  static const String nemaaMohannadHasan = "$_b/nemaa_mohannad_hasan.jpg";

  // Shaqrouq
  static const String shaqrouqAliAli = "$_b/shaqrouq_ali_ali.jpg";
  static const String shaqrouqMohammadShaqrouq =
      "$_b/shaqrouq_mohammad_shaqrouq.jpg";

  // Tahrir
  static const String tahrirHazemHaddad = "$_b/tahrir_hazem_haddad.jpg";
  static const String tahrirMohammadKhandakani =
      "$_b/tahrir_mohammad_khandakani.jpg";

  // Wais
  static const String waisAbdulhamidMahfouz = "$_b/wais_abdulhamid_mahfouz.jpg";
  static const String waisAbdulrahmanAzizi = "$_b/wais_abdulrahman_azizi.jpg";
  static const String waisAbdulrahmanDoukha = "$_b/wais_abdulrahman_doukha.jpg";
  static const String waisMohammadWais = "$_b/wais_mohammad_wais.jpg";

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
        // Named portraits
        almasiIbrahimBadran,
        almasiKhaledOlabi,
        almasiMahmoudHaddad,
        almasiMahmoudHajji,
        almasiMohammadHannoura,
        alnourAbdoulrahmanShabak,
        alnourAnasKhalaf,
        alnourMohammadAboud,
        alnourOsamaMouri,
        azaemAbdulbasetZaleq,
        azaemAbdulrahmanHayani,
        enayaMohammadNader,
        enayaMohammadObaid,
        enayaYasserKesheh,
        haramAbdKurdi,
        haramAdnanKurdi,
        haramHussamHout,
        haramKarimSawas,
        ishraqAliOthman,
        ishraqAmmarAliso,
        ishraqMohammadAkil,
        ishraqMohammadIsmail,
        maalemAbdulrahmanNadaf,
        maalemFaroukSaleh,
        mawasemMohammadHajji,
        mawasemOmarAbboud,
        mawasemSafaBahlwan,
        nemaaAbdoBadr,
        nemaaMohammadDerbala,
        nemaaMohannadHasan,
        shaqrouqAliAli,
        shaqrouqMohammadShaqrouq,
        tahrirHazemHaddad,
        tahrirMohammadKhandakani,
        waisAbdulhamidMahfouz,
        waisAbdulrahmanAzizi,
        waisAbdulrahmanDoukha,
        waisMohammadWais,
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

  /// No PNG logo exists for Haram; falls back to the SVG logo.
  /// See [GroupSvgAssets.haram].
  static const String haramLogo = GroupSvgAssets.haram;

  /// No dedicated cover photo for Haram; reuse the group leader's portrait.
  static const String haramPhoto = MemberImageAssets.haramAbdKurdi;

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
        haramPhoto,
      ];
}

/// Vector (SVG) group logos under [groupsSvgAssetPath].
///
/// Render these with `SvgPicture.asset(...)` from the `flutter_svg` package,
/// or use the [GroupLogoImage] helper widget which auto-detects `.svg`.
class GroupSvgAssets {
  GroupSvgAssets._();

  static const String _b = groupsSvgAssetPath;

  static const String almasi = "$_b/almasi_logo.svg";
  static const String azaem = "$_b/azaem_logo.svg";
  static const String enaya = "$_b/enaya_logo.svg";
  static const String haram = "$_b/haram_logo.svg";
  static const String ishraq = "$_b/ishraq_logo.svg";

  /// File on disk is `ma3alem_logo.svg`.
  static const String maalem = "$_b/ma3alem_logo.svg";
  static const String mawasem = "$_b/mawasem_logo.svg";
  static const String nema = "$_b/nema_logo.svg";

  /// File on disk is `nour_logo.svg` (the "Al-Nour" group).
  static const String alnour = "$_b/nour_logo.svg";
  static const String shaqrouq = "$_b/shaqrouq_logo.svg";
  static const String tahrir = "$_b/tahrir_logo.svg";
  static const String wais = "$_b/wais_logo.svg";

  /// All [GroupSvgAssets] paths — keep in sync when adding a new field above.
  static List<String> get bundledPaths => [
        almasi,
        azaem,
        enaya,
        haram,
        ishraq,
        maalem,
        mawasem,
        nema,
        alnour,
        shaqrouq,
        tahrir,
        wais,
      ];
}

/// Registered member + group raster paths (for tests / asset verification).
List<String> allBundledMemberAndGroupImagePaths() => [
      ...MemberImageAssets.bundledPaths,
      ...GroupImageAssets.bundledPaths,
    ];
