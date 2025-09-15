import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/utils/get_availability_data.dart';

class MoleculeMenuAvatar extends StatelessWidget {
  final UserBloc userBloc;
  const MoleculeMenuAvatar({super.key, required this.userBloc});

  @override
  Widget build(BuildContext context) {
    final userAvailability = userBloc.state.availability;
    return 
      GestureDetector(
        onTap: () => GoRouter.of(context).pushReplacement("/me/edit"),
        child: Row(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(userBloc.state.img),
              minRadius: 40,
              maxRadius: 50,
              backgroundColor: Colors.white,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Text(
                  userBloc.state.name,
                  style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(getIconForAvailability(userAvailability), color: getColorForAvailability(userAvailability), size: 15,),
                    Text(
                      translate("PROFILE.AVAILABILITY.${userAvailability.name.toUpperCase()}"),
                      style: const TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
    );
  }
}