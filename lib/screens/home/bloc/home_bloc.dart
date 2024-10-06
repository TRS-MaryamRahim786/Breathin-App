import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:breathin_app/routes/routes.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../services/firebase/firebase_auth.dart';
import '../../../services/shared-pref/shared-pref-service.dart';
import '../model/item_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  TextEditingController homeSearchBarController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  AudioPlayer _audioPlayer = AudioPlayer();
  final FirebaseAuthService authService;

  HomeBloc(this.authService) : super(HomeInitialState()) {
    on<HomeSignOutEvent>((event, emit) {
      authService.signOut();

      _navigateTolanguageScreen(event.context);
      SharedPrefService.instance.setIsUserLogin(false);
    });
  }

  Future<String> getImageUrl(String filePath) async {
    // Replace 'filePath' with the full path to your image in Firebase Storage
    String path = '';
    try {
      Reference ref = FirebaseStorage.instance.refFromURL(filePath);
      path = await ref.getDownloadURL();
    } catch (e) {
      print('Error occurred: $e');
    }
    return path;
  }

  playAudio(String audioLink) async {
    if (_audioPlayer.state == PlayerState.playing) {
      _audioPlayer.stop();
    }
    String link = await getImageUrl(audioLink);
    _audioPlayer.play(UrlSource(link));
  }

  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }

  void _navigateTolanguageScreen(BuildContext context) {
    context.go(Routes.landing);
  }
}
