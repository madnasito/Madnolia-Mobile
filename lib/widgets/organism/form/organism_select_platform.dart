import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/models/auth/register_model.dart' show RegisterModel;
import 'package:madnolia/services/auth_service.dart' show AuthService;
import 'package:madnolia/widgets/alert_widget.dart' show showErrorServerAlert;
import 'package:madnolia/widgets/molecules/buttons/molecule_form_button.dart' show MoleculeFormButton;
import 'package:madnolia/widgets/views/platforms_view.dart' show PlatformsView;

class OrganismSelectPlatform extends StatefulWidget {
  final RegisterModel registerModel;
  const OrganismSelectPlatform({super.key, required this.registerModel});

  @override
  State<OrganismSelectPlatform> createState() => _OrganismSelectPlatformState();
}

class _OrganismSelectPlatformState extends State<OrganismSelectPlatform> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlatformsView(platforms: widget.registerModel.platforms),
        StatefulBuilder(
          builder: (context, setState) =>  MoleculeFormButton(
            text: translate("REGISTER.TITLE"),
            isLoading: _isLoading,
            onPressed: () async {
              try {
                setState(() => _isLoading = true);
                final resp = await AuthService().register(widget.registerModel);
          
                if (!context.mounted) return;
          
                if (resp.containsKey("message")) {
                  showErrorServerAlert(context, resp);
                } else {
                  if(context.mounted) context.go("/");
                }
              } catch (e) {
                debugPrint(e.toString());
              } finally {
                if (mounted) setState(() => _isLoading = false);
              }
            },
          ),
        )
      ],
    );
  }
}

