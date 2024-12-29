part of 'match_users_cubit.dart';

class MatchUsersState extends Equatable {

  final List<ChatUser> users;

  const MatchUsersState({ required this.users});

  MatchUsersState copyWith({
    List<ChatUser>? users
  }) => MatchUsersState(
    users: users ?? this.users
  );

  @override
  List<Object> get props => [users];
}