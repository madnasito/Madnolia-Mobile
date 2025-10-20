import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/atom_styled_text.dart';
import 'package:madnolia/widgets/molecules/modal/molecule_modal_icon_button.dart';


class OrganismMatchInfoModal extends StatelessWidget {

  final MatchData match;
  final String userId;

  const OrganismMatchInfoModal({super.key, required this.match, required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: RepositoryManager().user.getUserById(userId),
      builder: (context, AsyncSnapshot<UserData> snapshot) {

        if(snapshot.hasData) {
          final user = snapshot.data!;
          return MoleculeModalIconButton(content: Column(
        
            children: [
              const SizedBox(height: 5),
              AtomStyledText(text: translate("UTILS.DETAILS"), style: presentationTitle,textAlign: TextAlign.center,),
              ListTile(
                title: Text(match.title),
                leading: const Icon(Icons.label_outline_rounded),
                style: ListTileStyle.drawer,
              ),
              ListTile(
                title: Text(match.date.toString().substring(0, 16)),
                leading: const Icon(Icons.date_range_outlined),
                style: ListTileStyle.drawer,
              ), 
              match.description.isNotEmpty ? ListTile(
                title:ExpandableText(
                  match.description,
                  expandText: translate("UTILS.SHOW_MORE"),
                  collapseText: translate("UTILS.SHOW_LESS"),
                  maxLines: 5,
                  animation: true,
                  collapseOnTextTap: true,
                  expandOnTextTap: true,
                  urlStyle: const TextStyle(
                    color: Color.fromARGB(255, 169, 145, 255)
                )),
                leading: const Icon(Icons.description_outlined),
                style: ListTileStyle.drawer,
              ) : Container(),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey, // Customize the color
                height: 1.0, // Adjust the height of the divider
                thickness: 1.0, // Adjust the thickness of the divider
                indent: 20.0, // Indent the divider from the start
                endIndent: 20.0, // Indent the divider from the end
              ),
              const SizedBox(height: 10),
              AtomStyledText(text: translate("UTILS.ADMIN"), style: presentationTitle,textAlign: TextAlign.center,),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 1),
                horizontalTitleGap: 1,
                minLeadingWidth: 1,
                leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(user.thumb), radius: 50, backgroundColor: Colors.grey,),
                title: Text(user.name),
                subtitle: Text(user.username),
              ),
              const SizedBox(height: 20),
            ],
          ), icon: Icons.info_outline);
        } else  if(snapshot.hasError){
          return Center(child: Text(translate("MATCH.ERROR_LOADING")));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
        
      }
    );
  }
}