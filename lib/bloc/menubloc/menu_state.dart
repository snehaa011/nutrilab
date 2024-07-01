import 'dart:io';

import 'package:nutrilab/buildmenu.dart';
import 'package:nutrilab/models/menuitemmodel.dart';

abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuLoaded extends MenuState {
  final List<MenuItemModel> menuItems;
  final List<MenuItemModel> likedItems;
  final List<MenuItemModel> cartItems;
  int totalPrice;
  
  MenuLoaded(this.menuItems, this.likedItems, this.cartItems, this.totalPrice);

  MenuLoaded copyWith(menuItems, likedItems, cartItems, totalPrice) {
    return MenuLoaded(menuItems, likedItems, cartItems, totalPrice);
  }
}

class MenuError extends MenuState {
  final String error;

  MenuError(this.error);
}
