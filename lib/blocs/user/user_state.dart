part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool loadedUser;
  final String name;
  final String email;
  final String username;
  final List<int> platforms;
  final String img;
  final String thumb;
  final String id;
  final int availability;
  final String chatRoom;

  const UserState({
  this.loadedUser = false,
  this.name = "",
  this.email = "",
  this.username = "",
  this.platforms = const [],
  this.img = "",
  this.thumb = "",
  this.id = "",
  this.availability = 1,
  this.chatRoom= "",
  });

  UserState copyWith({
    String? name,
    String? email,
    String? username,
    List<int>? platforms,
    String? img,
    String? thumb,
    String? id,
    bool? loadedUser,
    int? availability,
    String? chatRoom
  }) => UserState(
    name: name ?? this.name,
    email: email ?? this.email,
    username: username ?? this.username,
    platforms: platforms ?? this.platforms,
    img: img ?? this.img,
    thumb: thumb ?? this.thumb,
    id: id ?? this.id,
    loadedUser: loadedUser ?? this.loadedUser,
    availability: availability ?? this.availability,
    chatRoom: chatRoom ?? this.chatRoom
  );
  
  @override
  List<Object> get props => [
    name, email, username, platforms, img, thumb, id, loadedUser, availability, chatRoom
  ];
}
