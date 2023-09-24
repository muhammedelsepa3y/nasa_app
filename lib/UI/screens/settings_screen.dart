import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/constants.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Box settings = Hive.box(settingsBox);
    final locale=AppLocalizations.of(context)!;
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(locale.language,style: textTheme.bodyLarge,),
            trailing: ValueListenableBuilder(
              valueListenable: Hive.box(settingsBox).listenable(),
              builder: (context, box, _) {
                String language = settings.get(languageValue, defaultValue: "en");
                return DropdownButton(
                  value: language,
                  onChanged: (val) => settings.put(languageValue, val),
                  items: [
                    DropdownMenuItem(
                      value: "en",
                      child: Text("English"),
                    ),
                    DropdownMenuItem(
                      value: "ar",
                      child: Text("العربية"),
                    ),
                  ],
                );
              },
            ),


          ),
          ListTile(
            title: Text(locale.darkMode,style: textTheme.bodyLarge,),
            trailing: ValueListenableBuilder(
              valueListenable: Hive.box(settingsBox).listenable(),
              builder: (context, box, _) {
                bool darkMode = settings.get(darkModeValue, defaultValue: false);
                return Switch(
                  value: darkMode,
                  onChanged: (val) {
                    settings.put(darkModeValue, !darkMode);
                  },
                );
              },
            ),
          ),
          // ValueListenableBuilder(
          //   valueListenable: Hive.box(settingsBox).listenable(),
          //   builder: (context, box, _) {
          //     String language = settings.get(languageValue, defaultValue: "en");
          //     return Switch(
          //       value: language == "en",
          //       onChanged: (val) =>
          //           settings.put(languageValue, val ? "en" : "ar"),
          //     );
          //   },
          // ),
          // ValueListenableBuilder(
          //   valueListenable: Hive.box(settingsBox).listenable(),
          //   builder: (context, box, _) {
          //     bool darkMode = settings.get(darkModeValue, defaultValue: false);
          //     return Switch(
          //       value: darkMode,
          //       onChanged: (val) {
          //         settings.put(darkModeValue, !darkMode);
          //       },
          //     );
          //   },
          // ),

        ],
      ),
    );
  }
}
