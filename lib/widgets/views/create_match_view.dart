import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:madnolia/blocs/blocs.dart';
import 'package:madnolia/blocs/player_matches/player_matches_bloc.dart';
import 'package:madnolia/cubits/cubits.dart';
import 'package:madnolia/models/game/minimal_game_model.dart';
import 'package:madnolia/models/match/create_match_model.dart';
import 'package:madnolia/widgets/alert_widget.dart';
import 'package:madnolia/widgets/atoms/minutes_picker.dart';
import 'package:madnolia/widgets/atoms/media/game_image_atom.dart';
import 'package:madnolia/widgets/molecules/buttons/molecule_form_button.dart';
import 'package:madnolia/widgets/molecules/form/molecule_text_form_field.dart';
import 'package:madnolia/widgets/molecules/lists/games_list_molecule.dart';
import 'package:madnolia/widgets/search_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:go_router/go_router.dart';
import 'package:madnolia/services/match_service.dart';
import 'package:madnolia/utils/platforms.dart';
// import 'package:flutter/services.dart';

import 'package:madnolia/widgets/match_card_widget.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:toast/toast.dart';

import '../../main.dart';
import '../../models/game_model.dart';
import '../../services/rawg_service.dart';
import '../custom_input_widget.dart';

class SearchGameView extends StatefulWidget {
  final int platformId;
  const SearchGameView({super.key, required this.platformId});

  @override
  State<SearchGameView> createState() => _SearchGameViewState();
}

class _SearchGameViewState extends State<SearchGameView> {
  late int counter;
  late TextEditingController controller;
  @override
  void initState() {
    counter = 0;
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    counter = 0;
    // game = null;
    final context = navigatorKey.currentContext;
    final matchUsersCubit = context?.watch<MatchUsersCubit>();
    matchUsersCubit?.restore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SimpleCustomInput(
              iconData: CupertinoIcons.search,
              controller: controller,
              placeholder:
                  translate("CREATE_MATCH.SEARCH_GAME"),
              onChanged: (value) async {
                counter++;
                Timer(
                  const Duration(seconds: 1),
                  () {
                    counter--;
                    setState(() {});
                  },
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          (controller.text.isEmpty) ? FutureBuilder(
            future: getRecomendations(widget.platformId),
            builder: (BuildContext context, AsyncSnapshot<List<MinimalGame>> snapshot) {
              if(!snapshot.hasData){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [Text(translate('RECOMMENDATIONS.LOADING')), CircularProgressIndicator()],);
              }else if(snapshot.data!.isNotEmpty){
                return Expanded(
                  child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(translate('RECOMMENDATIONS.FOR_YOU'), style: TextStyle(fontSize: 15),),
                    const SizedBox(height: 20),
                    Flexible(child: GamesListMolecule(games: snapshot.data!, platform: widget.platformId,)),
                  ],
                )
                );
              }else {
                return Container();
              }
            }
          ) : Container(),
          (counter == 0 && controller.text.isNotEmpty)
              ? FutureBuilder(
                  future: getGames(
                      title: controller.text.toString(),
                      platform: "${widget.platformId}"),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return Flexible(
                          child: snapshot.data.isNotEmpty
                              ? ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () => setState(() {
                                        context.go("/new/match", extra: {
                                          "game": snapshot.data[index],
                                          "platformId": widget.platformId
                                        });
                                      }),
                                      child:  GameCard(
                                          background: snapshot.data[index].backgroundImage,
                                          name: snapshot.data[index].name,
                                          bottom: const Text("")),
                                    );
                                  })
                          : Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(translate("CREATE_MATCH.EMPTY_SEARCH"), textAlign: TextAlign.center,),
                          ));
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              : const Text(""),
        ],
      );
  }

  Future getGames({required String title, required String platform}) async {
    return RawgService().searchGame(game: title, platform: platform);
  }

  Future<List<MinimalGame>> getRecomendations(int platform) async {
    final List resp = await MatchService().getGamesRecomendations(platform);

    final games = resp.map((e) => MinimalGame.fromJson(e)).toList();

    return games;
  }
}
final dateController = TextEditingController();

final formKey = GlobalKey<FormBuilderState>();

class MatchFormView extends StatelessWidget {
  final Game game;
  final int platformId;

  const MatchFormView(
      {super.key, required this.game, required this.platformId});

