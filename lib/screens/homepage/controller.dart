import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';

class HomePageController extends Cubit<HomePageState> {
  HomePageController() : super(InitialState());

  static HomePageController get(context) => BlocProvider.of(context);
  bool isDoneLoad = false;
  List data = [];
  List docsId = [];

  getData() async {
    try {
      isDoneLoad = true;
      emit(LoadingHomeState());
      FirebaseFirestore.instance
          .collection('item')
          .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        for (var element in value.docs) {
          docsId.add(element.id);

          data.add(element);
        }

        isDoneLoad = false;
        emit(SuccessState());
      });
    } catch (e) {
      isDoneLoad = false;
      emit(FailedState());
    }
  }
}
