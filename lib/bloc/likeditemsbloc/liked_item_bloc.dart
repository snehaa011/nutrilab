import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './liked_item_event.dart';
import './liked_item_states.dart';

class LikedItemBloc extends Bloc<LikedItemEvent, LikedItemState> {
  late List liked;
  late List<DocumentSnapshot> documents = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LikedItemBloc() : super(InitialState()) {
    on<PageInitializedEvent>(_onViewLoaded);

    on<CheckIflikedEvent>(_onCheckLiked);     //Don't know how this works!!!

    on<LikeButtonToggledEvent>(_onLikeButtonToggled);
  }

  Future<void> _onViewLoaded(
    PageInitializedEvent event,
    Emitter<LikedItemState> emit,
  ) async {
    emit(LikedItemLoadingState());
    User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      // Handle user not logged in
      return;
    }

    String? userId = currentUser.email;
    DocumentReference userRef =
        FirebaseFirestore.instance.collection('users').doc(userId);
    try {
      DocumentSnapshot userDoc = await userRef.get();
      liked = userDoc['liked'] ?? [];

      _getDocs();

      if (documents.isNotEmpty) {
        emit(LikedItemLoadedState(LikedItemList: documents));
      } else {
        emit(LikedItemEmptyState());
      }
    } catch (e) {
      emit(LikedItemFailureState(errorMessage: '$e'));
    }
  }

  Future<void> _getDocs() async {
    for (String docId in liked) {
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('menuitems')
          .doc(docId)
          .get();

      if (docSnapshot.exists) {
        documents.add(docSnapshot);
      }
    }
  }

  Future<void> _onCheckLiked(
      CheckIflikedEvent event, Emitter<LikedItemState> emit) async {
    try {
      if (liked.contains(event.itemId)) {
        emit(IsLikedState(isLiked: true));
      } else {
        emit(IsLikedState(isLiked: false));
      }
    } catch (e) {
      emit(LikedItemFailureState(errorMessage: '$e'));
    }
  }

  Future<void> _onLikeButtonToggled(
      LikeButtonToggledEvent event, Emitter<LikedItemState> emit) async {
    emit(LikedItemLoadingState());
    User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      // Handle user not logged in
      return;
    }
    try {
      String? userId = currentUser.email;
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      if (liked.contains(event.itemId)) {
        await userRef.update({
          'liked': FieldValue.arrayRemove([event.itemId])
        });
        emit(IsLikedState(isLiked: false));

        _getDocs();

        if (documents.isNotEmpty) {
          emit(LikedItemLoadedState(LikedItemList: documents));
        } else {
          emit(LikedItemEmptyState());
        }
      } else {
        await userRef.update({
          'liked': FieldValue.arrayUnion([event.itemId])
        });
        emit(IsLikedState(isLiked: true));

        _getDocs();

        if (documents.isNotEmpty) {
          emit(LikedItemLoadedState(LikedItemList: documents));
        } else {
          emit(LikedItemEmptyState());
        }
      }
    } catch (e) {
      emit(LikedItemFailureState(errorMessage: '$e'));
    }
  }
}




// QUESTIONSS::
// 1. CAN WE EMIT TWO states within one event?
// How to deal with isLiked state which has to be available for each food item in menu but comes from userdetails?