import 'dart:developer';

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
  /// ===============================   [ Text Editing Controller ]
  TextEditingController homeSearchBarController = TextEditingController();

  /// ===============================   [ Focus Node ]

  final FocusNode focusNode = FocusNode();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FirebaseAuthService authService;

  HomeBloc(this.authService) : super(HomeInitialState()) {
    /// =================== [ SIGN OUT EVENT ]
    on<HomeSignOutEvent>((event, emit) {
      authService.signOut();
      _navigateToLanguageScreen(event.context);

      /// ========================= [ Deleting User Session ]
      SharedPrefService.instance.setIsUserLogin(false);
    });
  }

  /// Getting Image path
  Future<String> getImageUrl(String filePath) async {
    /// Replace 'filePath' with the full path to your image in Firebase Storage
    String path = '';
    try {
      Reference ref = FirebaseStorage.instance.refFromURL(filePath);
      path = await ref.getDownloadURL();
    } catch (e) {
      log('Error occurred while getting getImageUrl: $e');
    }
    return path;
  }

  /// Audio Play/Stop method
  playAudio(String audioLink) async {
    if (_audioPlayer.state == PlayerState.playing) {
      _audioPlayer.stop();
    }
    String link = await getImageUrl(audioLink);
    _audioPlayer.play(UrlSource(link));
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }

  /// Navigate to Language Screen
  void _navigateToLanguageScreen(BuildContext context) {
    context.go(Routes.landing);
  }

  ///Not in User
  Future<void> _pauseAudio() async {
    await _audioPlayer.pause();
  }

  ///Not in User
  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
  }
}
