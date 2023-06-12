import 'package:flutter/material.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Student/notification_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:live_streaming/widget/textcomponents/small_text.dart';
import 'package:provider/provider.dart';

import '../../view_models/signin_view_model.dart';

class StudentNotificationScreen extends StatelessWidget {
  const StudentNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<SignInViewModel>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          appbar(userProvider.user.name.toString(), isGreen: true),
          ui(context)
        ],
      ),
    );
  }

  Widget ui(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: primaryColor,
        child: Container(
          decoration: const BoxDecoration(
              color: backgroundColorLight,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0))),
          child: Consumer<StudentNotificationViewModel>(
              builder: ((context, provider, child) {
            if (provider.isloading) {
              return apploading(context);
            } else if (provider.userError != null) {
              return ErrorMessage(provider.userError!.message.toString());
            }
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: provider.lststudentNotification.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.green.shade100),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                  "${getuserimage}Teacher/${provider.lststudentNotification[index].image}"),
                            ),
                            title: text_medium(provider
                                .lststudentNotification[index].courseName),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: textSmall(
                                      "${provider.lststudentNotification[index].day} ${provider.lststudentNotification[index].date}"),
                                ),
                                textSmall(
                                    "${provider.lststudentNotification[index].startTime.split('.')[0]}-${provider.lststudentNotification[index].endTime.split('.')[0]}"),
                              ],
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {},
                              child: textSmall("Claim", color: containerColor),
                            ),
                          ),
                        ),
                      ),
                    ));
          })),
        ),
      ),
    );
  }
}
