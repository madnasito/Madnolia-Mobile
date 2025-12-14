import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/blocs/user/user_bloc.dart';
import 'package:madnolia/database/database.dart';
import 'package:madnolia/database/repository_manager.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:madnolia/widgets/form_button.dart';

class AtomJoinMatchButton extends StatefulWidget {
  final MatchData match;
  final Function(MatchData) onJoined;
  const AtomJoinMatchButton({super.key, required this.match, required this.onJoined});

  @override
  State<AtomJoinMatchButton> createState() => _AtomJoinMatchButtonState();
}

class _AtomJoinMatchButtonState extends State<AtomJoinMatchButton> {

  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    userBloc = context.read<UserBloc>();
  }

  String? _errorMessage;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    
    if (_isLoading) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          _errorMessage!,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      );
    }
    return FormButton(
      text: translate('MATCH.JOIN_TO_MATCH'),
      color: Colors.transparent,
      onPressed: () async {
        setState(() {
          _isLoading = true;
          _errorMessage = null;
        });
        try {
          final resp = await MatchService().join(widget.match.id);
          debugPrint(resp.toString());

          await RepositoryManager().match.joinUser(widget.match.id, userBloc.state.id);
          
          final newJoinedList = List<String>.from(widget.match.joined)..add(userBloc.state.id);
          final newMatch = widget.match.copyWith(joined: newJoinedList);

          setState(() {
            // isInMatch = true;
            _isLoading = false;
          });

          widget.onJoined(newMatch);

        } catch (e) {
          debugPrint(e.toString());
          setState(() {
            _errorMessage = translate('MATCH.ERRORS.JOIN_FAILED');
            _isLoading = false;
          });
        }
      },
    );
  }
}