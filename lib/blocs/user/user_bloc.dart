import 'package:Madnolia/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc():super(UserState()){

    on<UserEvent>((event, emit){
      if(event is UserLoadInfo){
        final User user = event.userModel;
        emit(state.copyWith(
          loadedUser: true,
          name: user.name,
          email: user.email,
          id: user.id,
          img: user.id,
          thumbImg: user.thumbImg,
          platforms: user.platforms
        ));
      }

      if(event is UserLogOut){
        emit(
          state.copyWith(loadedUser: false)
        );
      }
    });
  }
  

  void loadInfo(User user){
    add(UserLoadInfo(userModel: user));
  }

  void logOutUser() => add(UserLogOut());
  
}
