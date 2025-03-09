import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:madnolia/models/chat_user_model.dart';

part 'match_users_state.dart';

class MatchUsersCubit extends Cubit<MatchUsersState> {
  MatchUsersCubit() : super(const MatchUsersState(users: []));

  void addUser(ChatUser user){
    List<ChatUser> usersNew = [];
    usersNew.add(user);
    usersNew.addAll(state.users);
    // users.add(id);
    emit(state.copyWith(users: usersNew));
  }

  void deleteUser(int index){
    List<ChatUser> users = state.users;
    users.removeAt(index);
    emit(state.copyWith(users: users));
  }

  void restore() => emit(state.copyWith(users: []));

  List<String> getUsersId () => state.users.map((user) => user.id).toList();
}