  @override
  Widget build(BuildContext context) {


    ToastContext().init(context);
    bool uploading = false;
    final userState = context.read<UserBloc>().state;
    
    final platformInfo = getPlatformInfo(platformId);
    final matchUsersCubit = context.watch<MatchUsersCubit>();
    const List<int> minutes =  [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];
    
    return Container(
      height: double.infinity,
      color: const Color.fromARGB(43, 0, 0, 0),
      child: SingleChildScrollView(
        child: FormBuilder(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(1),
                color: Colors.white38,
                child: AtomGameImage(name: game.name, background: game.backgroundImage,),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5), 
                child: Column(
                  children: [
                    const SizedBox(height: 20),
              MoleculeTextField(
                name: 'title', 
                label: translate('CREATE_MATCH.MATCH_NAME'),
                icon: Icons.title_rounded,
                validator: FormBuilderValidators.compose([
                  // Solo validamos longitud máxima, sin requerir mínimo
                  FormBuilderValidators.maxLength(20, errorText: translate('FORM.VALIDATIONS.MAX_LENGTH', args: {'count': '20'}), checkNullOrEmpty: false)
                ]),
              ),
              const SizedBox(height: 20),
              
              SimpleCustomInput(
                iconData: CupertinoIcons.calendar_today,
                keyboardType: TextInputType.none,
                placeholder: translate("CREATE_MATCH.DATE"),
                controller: dateController,
                onTap: () async {
                  DateTime? dateTime = await showOmniDateTimePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(days: 365),
                    ),
                    is24HourMode: false,
                    theme: ThemeData.dark(useMaterial3: true),
                    isShowSeconds: false,
                    minutesInterval: 1,
                    secondsInterval: 1,
                    isForce2Digits: true,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    constraints: const BoxConstraints(
                      maxWidth: 350,
                      maxHeight: 650,
                    ),
                    transitionBuilder: (context, anim1, anim2, child) {
                      return FadeTransition(
                        opacity: anim1.drive(
                          Tween(
                            begin: 0,
                            end: 1,
                          ),
                        ),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 200),
                    barrierDismissible: true,
                    selectableDayPredicate: (dateTime) {
                      // Disable 25th Feb 2023
                      if (dateTime == DateTime(2023, 2, 25)) {
                        return false;
                      } else {
                        return true;
                      }
                    },
                  );
          
                  dateController.text = dateTime != null
                      ? dateTime.toString().substring(0, 16)
                      : "";
                },
              ),
              const SizedBox(height: 20),
              const MinutesPicker(items: minutes),
              const SizedBox(height: 20),
              MoleculeTextField(
                name: 'description', 
                label: translate('CREATE_MATCH.DESCRIPTION'),
                icon: Icons.description_outlined,
                validator: FormBuilderValidators.compose([
                  // Solo validamos longitud máxima
                  FormBuilderValidators.maxLength(100, errorText: translate('FORM.VALIDATIONS.MAX_LENGTH', args: {'count': '100'}), checkNullOrEmpty: false)
                ]),
              ),
              const SizedBox(height: 20),
              const SeatchUser(),
              const SizedBox(height: 20),
              Text(
                game.name,
                style: const TextStyle(
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 15,
                  children: [
                    // Icon(Icons.gamepad_outlined),
                    SvgPicture.asset(
                      platformInfo.path,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      width: 110,
                    ),
                  ]),
              const SizedBox(height: 20),
              Text(userState.name, style: const TextStyle(fontSize: 10)),
              const SizedBox(height: 10),
              StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) =>
                MoleculeFormButton(
                  text: translate("CREATE_MATCH.CREATE_MATCH"),
                  color: Colors.transparent,
                  isLoading: uploading,
                  onPressed: () async {
                      
                    try {
                      if (dateController.text == "") {
                        return Toast.show(
                            translate("CREATE_MATCH.DATE_ERROR"),
                            gravity: 100,
                            border: Border.all(color: Colors.blueAccent),
                            textStyle: const TextStyle(fontSize: 18),
                            duration: 3);
                      }
                      
          
                      int formDate =
                          DateTime.parse(dateController.text).millisecondsSinceEpoch;

                      
                      if (formKey.currentState?.saveAndValidate() == false) {
                        setState(() => uploading = false);
                        return;
                      }
                      final String name = formKey.currentState?.fields['title']?.value ?? '';
                      final String description = formKey.currentState?.fields['description']?.value ?? '';
          
                      final matchMinutesCubit = context.read<MatchMinutesCubit>();
                      CreateMatch match = CreateMatch(
                        title: name,
                        description: description,
                        date: formDate,
                        inviteds: matchUsersCubit.getUsersId(),
                        game: game.id,
                        platform: platformId,
                        duration: matchMinutesCubit.state.minutes
                        );
          
                      setState(() => uploading = true);
          
                      final Map<String, dynamic> resp = await MatchService().createMatch(match.toJson());
          
                      if (resp.containsKey("message")) {
                        if (!context.mounted) return;
                        return showErrorServerAlert(context, resp);
                      } else {
                        Toast.show(
                            translate("CREATE_MATCH.MATCH_CREATED"),
                            gravity: 100,
                            border: Border.all(color: Colors.blueAccent),
                            textStyle: const TextStyle(fontSize: 18),
                            duration: 3);
                        dateController.clear();
                        matchMinutesCubit.restoreMinutes();
                        matchUsersCubit.restore();
                        if(!context.mounted) return;
                        final playerMatches = context.read<PlayerMatchesBloc>();
                        playerMatches.add(RestoreMatchesState());
                        if (!context.mounted) return;
                        formKey.currentState?.reset();
                        final backgroundService = FlutterBackgroundService();
                        backgroundService.invoke('match_created', {'id': resp['_id']});
                        context.goNamed("matches");
                      }
                    } catch (e) {
                      if (context.mounted) showAlert(context, e.toString());
                    } finally{
                      setState(() => uploading = false);
                    }
                    
                    }
                  )
              )
              
                  ],
                ),
              ),
              const SizedBox(height: 15),
              
            ],
          ),
        ),
      ),
    );
  }
}
