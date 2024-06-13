import 'package:equatable/equatable.dart';

abstract class LikedItemEvent extends Equatable{
    @override
    List<Object> get props => [];
}

class PageInitializedEvent extends LikedItemEvent{

}

class CheckIflikedEvent extends LikedItemEvent{
  final String itemId;

  CheckIflikedEvent(this.itemId);
}

class LikeButtonToggledEvent extends LikedItemEvent{
    final String itemId;

    LikeButtonToggledEvent(this.itemId);
}

