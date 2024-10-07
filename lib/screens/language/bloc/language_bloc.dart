import 'package:bloc/bloc.dart';
import 'package:breathin_app/screens/language/model/language_model.dart';
import 'package:breathin_app/utilities/helpers/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  /// ========================= [ Text Editing Controller ]
  TextEditingController languageController = TextEditingController();

  final FocusNode focusNode = FocusNode();
  List<LanguageModel> languages = [
    LanguageModel("English", AppAssets.englishFlagImage),
    LanguageModel("French", AppAssets.frenchFlagImage),
    LanguageModel("Spanish", AppAssets.spanishFlagImage),
  ];
  LanguageModel? selectedLanguage;

  LanguageBloc() : super(LanguageInitialState()) {
    on<LanguageInitialEvent>((event, emit) {
      selectedLanguage = event.defaultLanguage;
      emit(LanguageUpdateState(updatedLanguages: languages));
    });
    on<LanguageSearchEvent>((event, emit) {
      // Filter the list based on whether the name contains the search term (case-insensitive)
      var filteredLanguages = languages.where((language) {
        return language.name
            .toLowerCase()
            .contains(event.searchLanguage.toLowerCase());
      }).toList();
      // Emit the filtered list or handle it as needed
      emit(LanguageUpdateState(updatedLanguages: filteredLanguages));

      // TODO: implement event handler
    });

    on<LanguageSelectionEvent>((event, emit) {
      selectedLanguage = event.language;
      emit(LanguageUpdateState(updatedLanguages: languages));
    });

    on<LanguageResetEvent>((event, emit) {
      emit(LanguageUpdateState(updatedLanguages: languages));
    });
  }
}
