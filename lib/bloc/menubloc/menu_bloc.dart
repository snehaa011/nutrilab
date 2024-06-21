import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilab/bloc/menubloc/menu_event.dart';
import 'package:nutrilab/bloc/menubloc/menu_state.dart';
import 'package:nutrilab/models/menuitemmodel.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  
  MenuBloc() : super(MenuInitial()) {
    on<LoadMenuItems>(_onLoadMenuItems);
  }

  Future<void> _onLoadMenuItems(
      LoadMenuItems event, Emitter<MenuState> emit) async {
    emit(MenuLoading());

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('menuitems').get();
      List<MenuItemModel> menuItems = snapshot.docs.map(
        (doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          bool isLiked = event.likedItems.contains(doc.id);
          bool isInCart = event.cartItems.containsKey(doc.id);
          int qt = isInCart? (event.cartItems[doc.id]?? 0) : 0;

          MenuItemMapper mapper = MenuItemMapper();

          return mapper.fbToDisplayModel(data, doc.id, isLiked, isInCart, qt);
        },
      ).toList();

      List<MenuItemModel> likedMenuItems =
          menuItems.where((item) => item.isLiked).toList();

      List<MenuItemModel> cartMenuItems =
          menuItems.where((item) => item.isInCart).toList();

      emit(MenuLoaded(menuItems, likedMenuItems, cartMenuItems));
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }
}

class MenuItemMapper {
  MenuItemModel fbToDisplayModel(
      Map<String, dynamic> data, String id, bool isLiked, bool isInCart, int qt) {
    return MenuItemModel(
      name: data['Name'],
      des: data['Description'],
      img: data['Image'],
      ingr: data['Ingr'],
      type: data['Type'],
      cal: data['Calories'],
      price: data['Price'],
      itemId: id,
      isLiked: isLiked,
      isInCart: qt>0,
      qt: qt
    );
  }
}
