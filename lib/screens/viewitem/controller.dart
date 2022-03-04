import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';

class ViewItemController extends Cubit<ViewItemStates> {
  String title = "Title";
  String price = "Price \$";
  String desc =
      "Description Description Description Description Description Description Description Description Description Description Description Description Description Description Description ";
  String date = "Date";

  ViewItemController() : super(InitialViewItemState());

  static ViewItemController get(context) => BlocProvider.of(context);
}
