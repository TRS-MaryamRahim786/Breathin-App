part of 'language_bloc.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitialState extends LanguageState {}

final class LanguageUpdateState extends LanguageState {
  List<LanguageModel> updatedLanguages;
  LanguageUpdateState({required this.updatedLanguages});
}
