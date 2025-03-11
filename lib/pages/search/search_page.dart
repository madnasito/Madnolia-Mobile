import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madnolia/services/user_service.dart';
import 'package:madnolia/widgets/custom_input_widget.dart';
import 'package:madnolia/widgets/custom_scaffold.dart';

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
    counter = 0;
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    counter = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SimpleCustomInput(
                      placeholder: 'Search user',
                      controller: searchController,
                      iconData: Icons.search,
                      autofocus: true,
                      onChanged: (value){
                        debugPrint(searchController.text);
                        counter++;
                        Timer(
                          const Duration(seconds: 1),
                          () {
                            counter--;
                            setState(() {});
                          },
                        );
                      }),
                    const SizedBox(height: 20),
                    const Text('Looking for user'),
                    const SizedBox(height: 20),
                    (counter == 0 && searchController.text.isNotEmpty)
                    ? FutureBuilder(
                      future: _searchUsers(searchController.text),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
                        if(snapshot.hasData){
                          return const Text('Loaded users');
                        }else{
                          return const CircularProgressIndicator();
                        }
                       }
                    )
                    : const Text("Waiting for you")
                  ],
                ),
            ),
          ),
        ),
      );
  }

  _searchUsers(String query){
    return UserService().searchUser(query);
  }
}