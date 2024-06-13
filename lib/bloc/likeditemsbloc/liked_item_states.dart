import 'package:equatable/equatable.dart';

abstract class LikedItemState extends Equatable{}

class InitialState extends LikedItemState{
  @override
  List<Object> get props => [];
}

class IsLikedState extends LikedItemState{
  final bool isLiked;
  IsLikedState ({required this.isLiked});

  @override
  List<Object?> get props => [isLiked];}

class LikedItemLoadingState extends LikedItemState{
  @override
  List<Object> get props => [];
}

class LikedItemLoadedState extends LikedItemState{
  final List<dynamic> LikedItemList;

  LikedItemLoadedState({
    required this.LikedItemList
  });

  @override
  List<Object> get props => [LikedItemList];

}

class LikedItemEmptyState extends LikedItemState{
  @override
  List<Object> get props => [];
}

class LikedItemFailureState extends LikedItemState {
  final String errorMessage;

  LikedItemFailureState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class NoInternetErrorState extends LikedItemState {
  @override
  List<Object> get props => [];
}