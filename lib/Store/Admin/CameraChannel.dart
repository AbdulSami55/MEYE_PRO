// // ignore_for_file: file_names, prefer_is_empty

// import 'package:live_streaming/Bloc/CameraDetailsBloc.dart';
// import 'package:velocity_x/velocity_x.dart';

// import '../store.dart';

// class CameraSearchMutation extends VxMutation<MyStore> {
//   final String query;

//   CameraSearchMutation(this.query);
//   @override
//   perform() {
//     if (query.length >= 1) {
//       store?.lstCamera = CameraDetailsBloc.lst
//           .where((element) =>
//               element.ip.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     } else {
//       store?.lstCamera = CameraDetailsBloc.lst;
//     }
//   }
// }

// class ChannelMutation extends VxMutation<MyStore> {
//   final String channel;

//   ChannelMutation(this.channel);
//   @override
//   perform() {
//     store!.channel = channel;
//   }
// }
