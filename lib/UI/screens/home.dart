import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:sizer/sizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../bloc/mars_photo_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/route_constants.dart';


class Home extends StatelessWidget {
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    final locale=AppLocalizations.of(context)!;
    final textTheme=Theme.of(context).textTheme;

    context.read<MarsPhotoCubit>().getMarsPhoto(DateTime(2019,10,1));

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Text(locale.appHeader, style: textTheme.bodyMedium,),
            ),
            ListTile(
              title: Text(locale.settings,style: textTheme.bodySmall,),
              onTap: () => context.push(settingsRoute),
            )
          ],
        ),
      ),
      appBar: AppBar(title: Text(locale.appHeader, style: textTheme.bodyMedium,)),
      body: Column(
        children: [
          Container(
            height: 20.h,
            child: CupertinoDatePicker(
              onDateTimeChanged:(dateTime){
                selectedDate=dateTime;
            },
              initialDateTime: DateTime(2019,10,1),
              maximumYear: DateTime.now().year,
              minimumYear: 2012,
              mode: CupertinoDatePickerMode.date,
              dateOrder: DatePickerDateOrder.ymd,

            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          ElevatedButton(
            onPressed: (){
              context.read<MarsPhotoCubit>().getMarsPhoto(selectedDate);
            },
            child: Text(locale.getMarsPhoto, style: textTheme.bodyMedium,),

          ),
          SizedBox(
            height: 2.h,
          ),
          Expanded(
            child: BlocConsumer<MarsPhotoCubit,MarsPhotoState>(
              listener: (context,state){
                if (state is MarsPhotoInternetError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(locale.internetError, style: textTheme.bodyMedium,),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                } else if (state is MarsPhotoUnknownError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message, style: textTheme.bodyMedium,),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
              builder: (context,state){
                if (state is MarsPhotoLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is MarsPhotoNoDataError) {
                  return Center(child: Text(locale.noDataError, style: textTheme.bodyMedium,));
                } else if (state is MarsPhotoLoaded) {
                  return ListView.builder(

                    itemCount: state.marsPhotos.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        title: Text(state.marsPhotos[index].camera.fullName, style: textTheme.bodyMedium,),
                        subtitle: Text(state.marsPhotos[index].earthDate.toString(), style: textTheme.bodySmall,),
                        leading: CachedNetworkImage(
                          imageUrl: state.marsPhotos[index].imgSrc,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      );
                    },
                  );
                }
                return Center(child: Text(locale.noDataError, style: textTheme.bodyMedium,),);
              },
            ),
          ),
        ],
      )
    );
  }
}
