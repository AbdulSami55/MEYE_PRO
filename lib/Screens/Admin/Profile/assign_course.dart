import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/Admin/User/student_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:live_streaming/widget/components/apploading.dart';
import 'package:live_streaming/widget/components/errormessage.dart';
import 'package:live_streaming/widget/components/search_bar.dart';
import 'package:live_streaming/widget/textcomponents/medium_text.dart';
import 'package:provider/provider.dart';

class AssignCourse extends StatelessWidget {
  const AssignCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: RefreshIndicator(
        onRefresh: () => StudentViewModel().getData(),
        child: CustomScrollView(
          slivers: [
            appbar("Assign Course"),
            searchBar(isTeacher: false),
            SliverToBoxAdapter(
              child: ChangeNotifierProvider(
                create: (context) => StudentViewModel(),
                child: Consumer<StudentViewModel>(
                    builder: (context, provider, child) =>
                        _ui(context, provider)),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.assignment_turned_in_rounded),
      ),
    );
  }

  Widget _ui(BuildContext context, StudentViewModel provider) {
    if (provider.isloading) {
      return apploading();
    }
    if (provider.userError != null) {
      return ErrorMessage(provider.userError!.message.toString());
    }
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: provider.lstStudent.length,
        itemBuilder: (context, index) => Column(
              children: [studentView(provider, index), const Divider()],
            ));
  }

  ListTile studentView(StudentViewModel provider, int index) {
    return ListTile(
      leading: CircleAvatar(
          radius: 33,
          backgroundImage: NetworkImage(
              "$getstudentimage${provider.lstStudent[index].image}")),
      title: text_medium(provider.lstStudent[index].name.toString()),
      trailing: Builder(builder: (context) {
        return InkWell(
          onTap: () {
            provider.changeStudent(index);
          },
          child: context.watch<StudentViewModel>().lstStudent[index].isSelected!
              ? Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(99.0)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.done,
                      color: primaryColor,
                    ),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(99.0)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 14),
                      child: text_medium("X", color: Colors.red, font: 20)),
                ),
        );
      }),
    );
  }
}
