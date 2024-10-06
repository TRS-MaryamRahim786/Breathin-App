import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class TermsCubit extends Cubit<bool> {
  TermsCubit() : super(false);

  void toggleTerms() => emit(!state);
}
