import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/platform_games/platform_games_bloc.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_form_button.dart';
import 'package:toast/toast.dart';

import 'package:madnolia/services/user_service.dart';
import 'package:madnolia/widgets/views/platforms_view.dart';

import '../../models/user/user_model.dart';

class UserPlatformsPage extends StatelessWidget {
  const UserPlatformsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();
    final platformsGamesBloc = context.watch<PlatformGamesBloc>();

    List<int> platforms = [];

    platforms.addAll(userBloc.state.platforms);

    ToastContext().init(context);

    bool updating = false;
    return SingleChildScrollView(
      child: Column(
        children: [
          PlatformsView(platforms: platforms),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FadeIn(
              delay: const Duration(seconds: 1),
              child: StatefulBuilder(
                builder:
                    (
                      BuildContext context,
                      void Function(void Function()) setState,
                    ) => MoleculeFormButton(
                      text: t.PROFILE.USER_PAGE.UPDATE,
                      color: Colors.transparent,
                      isLoading: updating,
                      onPressed: updating == false
                          ? () async {
                              try {
                                if (platforms.isEmpty) {
                                  Toast.show(
                                    t.FORM.VALIDATIONS.SELECT_PLATFORMS,
                                    gravity: 100,
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                    ),
                                    textStyle: const TextStyle(fontSize: 18),
                                    duration: 2,
                                  );
                                  return;
                                }
                                setState(() => updating = true);
                                final resp = await UserService()
                                    .updateUserPlatforms(
                                      platforms: {"platforms": platforms},
                                    );
                                if (resp.containsKey("error")) {
                                  Toast.show(
                                    t.PROFILE.USER_PAGE.ERRORS.ERROR_UPDATING,
                                    gravity: 100,
                                    border: Border.all(color: Colors.redAccent),
                                    textStyle: const TextStyle(fontSize: 18),
                                    duration: 3,
                                  );
                                } else {
                                  final User user = User.fromJson(resp);
                                  debugPrint(user.platforms.toString());
                                  userBloc.add(UpdateData(user: user));
                                  // platformsGamesBloc.add(
                                  //   LoadPlatforms(
                                  //     platforms: userBloc.state.platforms,
                                  //   ),
                                  // );
                                  platformsGamesBloc.add(
                                    RestorePlatformsGamesState(),
                                  );
                                  Toast.show(
                                    t.PROFILE.PLATFORMS_PAGE.SUCCESS,
                                    gravity: 100,
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                    ),
                                    textStyle: const TextStyle(fontSize: 18),
                                    duration: 3,
                                  );
                                }
                                setState(() => updating = true);
                              } catch (e) {
                                if (context.mounted) {
                                  showAlert(context, e.toString());
                                }
                              } finally {
                                setState(() => updating = false);
                              }
                            }
                          : null,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
