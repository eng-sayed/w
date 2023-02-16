import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/local/sharedpref.dart';

part 'start_totrial_state.dart';

class StartTotrialCubit extends Cubit<StartTotrialState> {
  StartTotrialCubit() : super(StartTotrialInitial());
  static StartTotrialCubit get(context) => BlocProvider.of(context);
  saveOnBording() {
    CacheHelper.saveData(key: "start", value: true);
  }
}
