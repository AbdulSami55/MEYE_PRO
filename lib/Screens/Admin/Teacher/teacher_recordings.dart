// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:http/http.dart' as http;

// Image base64ToImage(String base64String) {
//   return Image.memory(
//     base64Decode(base64String),
//     gaplessPlayback: true,
//   );
// }


// class VideoPlay extends StatefulWidget {
//  const VideoPlay({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int frameCounter = 0;
//   int lastTime = DateTime.now().millisecondsSinceEpoch;
//   int fps = 0;

//   final fpsValueNotifier = ValueNotifier(0);

//   final pollingRate = 10; // time between requests in ms

//   bool _timeDifferenceBiggerThanSecond() {
//     return DateTime.now().millisecondsSinceEpoch - lastTime > 1000;
//   }

//   // Future<Image> _fetchVideoFrame() async {
//   //   final response = await http.get(Uri.parse(url));

//   //   if (_timeDifferenceBiggerThanSecond()) {
//   //     fpsValueNotifier.value = frameCounter;
//   //     lastTime = DateTime.now().millisecondsSinceEpoch;
//   //     frameCounter = 0;
//   //   } else {
//   //     frameCounter++;
//   //   }
//   //   return Image.memory(
//   //     response.bodyBytes,
//   //     gaplessPlayback: true,
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             StreamBuilder<FileResponse>(
//               stream: fileStream,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   FileInfo fileInfo = snapshot.data as FileInfo;
//                   return Image.file(fileInfo.file);
//                 } else if (snapshot.hasError) {
//                   return Text("${snapshot.error}");
//                 } else if (snapshot.connectionState == ConnectionState.done) {
//                   return const Text("Done");
//                 }
//                 return CircularProgressIndicator();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Stream<FileResponse> fileStream =
//       DefaultCacheManager().getFileStream('http://192.168.0.112:8000/video');
// }
