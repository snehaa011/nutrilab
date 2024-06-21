abstract class MenuEvent {
  final List <String> likedItems;
  final Map <String, int> cartItems;
  MenuEvent(this.likedItems, this.cartItems);
}

class LoadMenuItems extends MenuEvent {
  LoadMenuItems(super.likedItems, super.cartItems);
}
