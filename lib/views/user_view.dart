import 'package:flutter/material.dart';
import 'package:madnolia/widgets/custom_input.dart';
import 'package:madnolia/widgets/form_button.dart';

import '../widgets/match_card_widget.dart';

class UserMainView extends StatelessWidget {
  const UserMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _Card(
          routeName: "user/edit",
        ),
        _Card(
          routeName: "user/matches",
        ),
        _Card(
          routeName: "user/platforms",
        )
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final String routeName;
  const _Card({required this.routeName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 80),
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 5)),
        child: const Column(
          children: [
            Icon(Icons.person),
            Text(
              "You",
            )
          ],
        ),
      ),
    );
  }
}

class EditUserView extends StatelessWidget {
  EditUserView({super.key});

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          const Text(
            "MADNA",
            style: TextStyle(fontSize: 20),
          ),
          Container(
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                    color: const Color.fromARGB(181, 255, 255, 255))),
            child: Image.asset("assets/rachel.jpeg"),
          ),
          const SizedBox(height: 20),
          CustomInput(
              icon: Icons.near_me,
              placeholder: "Name",
              textController: nameController),
          CustomInput(
              icon: Icons.person_2_outlined,
              placeholder: "Username",
              textController: usernameController),
          CustomInput(
            icon: Icons.email_outlined,
            placeholder: "Email",
            textController: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          FormButton(
              text: "Update",
              color: const Color.fromARGB(0, 33, 149, 243),
              onPressed: () {}),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}

class UserMatchesView extends StatelessWidget {
  const UserMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(IconData(0xE003,
            fontFamily: "Icomoon", fontPackage: "icon-playstation")),
        Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          color: Colors.black54,
          child: const Text(
            "My matches",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "Cyberverse",
                fontSize: 30,
                color: Color.fromARGB(255, 255, 251, 16)),
          ),
        ),
        const MatchCard(
          image: "assets/game_example.jpg",
          title: "Kingdom Hearts",
          buttom: Column(children: [
            SizedBox(height: 5),
            Text(
              "Casual match",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text("21312321")
          ]),
        ),
        const MatchCard(
          image: "assets/game_example_2.jpg",
          title: "Kingdom Hearts HD 2.5 ReMIX",
          buttom: Column(children: [
            SizedBox(height: 5),
            Text(
              "Casual match",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text("21312321")
          ]),
        ),
        const MatchCard(
          image: "assets/game_example_3.jpg",
          title: "Kingdom Hearts 2",
          buttom: Column(children: [
            SizedBox(height: 5),
            Text(
              "Casual match",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text("21312321")
          ]),
        ),
        const MatchCard(
          image: "assets/game_example_4.jpg",
          title: "Naruto Shippuden: Ultimate Ninja 4",
          buttom: Column(children: [
            SizedBox(height: 5),
            Text(
              "Casual match",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text("21312321")
          ]),
        ),
        const MatchCard(
          image: "assets/game_example_5.jpg",
          title: "FINAL FANTASY XIII-2",
          buttom: Column(children: [
            SizedBox(height: 5),
            Text(
              "Casual match",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text("21312321")
          ]),
        )
      ],
    );
  }
}
