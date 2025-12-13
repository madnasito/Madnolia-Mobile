import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:madnolia/enums/connection-status.enum.dart';
import 'package:madnolia/models/chat_user_model.dart';
import 'package:madnolia/models/friendship/connection_request.dart';
import 'package:madnolia/models/user/simple_user_model.dart';
import '../../atoms/buttons/atom_buttons.dart';


class MoleculeConnectionIconButton extends StatefulWidget {
  final SimpleUser userData;
  const MoleculeConnectionIconButton({super.key, required this.userData});

  @override
  State<MoleculeConnectionIconButton> createState() => _MoleculeConnectionIconButtonState();
}

class _MoleculeConnectionIconButtonState extends State<MoleculeConnectionIconButton> {

  late FlutterBackgroundService _backgroundService;
  
  @override
  void initState() {
    _backgroundService = FlutterBackgroundService();

    try {
      _backgroundService.on('new_request_connection').listen((payload) {

        debugPrint('new request: $payload');

        final requestData = ConnectionRequest.fromJson(payload!);

        if(requestData.receiver == widget.userData.id) {
          widget.userData.connection = ConnectionStatus.requestSent;
          if (mounted) setState(() {});
        } else if (requestData.sender == widget.userData.id) {
          widget.userData.connection = ConnectionStatus.requestReceived;
          if (mounted) setState(() {});
        }
        
      });

      _backgroundService.on('connection_accepted').listen((payload) {
        debugPrint('Request accepted: $payload');

        final requestData = ConnectionRequest.fromJson(payload!);

        if(requestData.receiver == widget.userData.id || requestData.sender == widget.userData.id) {
          widget.userData.connection = ConnectionStatus.partner;
          if (mounted) setState(() {});
        }
      });

      _backgroundService.on('canceled_connection').listen((payload) {
        debugPrint('Request cancelled: $payload');

        final requestData = ConnectionRequest.fromJson(payload!);


        if(requestData.receiver == widget.userData.id || requestData.sender == widget.userData.id) {
          widget.userData.connection = ConnectionStatus.none;
          if (mounted) setState(() {});
        }
      });
    } catch (e) {
      debugPrint('Error setting up connection listeners: $e');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.userData.connection) {
      case ConnectionStatus.none:
        return AtomRequestIconButton(userId: widget.userData.id,);
      case ConnectionStatus.requestSent:
        return AtomRequestedIconButton(userData: widget.userData,);
      case ConnectionStatus.requestReceived:
        return AtomPendingIconButton(userData: widget.userData);
      case ConnectionStatus.partner:
        return AtomUserChatIconButton(user: ChatUser(
          id: widget.userData.id,
          name: widget.userData.name,
          thumb: widget.userData.thumb,
          username: widget.userData.username
          )
        );
      case ConnectionStatus.blocked:
        return const SizedBox();
    }
  }
}