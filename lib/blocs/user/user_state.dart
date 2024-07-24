part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool loadedUser;
  final String name;
  final String email;
  final String username;
  final List<int> platforms;
  final String img;
  final String thumbImg;
  final String id;
  final String acceptInvitations;
  final String chatRoom;

  const UserState({
  this.loadedUser = false,
  this.name = "",
  this.email = "",
  this.username = "",
  this.platforms = const [],
  this.img = "",
  this.thumbImg = "",
  this.id = "",
  this.acceptInvitations = "",
  this.chatRoom= "",
  });

  UserState copyWith({
    String? name,
    String? email,
    String? username,
    List<int>? platforms,
    String? img,
    String? thumbImg,
    String? id,
    bool? loadedUser,
    String? acceptInvitations,
    String? chatRoom
  }) => UserState(
    name: name ?? this.name,
    email: email ?? this.email,
    username: username ?? this.username,
    platforms: platforms ?? this.platforms,
    img: img ?? this.img,
    thumbImg: thumbImg ?? this.thumbImg,
    id: id ?? this.id,
    loadedUser: loadedUser ?? this.loadedUser,
    acceptInvitations: acceptInvitations ?? this.acceptInvitations,
    chatRoom: chatRoom ?? this.chatRoom
  );
  
  @override
  List<Object> get props => [
    name, email, username, platforms, img, thumbImg, id, loadedUser, acceptInvitations, chatRoom
  ];
}
