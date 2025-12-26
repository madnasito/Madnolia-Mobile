part of 'friendships_bloc.dart';

class FriendshipsState extends Equatable {

  final bool hasReachedMax;
  final ListStatus status;
  final List<UserData> friendshipsUsers;
  final int page;

  const FriendshipsState({
    this.friendshipsUsers = const <UserData>[],
    this.hasReachedMax = false,
    this.status = ListStatus.initial,
    this.page = 1,
  });

  FriendshipsState copyWith({
    bool? hasReachedMax,
    ListStatus? status,
    List<UserData>? friendshipsUsers,
    int? page,
  }){
    return FriendshipsState(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      friendshipsUsers: friendshipsUsers ?? this.friendshipsUsers,
      page: page ?? this.page
    );
  }
  
  @override
  List<Object> get props => [hasReachedMax, status, friendshipsUsers, page];
}
