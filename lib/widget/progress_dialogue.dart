// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

ProgressDialog Progress_Dialogue(BuildContext context, String text) {
  ProgressDialog pd = ProgressDialog(context, isDismissible: false);
  pd.style(message: text);
  return pd;
}
