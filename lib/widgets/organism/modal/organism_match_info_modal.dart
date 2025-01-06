import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/models/match/full_match.model.dart';
import 'package:madnolia/style/text_style.dart';
import 'package:madnolia/widgets/atoms/text_atoms/atom_styled_text.dart';


class OrganismMatchInfoModal extends StatelessWidget {

  final FullMatch match;

  const OrganismMatchInfoModal({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
      final Size screenSize = MediaQuery.of(context).size;

      showModalBottomSheet(
        context: context,
        enableDrag: true,
        builder: (BuildContext context) { 
        return SizedBox(
          height: screenSize.height * 0.5,
          width: screenSize.width,
          child: Center(
            child:ListView(

              children: [
                const SizedBox(height: 5),
                AtomStyledText(text: translate("UTILS.DETAILS"), style: presentationTitle,textAlign: TextAlign.center,),
                ListTile(
                  title: Text(match.title),
                  leading: const Icon(Icons.label_outline_rounded),
                  style: ListTileStyle.drawer,
                ),
                ListTile(
                  title: Text(DateTime.fromMillisecondsSinceEpoch(match.date).toString().substring(0, 16)),
                  leading: const Icon(Icons.date_range_outlined),
                  style: ListTileStyle.drawer,
                ),
                ListTile(
                  title:ExpandableText(
                    'Lorem ipsim dnaeiod anwd awdioaw \n dieaudn \nead a iudai Lorem ipsim dnaeiod anwd awdioaw \n dieaudn \nead a iudai Lorem ipsim dnaeiod anwd awdioaw \n dieaudn \nead a iudai',
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
                ),
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
                  leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(match.user.thumb), radius: 50, backgroundColor: Colors.grey,),
                  title: Text(match.user.name),
                  subtitle: Text(match.user.username),
                )
              ],
            ),
          ),
        );
       } );
    }, icon: const Icon(Icons.info_outline_rounded));
  }
}