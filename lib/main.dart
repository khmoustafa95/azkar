import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holly_quran/core/di/service_locator.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/app_routers.dart';
import 'package:holly_quran/core/resources/theme_manager.dart';
import 'package:holly_quran/features/home/data/repos/home_repo_impl.dart';

import 'features/home/presentation/view_models/duaa/duaa/duaa_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  await setupServiceLocator();
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const HajApp());
}

class HajApp extends StatelessWidget {
  const HajApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                DuaaCubit(getIt.get<HomeRepoImpl>())..fetchDuaa()),
      ],
      child: MaterialApp.router(
        title: AppConstants.appName,
        routerConfig: AppRouters.router,
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        builder: (context, child) {
          final mq = MediaQuery.of(context);
          return MediaQuery(
            data: mq.copyWith(
              textScaler: mq.textScaler.clamp(
                minScaleFactor: 0.9,
                maxScaleFactor: 1.2,
              ),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
