import 'package:flutter/cupertino.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class LiveStreamViewModel with ChangeNotifier {
  bool loading = false;
  VlcPlayerController? _vlcPlayer;
  VlcPlayerController get vlcPlayer => _vlcPlayer!;
  LiveStreamViewModel() {
    startVideo();
  }

  setLoading(bool val) {
    loading = val;
    notifyListeners();
  }

  startVideo() async {
    setLoading(true);

    String myUrl = 'http://192.168.235.103:8080/video';
    _vlcPlayer = VlcPlayerController.network(myUrl,
        autoPlay: true, options: VlcPlayerOptions());
    setLoading(false);
  }
}
