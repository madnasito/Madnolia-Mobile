import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/enums/bloc_status.enum.dart';
import 'package:madnolia/enums/user-availability.enum.dart';
import 'package:madnolia/models/user/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/services/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _userService = UserService();
  
  UserBloc():super(const UserState()){

    on<GetInfo> (_loadInfo);

    on<UpdateData> (_updateData);

    on<UserEvent>((event, emit){
      

      if(event is UserLogOut){
        emit(
          state.copyWith(loadedUser: false, notifications: 0, platforms: [], username: "", name: "", email: "", id: "", image: "", thumb: "", availability: UserAvailability.everyone)
        );
      }

      if( event is UserUpdateImage){
        emit(
          state.copyWith(
            image: event.image,
            thumb: event.thumbImage
          )
        );
      }

      if(event is UserUpdateChatRoom) emit(state.copyWith(chatRoom: event.chatRoom));

      if(event is AddNotifications) emit(state.copyWith(notifications: event.value));

      if(event is RestoreNotifications) emit(state.copyWith(notifications: 0));

      if(event is UserUpdateAvailability) emit(state.copyWith(availability: event.availability));
    });
  }
  

  Future<void> _loadInfo(GetInfo event, Emitter<UserState> emit) async {

    final userApiData = await _userService.getUserInfo();

    final service = FlutterBackgroundService();

    service.invoke("update_username", {"username": userApiData.username});

    final User user = userApiData;
    emit(
      state.copyWith(
        loadedUser: true,
        name: user.name,
        email: user.email,
        id: user.id,
        image: user.image,
        thumb: user.thumb,
        platforms: user.platforms,
        username: user.username,
        availability: user.availability,
        notifications: user.notifications
      )
    );
  }

  void _updateData(UpdateData event, Emitter<UserState> emit) {
    emit(
      state.copyWith(
        loadedUser: true,
        name: event.user.name,
        email: event.user.email,
        id: event.user.id,
        image: event.user.image,
        thumb: event.user.thumb,
        platforms: event.user.platforms,
        username: event.user.username,
        availability: event.user.availability,
        notifications: event.user.notifications
      )
    );
  }

  void updateAvailability(UserAvailability event) => add(UserUpdateAvailability(availability: event));
  

  void updateImages(String thumbImage, String image){
    add(UserUpdateImage(thumbImage: thumbImage, image: image));
  }

  void updateChatRoom(String room) => add(UserUpdateChatRoom(chatRoom: room));

  void logOutUser() => add(UserLogOut());

  void updateNotifications(int value) => add(AddNotifications(value: value));

  void restoreNotifications() => add(RestoreNotifications());
  
}
