import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_streaming/Model/Admin/user.dart';
import 'package:live_streaming/utilities/constants.dart';
import 'package:live_streaming/view_models/user_view_model.dart';
import 'package:live_streaming/widget/components/appbar.dart';
import 'package:provider/provider.dart';

import '../../../widget/mybutton.dart';
import '../../../widget/mytextfield.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController id = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();
    XFile? img;
    List<String> lstrole = ["Teacher", "Student"];
    List<DropdownMenuItem<String>> lstdropdown() {
      return lstrole
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e.toString()),
              ))
          .toList();
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          appbar("Add User"),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<UserViewModel>(
                          builder: (context, provider, child) {
                        return InkWell(
                          onTap: () async {
                            img = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (img != null) {
                              provider.addUserImage(File(img!.path));
                            }
                          },
                          child: Stack(
                            children: [
                              provider.file != null
                                  ? CircleAvatar(
                                      backgroundColor: backgroundColorDark,
                                      foregroundColor: backgroundColorLight,
                                      radius: 50,
                                      backgroundImage:
                                          FileImage(provider.file!),
                                    )
                                  : const CircleAvatar(
                                      backgroundColor: backgroundColorDark,
                                      foregroundColor: backgroundColorLight,
                                      radius: 50,
                                      backgroundImage: AssetImage(
                                          "assets/images/defaulticon.png"),
                                    ),
                              const Positioned(
                                  bottom: 4,
                                  right: 4,
                                  child: Icon(
                                    Icons.add_circle,
                                    color: containerColor,
                                  ))
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                  const Text(
                    "User Id",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  mytextfiled("assets/icons/emilicon.png", id, false),
                  const Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  textfiled("", name, false),
                  const Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  mytextfiled("assets/icons/pass.png", password, true),
                  const Text(
                    "Role",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<UserViewModel>(
                    builder: (context, provider, child) => Container(
                      color: containerColor,
                      child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade300, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade300, width: 2.0),
                            ),
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(
                              Icons.type_specimen,
                              color: primaryColor,
                            ),
                          ),
                          isExpanded: true,
                          value: provider.selectedrole,
                          items: lstdropdown(),
                          onChanged: (value) {
                            provider.changeSelectedRole(value!);
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  mybutton(() {
                    User u = User(
                        userID: id.text,
                        name: name.text,
                        password: password.text,
                        role: Provider.of<UserViewModel>(context, listen: false)
                            .selectedrole);
                    UserViewModel().insertUserdata(
                        u,
                        Provider.of<UserViewModel>(context, listen: false)
                            .file!);
                  }, "Submit", CupertinoIcons.arrow_right),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding textfiled(
      String img, TextEditingController controller, bool obsecure) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: TextFormField(
        obscureText: obsecure,
        controller: controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2.0),
          ),
          border: const OutlineInputBorder(),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(
              Icons.person,
              color: primaryColor,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
