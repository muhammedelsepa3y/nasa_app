import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nasa_app/data/API/network_service.dart';
import 'package:nasa_app/utils/color_schemes.g.dart';
import 'package:nasa_app/utils/constants.dart';
import 'package:nasa_app/utils/custom_router.dart';
import 'package:sizer/sizer.dart';


import 'bloc/mars_photo_cubit.dart';
import 'utils/typography.dart';

void main() async {
  NetworkServices networkServices = NetworkServices();
  networkServices.getMarsPhoto(DateTime(2021, 9, 1));
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(settingsBox);
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MarsPhotoCubit>(
          create: (context) => MarsPhotoCubit(),
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: Hive.box(settingsBox).listenable(),
        builder: (context, box, _) {
          bool darkMode = box.get(darkModeValue, defaultValue: false);
          String language = box.get(languageValue, defaultValue: "en");
          return Sizer(
            builder:(context, orientation, deviceType){
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Nasa App',
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: Locale(language),
                themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
                theme: ThemeData(
                  colorScheme: lightColorScheme,
                  textTheme: textTheme,
                  useMaterial3: true,
                ),
                darkTheme: ThemeData(
                  colorScheme: darkColorScheme,
                  textTheme: textTheme,
                  useMaterial3: true,
                ),
                routerConfig: appRouter.router,
              );
            }
          );
        },
      ),
    );
  }
}
