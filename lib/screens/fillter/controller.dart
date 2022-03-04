import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uritem/screens/fillter/states.dart';

class FillterController extends Cubit<FilterStates> {
  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  List hint = ["Day", "Month", "Year"];
  List fillterData = [];
  List fillterDataId = [];
  bool isfillter = false;

  FillterController() : super(InitialFilterState());
  static FillterController get(context) => BlocProvider.of(context);
  filter(data, dataId) {
    for (int i = 0; i < data.length; i++) {
      if (data[i]["day"].toString() == dayController.text &&
          data[i]["month"].toString() == monthController.text &&
          data[i]["year"].toString() == yearController.text) {
        fillterData.add(data[i]);

        fillterDataId.add(dataId[i]);
      }
      emit(ChangeFilterState());
      isfillter = true;
    }

    return;
  }
}
