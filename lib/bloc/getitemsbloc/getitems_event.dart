import 'package:nutrilab/models/menuitemmodel.dart';

abstract class GetItemsEvent {
  final String userId;
  GetItemsEvent (this.userId);
}

class LoadItems extends GetItemsEvent {
  LoadItems(super.userId);
}

class SavedButtonToggled extends GetItemsEvent {
  final MenuItemModel fm;
  SavedButtonToggled (super.userId, this.fm);
}

class ItemAddedToCart extends GetItemsEvent {
  final MenuItemModel fm;
  ItemAddedToCart (super.userId, this.fm);
}

class ItemRemovedFromCart extends GetItemsEvent {
  final MenuItemModel fm;
  ItemRemovedFromCart (super.userId, this.fm);
}

class AllItemOfTypeRemovedFromCart extends GetItemsEvent {
  final MenuItemModel fm;
  AllItemOfTypeRemovedFromCart (super.userId, this.fm);
}

class SavedForLater extends GetItemsEvent {
  final MenuItemModel fm;
  SavedForLater (super.userId, this.fm);
}

