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
          img: user.img,
          thumbImg: user.thumbImg,
          platforms: user.platforms,
          username: user.username,
          acceptInvitations: user.acceptInvitations
        ));
      }

      if(event is UserLogOut){
        emit(
          state.copyWith(loadedUser: false)
        );
      }

      if( event is UserUpdateImg){
        emit(
          state.copyWith(
            img: event.img,
            thumbImg: event.thumbImg
          )
        );
      }

      if(event is UserUpdateChatRoom) emit(state.copyWith(chatRoom: event.chatRoom));
    });
  }
  

  void loadInfo(User user){
    add(UserLoadInfo(userModel: user));
  }

  void updateImages(String thumbImg, String img){
    add(UserUpdateImg(thumbImg: thumbImg, img: img));
  }

  void updateChatRoom(String room) => add(UserUpdateChatRoom(chatRoom: room));

  void logOutUser() => add(UserLogOut());
  
}
