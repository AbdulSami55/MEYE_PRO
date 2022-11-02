// ignore_for_file: non_constant_identifier_names, deprecated_member_use, unused_local_variable, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:live_streaming/Api/teacher_api.dart';
import 'package:live_streaming/Model/Teacher/Teacher.dart';
import 'package:live_streaming/Store/getimage.dart';
import 'package:live_streaming/Store/store.dart';
import 'package:live_streaming/widget/button.dart';
import 'package:live_streaming/widget/outlinedbutton.dart';
import 'package:live_streaming/widget/progress_indicator.dart';
import 'package:live_streaming/widget/snack_bar.dart';
import 'package:live_streaming/widget/textfield.dart';
import 'package:velocity_x/velocity_x.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _Name = TextEditingController();
    TextEditingController _Email = TextEditingController();
    TextEditingController _Password = TextEditingController();
    (VxState.store as MyStore).image = null;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text(
              'Sign Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    _getFromGallery();
                  },
                  child: Image(),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  controller: _Name,
                  labelText: "Name",
                  hintText: "Name",
                  ispassword: false,
                ),
                MyTextField(
                  controller: _Email,
                  labelText: "User ID",
                  hintText: "User ID",
                  ispassword: false,
                ),
                MyTextField(
                  controller: _Password,
                  labelText: "Password",
                  hintText: "Password",
                  ispassword: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                    onTap: () async {
                      if (_Email.text.isNotEmpty &&
                          _Password.text.isNotEmpty &&
                          _Name.text.isNotEmpty &&
                          (VxState.store as MyStore).image != null) {
                        try {
                          showLoaderDialog(context, 'Sign Up');
                          Uint8List img = (VxState.store as MyStore)
                              .image!
                              .readAsBytesSync();
                          TeacherData td = TeacherData(
                              tID: _Email.text,
                              tIMAGE: base64Encode(img),
                              tNAME: _Name.text,
                              tPASS: _Password.text);
                          TeacherApi tapi = TeacherApi();
                          String res = await tapi.post(td);

                          if (res == "okay") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snack_bar(
                                    "Account Registered Successfully", true));
                          } else if (res == "ae") {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snack_bar("Account Already Exists", false));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snack_bar("Something Went Wrong", false));
                          }
                          Navigator.pop(context);
                        } catch (e) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                              snack_bar("Something Went Wrong", false));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snack_bar("Fill All Fields", false));
                      }
                    },
                    child: MyButton(text: "Sign Up")),
                const SizedBox(
                  height: 15,
                ),
                Log_In(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  InkWell Log_In(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pop(
            context,
          );
        },
        child: MyOutlineButton(text: "Log In"));
  }

  VxBuilder<Object?> Image() {
    return VxBuilder(
        mutations: const {getimageMutation},
        builder: ((context, store, status) => Stack(
              children: [
                (VxState.store as MyStore).image == null
                    ? const CircleAvatar(
                        radius: 50,
                        child: Icon(
                          Icons.person,
                          size: 50,
                        ))
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(
                          (VxState.store as MyStore).image!,
                        ),
                      ),
                const Positioned(
                    bottom: 8,
                    child: Icon(
                      Icons.add_a_photo,
                      size: 30,
                    )),
              ],
            )));
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      getimageMutation(image: imageFile);
    }
  }
}
