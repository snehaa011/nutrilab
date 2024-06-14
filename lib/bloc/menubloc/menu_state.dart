import 'package:nutrilab/models/menuitemmodel.dart';

abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuItemModel> menuItems;
  final List<MenuItemModel> likedItems;
  final List<MenuItemModel> cartItems;

  MenuLoaded(this.menuItems, this.likedItems, this.cartItems);
}

class MenuError extends MenuState {
  final String error;

  MenuError(this.error);
}
