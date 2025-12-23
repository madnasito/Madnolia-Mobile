part of 'friendships_bloc.dart';

class FriendshipsState extends Equatable {

  final bool hasReachedMax;
  final ListStatus status;
  final List<UserData> friendshipsUsers;

  const FriendshipsState({
    this.friendshipsUsers = const <UserData>[],
    this.hasReachedMax = false,
    this.status = ListStatus.initial,
  });

  FriendshipsState copyWith({
    bool? hasReachedMax,
    ListStatus? status,
    List<UserData>? friendshipsUsers
  }){
    return FriendshipsState(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      friendshipsUsers: friendshipsUsers ?? this.friendshipsUsers
    );
  }
  
  @override
  List<Object> get props => [hasReachedMax, status, friendshipsUsers];
}
