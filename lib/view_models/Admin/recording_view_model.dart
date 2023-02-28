import 'package:flutter/cupertino.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class RecordingViewModel with ChangeNotifier {
  bool loading = false;
  VlcPlayerController? vlcPlayer;
  RecordingViewModel() {
    startVideo();
  }

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  startVideo() async {
    setLoading(true);

    String myUrl = 'http://192.168.0.103:8080/video';
    vlcPlayer = VlcPlayerController.network(myUrl,
        autoPlay: true, options: VlcPlayerOptions());
    setLoading(false);
  }
}
