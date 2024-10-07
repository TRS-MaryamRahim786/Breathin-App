part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent {}

class LanguageInitialEvent extends LanguageEvent {
  final LanguageModel defaultLanguage;

  LanguageInitialEvent({required this.defaultLanguage});
}

class LanguageSearchEvent extends LanguageEvent {
  final String searchLanguage;

  LanguageSearchEvent({required this.searchLanguage});
}

class LanguageSelectionEvent extends LanguageEvent {
  final LanguageModel language;
  LanguageSelectionEvent({required this.language});
}

class LanguageResetEvent extends LanguageEvent {
  LanguageResetEvent();
}
