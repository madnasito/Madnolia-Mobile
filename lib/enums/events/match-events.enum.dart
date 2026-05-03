enum MatchEvents {
  invitation('match:invitation'),
  newPlayerToMatch('match:new_player_to_match'),
  cancelled('match:cancelled'),
  playerLeftMatch('match:player_left_match'),
  matchReady('match:match_ready'),
  joinToMatch('match:join_to_match'),
  leaveMatch('match:leave_match');

  final String event;
  const MatchEvents(this.event);
}
