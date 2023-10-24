import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/constants.dart';
import '../../utils/route_constants.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final locale=AppLocalizations.of(context)!;
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(locale.appHeader, style: textTheme.displayLarge,),
            ),
            ListTile(
              title: Text(locale.settings,style: textTheme.displayMedium,),
              onTap: () => context.push(settingsRoute),
            )
          ],
        ),
      ),
      appBar: AppBar(title: Text(locale.appHeader, style: textTheme.displayMedium,)),
      body: Center (
        child:Text(locale.appHeader, style: textTheme.bodyLarge,)
      )
    );
  }
}
