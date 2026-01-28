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

  UserBloc() : super(const UserState()) {
    on<GetInfo>(_loadInfo);

    on<UpdateData>(_updateData);

    on<UpdateAvailability>(_updateAvailability);

    on<UpdateImages>(_updateImages);

    on<UpdateChatRoom>(_updateChatRoom);

    on<UserLogOut>(_logOutUser);

    on<AddNotifications>(_updateNotifications);

    on<RestoreNotifications>(_restoreNotifications);
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
        notifications: user.notifications,
      ),
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
        notifications: event.user.notifications,
      ),
    );
  }

  void _updateAvailability(UpdateAvailability event, Emitter<UserState> emit) {
    emit(state.copyWith(availability: event.availability));
  }

  void _updateImages(UpdateImages event, Emitter<UserState> emit) {
    emit(state.copyWith(thumb: event.thumbImage, image: event.image));
  }

  void _updateChatRoom(UpdateChatRoom event, Emitter<UserState> emit) {
    emit(state.copyWith(chatRoom: event.chatRoom));
  }

  void _logOutUser(UserLogOut event, Emitter<UserState> emit) {
    emit(
      state.copyWith(
        loadedUser: false,
        notifications: 0,
        platforms: [],
        username: "",
        name: "",
        email: "",
        id: "",
        image: "",
        thumb: "",
        availability: UserAvailability.everyone,
        status: BlocStatus.initial,
      ),
    );
  }

  void _updateNotifications(AddNotifications event, Emitter<UserState> emit) {
    emit(state.copyWith(notifications: event.value));
  }

  void _restoreNotifications(
    RestoreNotifications event,
    Emitter<UserState> emit,
  ) {
    emit(state.copyWith(notifications: 0));
  }
}
