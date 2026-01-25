import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/utils/get_availability_data.dart';
import 'package:madnolia/enums/user-availability.enum.dart';

import '../../utils/get_slang_translations.dart';

class MoleculeMenuAvatar extends StatelessWidget {
  final UserBloc userBloc;
  const MoleculeMenuAvatar({super.key, required this.userBloc});

  @override
  Widget build(BuildContext context) {
    final userAvailability = userBloc.state.availability;
    final backgroundService = FlutterBackgroundService();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            final scaffoldState = Scaffold.maybeOf(context);
            if (scaffoldState != null && scaffoldState.isDrawerOpen) {
              scaffoldState.closeDrawer();
            }
            GoRouter.of(context).pushReplacement("/me/edit");
          },
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(userBloc.state.image),
            minRadius: 40,
            maxRadius: 50,
            backgroundColor: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => GoRouter.of(context).pushReplacement("/me/edit"),
              child: Text(
                userBloc.state.name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<UserAvailability>(
                  value: userAvailability,
                  dropdownColor: Colors.black87,
                  borderRadius: BorderRadius.circular(15.0),
                  items: UserAvailability.values.map((
                    UserAvailability availability,
                  ) {
                    return DropdownMenuItem<UserAvailability>(
                      value: availability,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              getIconForAvailability(availability),
                              color: getColorForAvailability(availability),
                              size: 15,
                            ),
                            const SizedBox(width: 12),
                            Text(getAvailabilityTranslation(availability)),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  selectedItemBuilder: (BuildContext context) {
                    return UserAvailability.values.map<Widget>((
                      UserAvailability availability,
                    ) {
                      return Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              getIconForAvailability(availability),
                              color: getColorForAvailability(availability),
                              size: 15,
                            ),
                            const SizedBox(width: 12),
                            Text(getAvailabilityTranslation(availability)),
                          ],
                        ),
                      );
                    }).toList();
                  },
                  onChanged: (value) {
                    if (value == null) return;
                    backgroundService.invoke('update_availability', {
                      'availability': value.index,
                    });
                    userBloc.add(UpdateAvailability(availability: value));
                  },
                  isDense: true,
                  underline: Container(),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
