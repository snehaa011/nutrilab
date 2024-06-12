import 'package:equatable/equatable.dart';

abstract class LikedItemEvent extends Equatable{
    @override
    List<Object> get props => [];
}

class ItemLikedEvent extends LikedItemEvent{
    final String itemId;

    ItemLikedEvent(this.itemId);
}

class ItemUnlikedEvent extends LikedItemEvent{
    final String itemId;

    ItemUnlikedEvent(this.itemId);
}