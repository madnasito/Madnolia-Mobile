import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:madnolia/services/user_service.dart';
import 'package:madnolia/widgets/custom_input_widget.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';
import 'package:madnolia/widgets/organism/organism_users_list.dart';

import '../../models/user/simple_user_model.dart' show SimpleUser;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late int counter;
  late final TextEditingController searchController;
  StreamSubscription? _requestSub;
  StreamSubscription? _acceptSub;
  StreamSubscription? _cancelSub;
  final _backgroundService = FlutterBackgroundService();

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    counter = 0;
    _setupStreamListeners();
  }

  void _setupStreamListeners() {
    _requestSub = _backgroundService.on('new_request_connection').listen((_) {
      if (mounted) setState(() {});
    });
    _acceptSub = _backgroundService.on('connection_accepted').listen((_) {
      if (mounted) setState(() {});
    });
    _cancelSub = _backgroundService.on('canceled_connection').listen((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _requestSub?.cancel();
    _acceptSub?.cancel();
    _cancelSub?.cancel();
    searchController.dispose();
    counter = 0;
    super.dispose();
  }

  void _onSearchChanged(String value) {
    debugPrint(searchController.text);
    counter++;
    Timer(
      const Duration(seconds: 1),
      () {
        counter--;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SimpleCustomInput(
                placeholder: translate('SEARCH.SEARCH_USERS'),
                controller: searchController,
                iconData: Icons.search,
                autofocus: true,
                onChanged: _onSearchChanged,
              ),
              const SizedBox(height: 20),
              (counter == 0 && searchController.text.isNotEmpty)
                  ? Flexible(
                      child: FutureBuilder<List<SimpleUser>>(
                        future: _searchUsers(searchController.text),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (snapshot.hasError || !snapshot.hasData) {
                            return Text(translate('ERRORS.LOCAL.LOADING_USERS'));
                          }

                          if(snapshot.data!.isEmpty) {
                            return Text(translate('SEARCH.NO_USERS_FOUND'));
                          } 
                          return OrganismUsersList(users: snapshot.data!);
                        },
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<SimpleUser>> _searchUsers(String query) async {
    try {
      final resp = await UserService().searchUser(query);
      if (resp is Map) return [];
      return (resp as List).map((e) => SimpleUser.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Search error: $e');
      return [];
    }
  }
}