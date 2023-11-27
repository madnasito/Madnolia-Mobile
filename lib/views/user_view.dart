import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/widgets/custom_input.dart';
import 'package:madnolia/widgets/form_button.dart';

class UserMainView extends StatelessWidget {
  const UserMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _Card(
          icon: Icons.person,
          title: "You",
          routeName: "/user/edit",
        ),
        _Card(
          icon: Icons.bolt,
          title: "Matches",
          routeName: "/user/matches",
        ),
        _Card(
          icon: Icons.gamepad_outlined,
          title: "Platforms",
          routeName: "/user/platforms",
        )
      ],
    );
  }
}

class _Card extends StatelessWidget {
  final IconData icon;
  final String title;
  final String routeName;
  const _Card(
      {required this.routeName, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(routeName),
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 3)),
        child: Column(
          children: [
            Icon(icon),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 30,
                  fontFamily: "Cyberverse",
                  color: Colors.greenAccent),
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
                color: Colors.greenAccent),
          ),
        ),
      ],
    );
  }
}
