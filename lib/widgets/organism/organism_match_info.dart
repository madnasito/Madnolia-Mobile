import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/widgets/atoms/text_atoms/center_title_atom.dart';
import 'package:madnolia/widgets/atoms/text_atoms/atom_styled_text.dart';

import '../../models/match/full_match.model.dart';
import '../../style/text_style.dart';
import '../molecules/form/molecule_text_form_field.dart';

class OrganismMatchInfo extends StatelessWidget {
  
  final FullMatch match;

  const OrganismMatchInfo({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    
    return IconButton(onPressed: (){
      final Size screenSize = MediaQuery.of(context).size;
      final formKey = GlobalKey<FormBuilderState>();


      showModalBottomSheet(
        context: context,
        enableDrag: true,
        barrierLabel: "HELLO",
        builder: (BuildContext context) { 
        return SizedBox(
          height: screenSize.height * 0.5,
          width: screenSize.width,
          child: Center(
            child:ListView(

              children: [
                AtomStyledText(text: "Details", style: presentationTitle,textAlign: TextAlign.center,),
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
                    style: TextStyle(),
                    expandText: translate("UTILS.SHOW_MORE"),
                                    collapseText: translate("UTILS.SHOW_LESS"),
                                    maxLines: 5,
                                    animation: true,
                                    collapseOnTextTap: true,
                                    expandOnTextTap: true,
                                    urlStyle: const TextStyle(
                                      color: Color.fromARGB(255, 169, 145, 255)
                                    )),
                  leading: Icon(Icons.description_outlined),
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
                AtomStyledText(text: "Admin", style: presentationTitle,textAlign: TextAlign.center,),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 1),
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

    // final userId = context.read<UserBloc>().state.id;

    // if(match.date >= DateTime.now().millisecondsSinceEpoch){
      
    // }

    // return const Placeholder();
  }
}