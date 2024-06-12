import 'package:equatable/equatable.dart';

abstract class LikedItemState extends Equatable{}

class InitialState extends LikedItemState{
  @override
  List<Object> get props => [];
}

class LikedItemLoadingState extends LikedItemState{
  @override
  List<Object> get props => [];
}

class LikedItemLoadedState extends LikedItemState{
  final List<String> LikedItemList;

  LikedItemLoadedState({
    required this.LikedItemList
  });

  @override
  List<Object> get props => [LikedItemList];

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