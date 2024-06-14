import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrilab/bloc/menubloc/menu_event.dart';
import 'package:nutrilab/bloc/menubloc/menu_state.dart';
import 'package:nutrilab/models/menuitemmodel.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final String userId;

  MenuBloc(this.userId) : super(MenuInitial()) {
    on<LoadMenuItems>(_onLoadMenuItems);
  }

  Future<void> _onLoadMenuItems(
      LoadMenuItems event, Emitter<MenuState> emit) async {
    emit(MenuLoading());

    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      List<String> likedItems = List<String>.from(userData['likedItems'] ?? []);
      List<String> cartItems = List<String>.from(userData['cartItems'] ?? []);

      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('menuitems').get();
      List<MenuItemModel> menuItems = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        bool isLiked = likedItems.contains(doc.id);
        bool isInCart = cartItems.contains(doc.id);

        return MenuItemModel(
          name: data['Name'],
          des: data['Description'],
          img: data['Image'],
          ingr: data['Ingr'],
          type: data['Type'],
          cal: data['Calories'],
          price: data['Price'],
          itemId: doc.id,
          isLiked: isLiked,
          isInCart: isInCart,
        );
      }).toList();

      List<MenuItemModel> likedMenuItems = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        bool isLiked = likedItems.contains(doc.id);
        bool isInCart = cartItems.contains(doc.id);
        
        if (isLiked){
          return MenuItemModel(
          name: data['Name'],
          des: data['Description'],
          img: data['Image'],
          ingr: data['Ingr'],
          type: data['Type'],
          cal: data['Calories'],
          price: data['Price'],
          itemId: doc.id,
          isLiked: isLiked,
          isInCart: isInCart,
        );
        }
        return null;
      }).where((item) => item != null).cast<MenuItemModel>().toList();

      List<MenuItemModel> cartMenuItems = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        bool isLiked = likedItems.contains(doc.id);
        bool isInCart = cartItems.contains(doc.id);
        
        if (isInCart){
          return MenuItemModel(
          name: data['Name'],
          des: data['Description'],
          img: data['Image'],
          ingr: data['Ingr'],
          type: data['Type'],
          cal: data['Calories'],
          price: data['Price'],
          itemId: doc.id,
          isLiked: isLiked,
          isInCart: isInCart,
        );
        }
        return null;
      }).where((item) => item != null).cast<MenuItemModel>().toList();

      emit(MenuLoaded(menuItems, likedMenuItems, cartMenuItems));
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }
}
