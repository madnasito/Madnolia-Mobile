part of 'user_bloc.dart';

class UserState extends Equatable {
  final String name;
  final String email;
  final String username;
  final List<int> platforms;
  final String img;
  final String thumbImg;
  final String id;
  final bool loadedUser;

  const UserState({
  this.name = "",
  this.email = "",
  this.username = "",
  this.platforms = const [],
  this.img = "",
  this.thumbImg = "",
  this.id = "",
  this.loadedUser = false
  });

  UserState copyWith({
    String? name,
    String? email,
    String? username,
    List<int>? platforms,
    String? img,
    String? thumbImg,
    String? id,
    bool? loadedUser
  }) => UserState(
    name: name ?? this.name,
    email: email ?? this.email,
    username: username ?? this.username,
    platforms: platforms ?? this.platforms,
    img: img ?? this.img,
    thumbImg: thumbImg ?? this.thumbImg,
    id: id ?? this.id,
    loadedUser: loadedUser ?? this.loadedUser
  );
  
  @override
  List<Object> get props => [
    name, email, username, platforms, img, thumbImg, id, loadedUser
  ];
}
