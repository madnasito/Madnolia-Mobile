import 'package:flutter/material.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import 'package:madnolia/services/database/user_db.dart';
import 'package:madnolia/utils/user_db_util.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_connection_button.dart';

class UserProfilePage extends StatelessWidget {

  final String id;
  
  const UserProfilePage({super.key, required this.id});
  @override
  Widget build(BuildContext context) {

    return CustomScaffold(body: FutureBuilder(
        future: getUserDb(id),
        builder: (BuildContext context, AsyncSnapshot<UserDb> snapshot) {
          if(snapshot.hasData) {

            final SimpleUser user = simpleUserFromJson(snapshot.data!.toJson());
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  MoleculeProfileHeader(user: user,),
                  MoleculeConnectionButton(simpleUser: user),
                  // AtomPendingButton(),
                  MaterialButton(
                    onPressed: (){},
                    shape: StadiumBorder(),
                    child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.flag, color: Colors.red,),
                      Text('Report this user')],
                    )
                  )  
                ],
              ),
            );
          } else if(snapshot.hasError) {
            return Center(child: Text('Error loading User'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

}

class AtomUserPFP extends StatelessWidget {

  final String userThumb;
  const AtomUserPFP({super.key, required this.userThumb});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            userThumb,
          ),
        ),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[900]!, width: 2),
          ),
          child: Icon(Icons.circle, size: 12, color: Colors.white),
        ),
      ],
    );
  }
}


class MoleculeProfileHeader extends StatelessWidget {

  final SimpleUser user;
  const MoleculeProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          AtomUserPFP(userThumb: user.thumb,),
          SizedBox(height: 15),
          Text(
            user.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('@${user.username}', style: TextStyle(color: Colors.grey))
            ],
          )
        ],
      ),);
  }
}