import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/enums/user-availability.enum.dart';
import 'package:madnolia/models/user/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc():super(const UserState()){

    on<UserEvent>((event, emit){
      if(event is UserLoadInfo){
        final User user = event.userModel;
        emit(state.copyWith(
          loadedUser: true,
          name: user.name,
          email: user.email,
          id: user.id,
          img: user.img,
          thumb: user.thumb,
          platforms: user.platforms,
          username: user.username,
          availability: user.availability
        ));
      }

      if(event is UserLogOut){
        emit(
          state.copyWith(loadedUser: false, notifications: 0, platforms: [], username: "", name: "", email: "", id: "", img: "", thumb: "", availability: UserAvailability.everyone)
        );
      }

      if( event is UserUpdateImg){
        emit(
          state.copyWith(
            img: event.img,
            thumb: event.thumbImg
          )
        );
      }

      if(event is UserUpdateChatRoom) emit(state.copyWith(chatRoom: event.chatRoom));

      if(event is AddNotifications) emit(state.copyWith(notifications: event.value));

      if(event is RestoreNotifications) emit(state.copyWith(notifications: 0));
    });
  }
  

  void loadInfo(User user){
    final service = FlutterBackgroundService();
    service.invoke("update_username", {"username": user.username});
    add(UserLoadInfo(userModel: user));
  }

  void updateImages(String thumbImg, String img){
    add(UserUpdateImg(thumbImg: thumbImg, img: img));
  }

  void updateChatRoom(String room) => add(UserUpdateChatRoom(chatRoom: room));

  void logOutUser() => add(UserLogOut());

  void updateNotifications(int value) => add(AddNotifications(value: value));

  void restoreNotifications() => add(RestoreNotifications());
  
}
