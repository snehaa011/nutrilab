abstract class GetItemsState {}

class GetItemsInitial extends GetItemsState {}

class GetItemsLoading extends GetItemsState {}

class GetItemsLoaded extends GetItemsState {
  final List <String> likedItems;
  final Map <String, int> cartItems;
  String message;
 GetItemsLoaded(this.likedItems, this.cartItems, this.message);
}

class GetItemsError extends GetItemsState {
  final String error;

  GetItemsError(this.error);
}