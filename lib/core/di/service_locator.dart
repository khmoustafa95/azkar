import 'package:get_it/get_it.dart';
import 'package:holly_quran/core/shared_preferences/app_preferences.dart';
import 'package:holly_quran/features/home/data/repos/home_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerLazySingleton<AppPreferences>(() => AppPreferences(getIt()));
  getIt.registerLazySingleton<HomeRepoImpl>(() => HomeRepoImpl());
}
