part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool loadedUser;
  final String name;
  final String email;
  final String username;
  final List<int> platforms;
  final String image;
  final String thumb;
  final String id;
  final UserAvailability availability;
  final String chatRoom;
  final BlocStatus status;

  const UserState({
    this.loadedUser = false,
    this.name = "",
    this.email = "",
    this.username = "",
    this.platforms = const [],
    this.image = "",
    this.thumb = "",
    this.id = "",
    this.availability = UserAvailability.everyone,
    this.chatRoom = "",
    this.status = BlocStatus.initial,
  });

  UserState copyWith({
    String? name,
    String? email,
    String? username,
    List<int>? platforms,
    String? image,
    String? thumb,
    String? id,
    bool? loadedUser,
    UserAvailability? availability,
    String? chatRoom,
    BlocStatus? status,
  }) => UserState(
    name: name ?? this.name,
    email: email ?? this.email,
    username: username ?? this.username,
    platforms: platforms ?? this.platforms,
    image: image ?? this.image,
    thumb: thumb ?? this.thumb,
    id: id ?? this.id,
    loadedUser: loadedUser ?? this.loadedUser,
    availability: availability ?? this.availability,
    chatRoom: chatRoom ?? this.chatRoom,
    status: status ?? this.status,
  );

  @override
  List<Object> get props => [
    name,
    email,
    username,
    platforms,
    image,
    thumb,
    id,
    loadedUser,
    availability,
    chatRoom,
    status,
  ];
}
