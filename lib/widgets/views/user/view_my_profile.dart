import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/blocs/edit_user_provider.dart';
import 'package:toast/toast.dart';

import 'package:madnolia/style/text_style.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../models/user/user_model.dart';
import '../../../services/user_service.dart';
import '../../atoms/media/atom_profile_picture.dart';
import '../../atoms/text_atoms/center_title_atom.dart';
import '../../organism/form/organism_edit_user_form.dart';
import '../../organism/organism_delete_account_button.dart';

class ViewMyProfile extends StatelessWidget {
  const ViewMyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = EditUserProvider.of(context);
    final userBloc = context.read<UserBloc>();
    ToastContext().init(context);
    bloc.changeImg(userBloc.state.image);

    return FutureBuilder(
      future: _loadInfo(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 10),
                CenterTitleAtom(
                  text: userBloc.state.name,
                  textStyle: neonTitleText,
                ),
                Container(
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color.fromARGB(181, 255, 255, 255)),
                  ),
                  child: 
                  AtomProfilePicture()                 
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: OrganismEditUserForm(),
                ),
                const SizedBox(height: 20),
                OrganismDeleteAccountButton()
              ],
            ),
          );
        } else {
          return const Center(
              heightFactor: 15, child: CircularProgressIndicator());
        }
      },
    );
  }

  Future _loadInfo(BuildContext context) async {
    final userInfo = await UserService().getUserInfo();

    if (!context.mounted) return;
    final userBloc = context.read<UserBloc>();

    userBloc.add(UpdateData(user: userFromJson(jsonEncode(userInfo))));

    return userInfo;
  }
}