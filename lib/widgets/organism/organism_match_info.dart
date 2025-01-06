import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:madnolia/widgets/organism/form/organism_edit_match_form.dart';
import 'package:madnolia/widgets/organism/modal/organism_match_info_modal.dart';

import '../../blocs/user/user_bloc.dart';
import '../../models/match/full_match.model.dart';

class OrganismMatchInfo extends StatelessWidget {
  
  final FullMatch match;

  const OrganismMatchInfo({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    
    final userId = context.read<UserBloc>().state.id;

    if(match.date <= DateTime.now().millisecondsSinceEpoch || userId != match.user.id){
      
      return OrganismMatchInfoModal(match: match);

    }else{
      return OrganismEditMatchForm(match: match);
    }

  }
}