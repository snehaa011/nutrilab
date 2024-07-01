import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_event.dart';
import 'package:nutrilab/bloc/getitemsbloc/getitems_state.dart';

class GetItemsBloc extends Bloc<GetItemsEvent, GetItemsState> {
  final String userId;
  List<String> likedItems = [];
  Map<String, int> cartItems = {};
  late DocumentReference userRef;
  GetItemsBloc(this.userId) : super(GetItemsInitial()) {
    //Is it ok to pass user id in constructor of bloc instead of passing with each event?
    _initialize();

    on<LoadItems>(_onLoadItems);
    on<SavedButtonToggled>(_onSavedOrUnsaved);
    on<ItemAddedToCart>(_addItemToCart);
    on<ItemRemovedFromCart>(_removeFromCart);
    on<AllItemOfTypeRemovedFromCart>(_removeAll);
    on<SavedForLater>(_saveForLater);
  }

  Future<void> _initialize() async {
    userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;

    likedItems = List<String>.from(userData['likedItems'] ?? []);
    cartItems = Map<String, int>.from(userData['cartItems'] ?? []);
  }

  Future<void> _onLoadItems(
      LoadItems event, Emitter<GetItemsState> emit) async {
    emit(GetItemsLoading());
    _initialize();
    try {
      emit(GetItemsLoaded(likedItems, cartItems, ""));
    } catch (e) {
      emit(GetItemsError(e.toString()));
    }
  }

  Future<void> _onSavedOrUnsaved(
      SavedButtonToggled event, Emitter<GetItemsState> emit) async {
    emit(GetItemsLoading());

    try {
      // DocumentReference userRef =
      //     FirebaseFirestore.instance.collection('users').doc(event.userId);
      if (event.fm.isLiked) {
        // If item is already liked, remove it from the array
        await userRef.update({
          'liked': FieldValue.arrayRemove([event.fm.itemId])
        });
        event.fm.isLiked = false;
        likedItems.remove(event.fm.itemId);
        emit(GetItemsLoaded(likedItems, cartItems, "Item removed from liked!"));
      } else {
        await userRef.update({
          'liked': FieldValue.arrayUnion([event.fm.itemId])
        });
        event.fm.isLiked = true;
        likedItems.add(event.fm.itemId);
        emit(GetItemsLoaded(likedItems, cartItems, "Item added to liked!"));
      }
    } catch (e) {
      emit(GetItemsError(e.toString()));
    }
  }

  Future<void> _addItemToCart(
      ItemAddedToCart event, Emitter<GetItemsState> emit) async {
    emit(GetItemsLoading());
    // DocumentReference userRef =
    //     FirebaseFirestore.instance.collection('users').doc(event.userId);

    try {
      cartItems[event.fm.itemId] = (cartItems[event.fm.itemId] ?? 0) + 1;
      await userRef.update({'cart': cartItems});
      event.fm.qt = cartItems[event.fm.itemId] ?? 0;
      event.fm.isInCart = true;
      emit(GetItemsLoaded(likedItems, cartItems, "1 Item added to cart!"));
    } catch (e) {
      emit(GetItemsError(e.toString()));
    }
  }

  Future<void> _removeFromCart(
      ItemRemovedFromCart event, Emitter<GetItemsState> emit) async {
    emit(GetItemsLoading());
    // DocumentReference userRef =
    //     FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      cartItems[event.fm.itemId] = (cartItems[event.fm.itemId] ?? 1) - 1;
      await userRef.update({'cart': cartItems});
      event.fm.qt = cartItems[event.fm.itemId] ?? 0;
      event.fm.isInCart = event.fm.qt > 0;
      emit(GetItemsLoaded(likedItems, cartItems, "1 Item removed from cart!"));
    } catch (e) {
      emit(GetItemsError(e.toString()));
    }
  }

  Future<void> _removeAll(
      AllItemOfTypeRemovedFromCart event, Emitter<GetItemsState> emit) async {
    emit(GetItemsLoading());
    // DocumentReference userRef =
    //   FirebaseFirestore.instance.collection('users').doc(userId);

    try {
      cartItems[event.fm.itemId] = 0;
      await userRef.update({'cart': cartItems});
      event.fm.qt = 0;
      event.fm.isInCart = false;
      emit(GetItemsLoaded(likedItems, cartItems, "Item removed from cart!"));
    } catch (e) {
      emit(GetItemsError(e.toString()));
    }
  }

  Future<void> _saveForLater(
      SavedForLater event, Emitter<GetItemsState> emit) async {
    emit(GetItemsLoading());
    try {
      if (!event.fm.isLiked) {
        // If item is not liked, add it to the array
        await userRef.update({
          'liked': FieldValue.arrayUnion([event.fm.itemId])
        });
        event.fm.isLiked = true;
        likedItems.add(event.fm.itemId);
      }
      cartItems[event.fm.itemId] = 0;
      await userRef.update({'cart': cartItems});
      event.fm.qt = 0;
      event.fm.isInCart = false;
      emit(GetItemsLoaded(likedItems, cartItems, "Item saved for later!"));
    } catch (e) {
      emit(GetItemsError(e.toString()));
    }
  }
}
