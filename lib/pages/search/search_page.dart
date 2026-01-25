import 'dart:async';
import 'package:flutter/material.dart';
import 'package:madnolia/i18n/strings.g.dart';
import 'package:madnolia/services/user_service.dart';
import 'package:madnolia/widgets/organism/organism_users_list.dart';

import '../../models/user/simple_user_model.dart';
import '../../widgets/atoms/input/atom_search_input.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late int counter;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    counter = 0;
  }

  @override
  void dispose() {
    searchController.dispose();
    counter = 0;
    super.dispose();
  }

  void _onSearchChanged(String value) {
    debugPrint(searchController.text);
    counter++;
    Timer(const Duration(seconds: 1), () {
      counter--;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AtomSearchInput(
              placeholder: t.SEARCH.SEARCH_USERS,
              searchController: searchController,
              onChanged: _onSearchChanged,
            ),
            const SizedBox(height: 20),
            (counter == 0 && searchController.text.isNotEmpty)
                ? Flexible(
                    child: FutureBuilder<List<SimpleUser>>(
                      future: _searchUsers(searchController.text),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError || !snapshot.hasData) {
                          return Text(t.ERRORS.LOCAL.LOADING_USERS);
                        }

                        if (snapshot.data!.isEmpty) {
                          return Text(t.SEARCH.NO_USERS_FOUND);
                        }
                        return OrganismUsersList(
                          users: snapshot.data!
                              .map((e) => SimpleUser.fromJson(e.toJson()))
                              .toList(),
                        );
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Future<List<SimpleUser>> _searchUsers(String query) async {
    try {
      final resp = await UserService().searchUser(query);
      debugPrint('Search response: $resp');
      if (resp is Map) return [];
      return (resp as List).map((e) => SimpleUser.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Search error: $e');
      return [];
    }
  }
}
