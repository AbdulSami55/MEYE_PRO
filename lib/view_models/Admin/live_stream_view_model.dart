// ignore_for_file: prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class LiveStreamViewModel with ChangeNotifier {
  bool loading = false;
  List<VlcPlayerController> _vlcPlayer = <VlcPlayerController>[];
  List<VlcPlayerController> get vlcPlayer => _vlcPlayer;
  int selectedVideo = 0;
  LiveStreamViewModel() {
    startVideo();
  }

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  startVideo() async {
    setLoading(true);

    String myUrl = 'http://192.168.43.26:8080/video';
    VlcPlayerController vlcPlayerController = VlcPlayerController.network(myUrl,
        autoPlay: true, options: VlcPlayerOptions());
    _vlcPlayer.add(vlcPlayerController);
    myUrl = 'http://192.168.43.1:8080/video';
    vlcPlayerController = VlcPlayerController.network(myUrl,
        autoPlay: true, options: VlcPlayerOptions());
    _vlcPlayer.add(vlcPlayerController);

    setLoading(false);
  }
}
