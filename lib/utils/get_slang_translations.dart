import 'package:madnolia/enums/user-availability.enum.dart';
import 'package:madnolia/i18n/strings.g.dart';

String getServerErrorTranslation(String responseCode) {
  switch (responseCode) {
    case 'EMAIL_IN_USE':
      return t.ERRORS.SERVER.EMAIL_IN_USE;
    case 'USERNAME_IN_USE':
      return t.ERRORS.SERVER.USERNAME_IN_USE;
    case 'INVALID_CREDENTIALS':
      return t.ERRORS.SERVER.INVALID_CREDENTIALS;
    case 'WRONG_PASSWORD':
      return t.ERRORS.SERVER.WRONG_PASSWORD;
    case 'NETWORK_ERROR':
      return t.ERRORS.SERVER.NETWORK_ERROR;
    case 'NO_MATCH_FOUND':
      return t.ERRORS.SERVER.NO_MATCH_FOUND;
    case 'NO_GAME_FOUND':
      return t.ERRORS.SERVER.NO_GAME_FOUND;
    case 'MISSING_TOKEN':
      return t.ERRORS.SERVER.MISSING_TOKEN;
    case 'NO_MESSAGE':
      return t.ERRORS.SERVER.NO_MESSAGE;
    case 'NOT_VALID_EXTENSION':
      return t.ERRORS.SERVER.NOT_VALID_EXTENSION;
    case 'INVALID_DATE':
      return t.ERRORS.SERVER.INVALID_DATE;
    case 'REPORT_EXISTS':
      return t.ERRORS.SERVER.REPORT_EXISTS;
    case 'LOADING_GAME':
      return t.ERRORS.SERVER.LOADING_GAME;
    case 'EMAIL_DATE_LIMIT':
      return t.ERRORS.SERVER.EMAIL_DATE_LIMIT;
    case 'IMAGE_DATA':
      return t.ERRORS.SERVER.IMAGE_DATA;
    default:
      return t.ERRORS.SERVER.UNKNOWN;
  }
}

String getAvailabilityTranslation(UserAvailability availability) {
  switch (availability) {
    case UserAvailability.everyone:
      return t.PROFILE.AVAILABILITY.EVERYONE;
    case UserAvailability.partners:
      return t.PROFILE.AVAILABILITY.PARTNERS;
    case UserAvailability.no:
      return t.PROFILE.AVAILABILITY.NO;
  }
}

String getUserPageInvitationTranslation(UserAvailability option) {
  switch (option) {
    case UserAvailability.everyone:
      return t.PROFILE.USER_PAGE.INVITATIONS.EVERYONE;
    case UserAvailability.partners:
      return t.PROFILE.USER_PAGE.INVITATIONS.PARTNERS;
    case UserAvailability.no:
      return t.PROFILE.USER_PAGE.INVITATIONS.NO;
  }
}
