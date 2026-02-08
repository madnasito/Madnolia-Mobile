///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsPresentationEn PRESENTATION = TranslationsPresentationEn._(_root);
	late final TranslationsHeaderEn HEADER = TranslationsHeaderEn._(_root);
	late final TranslationsHomeEn HOME = TranslationsHomeEn._(_root);
	late final TranslationsRegisterEn REGISTER = TranslationsRegisterEn._(_root);
	late final TranslationsFormEn FORM = TranslationsFormEn._(_root);
	late final TranslationsRecoverPasswordEn RECOVER_PASSWORD = TranslationsRecoverPasswordEn._(_root);
	late final TranslationsLoginEn LOGIN = TranslationsLoginEn._(_root);
	late final TranslationsCreateMatchEn CREATE_MATCH = TranslationsCreateMatchEn._(_root);
	late final TranslationsMatchEn MATCH = TranslationsMatchEn._(_root);
	late final TranslationsSearchEn SEARCH = TranslationsSearchEn._(_root);
	late final TranslationsMatchesEn MATCHES = TranslationsMatchesEn._(_root);
	late final TranslationsConnectionsEn CONNECTIONS = TranslationsConnectionsEn._(_root);
	late final TranslationsRecommendationsEn RECOMMENDATIONS = TranslationsRecommendationsEn._(_root);
	late final TranslationsChatEn CHAT = TranslationsChatEn._(_root);
	late final TranslationsGameEn GAME = TranslationsGameEn._(_root);
	late final TranslationsNotificationsEn NOTIFICATIONS = TranslationsNotificationsEn._(_root);
	late final TranslationsProfileEn PROFILE = TranslationsProfileEn._(_root);
	late final TranslationsFriendsEn FRIENDS = TranslationsFriendsEn._(_root);
	late final TranslationsReportsEn REPORTS = TranslationsReportsEn._(_root);
	late final TranslationsUtilsEn UTILS = TranslationsUtilsEn._(_root);
	late final TranslationsAlertEn ALERT = TranslationsAlertEn._(_root);
	late final TranslationsErrorsEn ERRORS = TranslationsErrorsEn._(_root);
	late final TranslationsShareEn SHARE = TranslationsShareEn._(_root);
	late final TranslationsUpdateEn UPDATE = TranslationsUpdateEn._(_root);
}

// Path: PRESENTATION
class TranslationsPresentationEn {
	TranslationsPresentationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connect with gamers around the world'
	String get TITLE => 'Connect with gamers around the world';

	/// en: 'Create matches for any retro or modern platform'
	String get SUBTITLE => 'Create matches for any retro or modern platform';
}

// Path: HEADER
class TranslationsHeaderEn {
	TranslationsHeaderEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Platforms'
	String get PLATFORMS => 'Platforms';

	/// en: 'Create Match!'
	String get MATCH => 'Create Match!';

	/// en: 'Notifications'
	String get NOTIFICATIONS => 'Notifications';

	/// en: 'Register'
	String get REGISTER => 'Register';

	/// en: 'Login'
	String get LOGIN => 'Login';

	/// en: 'Profile'
	String get PROFILE => 'Profile';

	/// en: 'Logout'
	String get LOGOUT => 'Logout';

	/// en: 'Invitations'
	String get INVITATIONS => 'Invitations';

	/// en: 'Joined'
	String get JOINED_MATCHES => 'Joined';

	/// en: 'Settings'
	String get SETTINGS => 'Settings';
}

// Path: HOME
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Created match'
	String get MATCH => 'Created match';

	/// en: 'Created matches'
	String get MATCHES => 'Created matches';

	/// en: 'Create one here'
	String get CREATE => 'Create one here';

	/// en: 'There is no match created yet'
	String get NO_MATCHES => 'There is no match created yet';

	/// en: 'There are no matches for'
	String get NO_MATCHES_FOR => 'There are no matches for';

	/// en: 'Error loading matches'
	String get ERROR_LOADING_MATCHES => 'Error loading matches';
}

// Path: REGISTER
class TranslationsRegisterEn {
	TranslationsRegisterEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign Up!'
	String get TITLE => 'Sign Up!';

	/// en: 'Name'
	String get NAME => 'Name';

	/// en: 'Username'
	String get USERNAME => 'Username';

	/// en: 'Email'
	String get EMAIL => 'Email';

	/// en: 'Password'
	String get PASSWORD => 'Password';

	/// en: 'Repeat password'
	String get PASSWORD2 => 'Repeat password';

	late final TranslationsRegisterValidationsEn VALIDATIONS = TranslationsRegisterValidationsEn._(_root);

	/// en: 'Please, select your platforms'
	String get SELECT_PLATFORMS => 'Please, select your platforms';

	/// en: 'Mobile'
	String get PHONE => 'Mobile';

	/// en: 'Do you have an account?'
	String get SUBTITLE => 'Do you have an account?';

	/// en: ' Login here'
	String get SUB_LOGIN => ' Login here';

	/// en: 'Next'
	String get NEXT => 'Next';

	/// en: 'Great! Thanks for sign up'
	String get TOAST_SIGN_UP => 'Great! Thanks for sign up';

	/// en: 'The platforms you select will be highlighted'
	String get SELECT_PLATFORMS_SUBTITLE => 'The platforms you select will be highlighted';
}

// Path: FORM
class TranslationsFormEn {
	TranslationsFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsFormInputEn INPUT = TranslationsFormInputEn._(_root);
	late final TranslationsFormButtonsEn BUTTONS = TranslationsFormButtonsEn._(_root);
	late final TranslationsFormValidationsEn VALIDATIONS = TranslationsFormValidationsEn._(_root);
}

// Path: RECOVER_PASSWORD
class TranslationsRecoverPasswordEn {
	TranslationsRecoverPasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Recover your password'
	String get TITLE => 'Recover your password';

	/// en: 'Recover password'
	String get RECOVER_PASSWORD => 'Recover password';

	/// en: 'Email sended!'
	String get EMAIL_SENDED => 'Email sended!';

	/// en: 'There was an error getting recovering password info'
	String get ERROR_GETTING_INFO => 'There was an error getting recovering password info';

	/// en: 'Redirecting to Home Page...'
	String get HOME_PAGE_REDIRECTING => 'Redirecting to Home Page...';

	/// en: 'Password updated successfully'
	String get PASSWORD_UPDATED => 'Password updated successfully';
}

// Path: LOGIN
class TranslationsLoginEn {
	TranslationsLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome, Player'
	String get WELCOME => 'Welcome, Player';

	/// en: 'Login'
	String get BUTTON => 'Login';

	late final TranslationsLoginErrorsEn ERRORS = TranslationsLoginErrorsEn._(_root);

	/// en: 'Forgot password?'
	String get FORGOT_PASSWORD => 'Forgot password?';

	/// en: 'Don't have an account?'
	String get SUBTITLE => 'Don\'t have an account?';

	/// en: 'Register here'
	String get SUB_REGISTER => 'Register here';
}

// Path: CREATE_MATCH
class TranslationsCreateMatchEn {
	TranslationsCreateMatchEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select the platform'
	String get TITLE => 'Select the platform';

	/// en: 'Description (optional)'
	String get DESCRIPTION => 'Description (optional)';

	/// en: 'Search game'
	String get SEARCH_GAME => 'Search game';

	/// en: 'Loading recommendations'
	String get LOADING_RECOMENDATIONS => 'Loading recommendations';

	/// en: 'Search's results'
	String get SEARCH_RESULTS => 'Search\'s results';

	/// en: 'No founded games, please try another name'
	String get EMPTY_SEARCH => 'No founded games, please try another name';

	/// en: 'Type a bit more of the title to find your game'
	String get SEARCH_HINT => 'Type a bit more of the title to find your game';

	/// en: 'Error searching games, please try again'
	String get SEARCH_ERROR => 'Error searching games, please try again';

	/// en: 'You have not selected a platform'
	String get PLATFORMS_EMPTY => 'You have not selected a platform';

	/// en: 'Press here for to add a platform'
	String get ADD_PLATFORMS => 'Press here for to add a platform';

	/// en: 'Searching'
	String get SEARCHING => 'Searching';

	/// en: 'Invite partners to your match (optional)'
	String get SEARCH_USER => 'Invite partners to your match (optional)';

	/// en: 'Match name (optional)'
	String get MATCH_NAME => 'Match name (optional)';

	/// en: 'Inviteds'
	String get INVITEDS => 'Inviteds';

	/// en: 'Date'
	String get DATE => 'Date';

	/// en: 'Time'
	String get TIME => 'Time';

	/// en: 'Press the clock'
	String get CLOCK_MESSAGE => 'Press the clock';

	/// en: 'Submit'
	String get SUBMIT => 'Submit';

	/// en: 'Create Match!'
	String get CREATE_MATCH => 'Create Match!';

	/// en: 'Created Match!'
	String get MATCH_CREATED => 'Created Match!';

	/// en: 'Create a correct date and time'
	String get DATE_ERROR => 'Create a correct date and time';

	/// en: 'The match is creating'
	String get UPLOADING_MESSAGE => 'The match is creating';

	/// en: 'Error creating the match'
	String get ERROR => 'Error creating the match';

	/// en: 'Title is required'
	String get TITLE_EMPTY => 'Title is required';

	/// en: 'Duration: $duration minutes'
	String DURATION({required Object duration}) => 'Duration: ${duration} minutes';
}

// Path: MATCH
class TranslationsMatchEn {
	TranslationsMatchEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Match updated'
	String get MATCH_UPDATED => 'Match updated';

	/// en: 'Error loading match'
	String get ERROR_LOADING => 'Error loading match';

	/// en: 'Join to match'
	String get JOIN_TO_MATCH => 'Join to match';

	/// en: 'Edit match'
	String get EDIT_MATCH => 'Edit match';

	/// en: 'Leave match'
	String get LEAVE_MATCH => 'Leave match';

	/// en: 'Cancel match'
	String get CANCEL_MATCH => 'Cancel match';

	/// en: 'Are you sure you want to cancel the match?'
	String get CANCELL_MATCH_QUESTION => 'Are you sure you want to cancel the match?';

	/// en: 'Match cancelled'
	String get MATCH_CANCELLED => 'Match cancelled';

	/// en: 'Match ended'
	String get MATCH_ENDED => 'Match ended';

	late final TranslationsMatchStatusEn STATUS = TranslationsMatchStatusEn._(_root);
}

// Path: SEARCH
class TranslationsSearchEn {
	TranslationsSearchEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search'
	String get TITLE => 'Search';

	/// en: 'Search'
	String get SEARCH => 'Search';

	/// en: 'Search users'
	String get SEARCH_USERS => 'Search users';

	/// en: 'No results found'
	String get NO_RESULTS => 'No results found';

	/// en: 'Error loading search results'
	String get ERROR_LOADING => 'Error loading search results';

	/// en: 'Searching...'
	String get SEARCHING => 'Searching...';

	/// en: 'No users found'
	String get NO_USERS_FOUND => 'No users found';
}

// Path: MATCHES
class TranslationsMatchesEn {
	TranslationsMatchesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Matches'
	String get TITLE => 'Matches';

	/// en: 'All'
	String get ALL => 'All';

	/// en: 'Created'
	String get CREATED => 'Created';

	/// en: 'Joined'
	String get JOINED => 'Joined';

	late final TranslationsMatchesErrorsEn ERRORS = TranslationsMatchesErrorsEn._(_root);
}

// Path: CONNECTIONS
class TranslationsConnectionsEn {
	TranslationsConnectionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connections'
	String get TITLE => 'Connections';

	/// en: 'No connections'
	String get EMPTY => 'No connections';

	/// en: 'Loading connections'
	String get LOADING => 'Loading connections';

	late final TranslationsConnectionsErrorsEn ERRORS = TranslationsConnectionsErrorsEn._(_root);

	/// en: 'You have requested a connection to $name'
	String HAVE_A_REQUEST({required Object name}) => 'You have requested a connection to ${name}';

	late final TranslationsConnectionsRequestsEn REQUESTS = TranslationsConnectionsRequestsEn._(_root);
}

// Path: RECOMMENDATIONS
class TranslationsRecommendationsEn {
	TranslationsRecommendationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Recommendations'
	String get TITLE => 'Recommendations';

	/// en: 'You haven't created any match for this playform yet Search a game to create one!'
	String get EMPTY => 'You haven\'t created any match for this playform yet \nSearch a game to create one!';

	/// en: 'Loading recommendations'
	String get LOADING => 'Loading recommendations';

	/// en: 'Recommendations for you'
	String get FOR_YOU => 'Recommendations for you';

	late final TranslationsRecommendationsErrorsEn ERRORS = TranslationsRecommendationsErrorsEn._(_root);
}

// Path: CHAT
class TranslationsChatEn {
	TranslationsChatEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Messages'
	String get MESSAGES => 'Messages';

	/// en: 'Message'
	String get MESSAGE => 'Message';

	/// en: 'No messages'
	String get NO_MESSAGES => 'No messages';

	/// en: 'Say hi to $name'
	String SAY_HI_TO({required Object name}) => 'Say hi to ${name}';

	/// en: 'Say hi'
	String get SAY_HI => 'Say hi';

	late final TranslationsChatErrorsEn ERRORS = TranslationsChatErrorsEn._(_root);

	/// en: 'Today'
	String get TODAY => 'Today';

	/// en: 'Yesterday'
	String get YESTERDAY => 'Yesterday';
}

// Path: GAME
class TranslationsGameEn {
	TranslationsGameEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Game'
	String get GAME => 'Game';

	/// en: 'Match'
	String get MATCH => 'Match';

	/// en: 'Date'
	String get DATE => 'Date';

	/// en: 'Platform'
	String get PLATFORM => 'Platform';
}

// Path: NOTIFICATIONS
class TranslationsNotificationsEn {
	TranslationsNotificationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Invitations'
	String get INVITATIONS => 'Invitations';

	/// en: 'Notifications'
	String get TITLE => 'Notifications';

	/// en: 'No notifications'
	String get EMPTY => 'No notifications';

	/// en: 'Error loading notifications'
	String get ERROR_LOADING => 'Error loading notifications';

	/// en: 'Match Invitation'
	String get MATCH_INVITATION => 'Match Invitation';

	/// en: 'You are invited to'
	String get INVITED_TO => 'You are invited to';

	/// en: 'New Ally!'
	String get CONNECTION_REQUEST_TITLE => 'New Ally!';

	/// en: '$name wants to join your team!'
	String CONNECTION_REQUEST({required Object name}) => '${name} wants to join your team!';

	/// en: 'Alliance Formed!'
	String get CONNECTION_ACCEPTED_TITLE => 'Alliance Formed!';

	/// en: '$name has joined your team! You can now play together.'
	String CONNECTION_ACCEPTED({required Object name}) => '${name} has joined your team! You can now play together.';

	/// en: 'Accept request?'
	String get ACCEPT_REQUEST_TITLE => 'Accept request?';

	/// en: 'You have a new invitation to:'
	String get INVITATION_TO_MATCH => 'You have a new invitation to:';

	/// en: 'Match ready'
	String get MATCH_READY => 'Match ready';

	/// en: '$name has started'
	String MATCH_STARTED({required Object name}) => '${name} has started';
}

// Path: PROFILE
class TranslationsProfileEn {
	TranslationsProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'You'
	String get YOU => 'You';

	/// en: 'Matches'
	String get MATCHES => 'Matches';

	/// en: 'Profile'
	String get TITLE => 'Profile';

	/// en: 'Your platforms'
	String get PLATFORMS => 'Your platforms';

	late final TranslationsProfileMatchesPageEn MATCHES_PAGE = TranslationsProfileMatchesPageEn._(_root);
	late final TranslationsProfileAvailabilityEn AVAILABILITY = TranslationsProfileAvailabilityEn._(_root);
	late final TranslationsProfileUserPageEn USER_PAGE = TranslationsProfileUserPageEn._(_root);
	late final TranslationsProfilePlatformsPageEn PLATFORMS_PAGE = TranslationsProfilePlatformsPageEn._(_root);
}

// Path: FRIENDS
class TranslationsFriendsEn {
	TranslationsFriendsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Friends'
	String get TITLE => 'Friends';

	/// en: 'You have no friends yet'
	String get EMPTY => 'You have no friends yet';

	/// en: 'Error loading friends'
	String get ERROR_LOADING => 'Error loading friends';
}

// Path: REPORTS
class TranslationsReportsEn {
	TranslationsReportsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Report created'
	String get CREATED => 'Report created';

	/// en: 'Report this user'
	String get REPORT_USER => 'Report this user';

	/// en: 'Report to'
	String get REPORT_TO => 'Report to';

	/// en: 'Select report type'
	String get SELECT_TYPE => 'Select report type';

	/// en: 'App bug'
	String get APP_BUG => 'App bug';

	/// en: 'Other'
	String get OTHER => 'Other';

	/// en: 'Spam'
	String get SPAM => 'Spam';

	/// en: 'Child abuse'
	String get CHILD_ABUSE => 'Child abuse';

	/// en: 'Submit report'
	String get SUBMIT => 'Submit report';

	/// en: 'Send feedback'
	String get FEEDBACK => 'Send feedback';
}

// Path: UTILS
class TranslationsUtilsEn {
	TranslationsUtilsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Show more'
	String get SHOW_MORE => 'Show more';

	/// en: 'Show less'
	String get SHOW_LESS => 'Show less';

	/// en: 'Details'
	String get DETAILS => 'Details';

	/// en: 'Admin'
	String get ADMIN => 'Admin';

	/// en: 'Description'
	String get DESCRIPTION => 'Description';

	/// en: 'Select file'
	String get SELECT_FILE => 'Select file';

	/// en: 'File'
	String get FILE => 'File';

	/// en: 'Reload'
	String get RELOAD => 'Reload';

	/// en: 'Recovering password for $name'
	String RECOVERING_PASSWORD_FOR({required Object name}) => 'Recovering password for ${name}';

	/// en: 'Keeping connections active'
	String get KEEPING_CONNECTIONS => 'Keeping connections active';

	/// en: 'Accept'
	String get ACCEPT => 'Accept';

	/// en: 'Cancel'
	String get CANCEL => 'Cancel';

	/// en: 'Reject'
	String get REJECT => 'Reject';

	/// en: 'Dismiss'
	String get DISMISS => 'Dismiss';

	/// en: 'You'
	String get YOU => 'You';

	/// en: 'No'
	String get NO => 'No';

	/// en: 'Yes'
	String get YES => 'Yes';
}

// Path: ALERT
class TranslationsAlertEn {
	TranslationsAlertEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Are you sure?'
	String get YOU_SURE => 'Are you sure?';

	/// en: 'Cancel'
	String get CANCEL => 'Cancel';

	/// en: 'Delete my account'
	String get DELETE_MY_ACCOUNT => 'Delete my account';
}

// Path: ERRORS
class TranslationsErrorsEn {
	TranslationsErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsErrorsServerEn SERVER = TranslationsErrorsServerEn._(_root);
	late final TranslationsErrorsNetworkEn NETWORK = TranslationsErrorsNetworkEn._(_root);
	late final TranslationsErrorsLocalEn LOCAL = TranslationsErrorsLocalEn._(_root);
	late final TranslationsErrorsUiEn UI = TranslationsErrorsUiEn._(_root);
}

// Path: SHARE
class TranslationsShareEn {
	TranslationsShareEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '⚡️ Share this match!'
	String get TITLE => '⚡️ Share this match!';

	/// en: '🎮 Let's play $name'
	String SUBJECT({required Object name}) => '🎮 Let\'s play ${name}';

	/// en: '🎮 Let's play $gameName ⚡️ Join now here: $match'
	String TEXT({required Object gameName, required Object match}) => '🎮 Let\'s play ${gameName} \n⚡️ Join now here: ${match}';
}

// Path: UPDATE
class TranslationsUpdateEn {
	TranslationsUpdateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'NEW VERSION!'
	String get TITLE => 'NEW VERSION!';

	/// en: 'Update madnolia to version $version to keep playing.'
	String MESSAGE({required Object version}) => 'Update madnolia to version ${version} to keep playing.';

	/// en: 'UPDATE NOW'
	String get BUTTON => 'UPDATE NOW';
}

// Path: REGISTER.VALIDATIONS
class TranslationsRegisterValidationsEn {
	TranslationsRegisterValidationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The name is not valid'
	String get NAME => 'The name is not valid';

	/// en: 'The name is too long'
	String get LONG_NAME => 'The name is too long';

	/// en: 'The username is not valid'
	String get USERNAME => 'The username is not valid';

	/// en: 'The email is not correct'
	String get EMAIL => 'The email is not correct';

	/// en: 'The password is too short'
	String get PASSWORD => 'The password is too short';

	/// en: 'The passwords are diffenrents'
	String get PASSWORD2 => 'The passwords are diffenrents';
}

// Path: FORM.INPUT
class TranslationsFormInputEn {
	TranslationsFormInputEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Name'
	String get NAME => 'Name';

	/// en: 'Username'
	String get USERNAME => 'Username';

	/// en: 'Email'
	String get EMAIL => 'Email';

	/// en: 'Password'
	String get PASSWORD => 'Password';

	/// en: 'Repeat password'
	String get PASSWORD2 => 'Repeat password';

	/// en: 'Platforms'
	String get PLATFORMS => 'Platforms';

	/// en: 'Reply'
	String get REPLY => 'Reply';

	/// en: 'Mark as read'
	String get MARK_AS_READ => 'Mark as read';

	/// en: 'New password'
	String get NEW_PASSWORD => 'New password';

	/// en: 'Username or Email'
	String get USERNAME_EMAIL => 'Username or Email';
}

// Path: FORM.BUTTONS
class TranslationsFormButtonsEn {
	TranslationsFormButtonsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Update password'
	String get UPDATE_PASSWORD => 'Update password';
}

// Path: FORM.VALIDATIONS
class TranslationsFormValidationsEn {
	TranslationsFormValidationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This field is required'
	String get REQUIRED => 'This field is required';

	/// en: 'Required field'
	String get REQUIRED_FIELD => 'Required field';

	/// en: 'Invalid format'
	String get INVALID_FORMAT => 'Invalid format';

	/// en: 'Invalid input'
	String get INVALID_INPUT => 'Invalid input';

	/// en: 'Too short'
	String get TOO_SHORT => 'Too short';

	/// en: 'Too long'
	String get TOO_LONG => 'Too long';

	/// en: 'Minimum $count characters'
	String MIN_LENGTH({required Object count}) => 'Minimum ${count} characters';

	/// en: 'Maximum $count characters'
	String MAX_LENGTH({required Object count}) => 'Maximum ${count} characters';

	/// en: 'Between $min and $max characters'
	String MIN_MAX_LENGTH({required Object min, required Object max}) => 'Between ${min} and ${max} characters';

	/// en: 'Only letters allowed'
	String get ONLY_LETTERS => 'Only letters allowed';

	/// en: 'Only numbers allowed'
	String get ONLY_NUMBERS => 'Only numbers allowed';

	/// en: 'Only letters and numbers allowed'
	String get LETTERS_AND_NUMBERS => 'Only letters and numbers allowed';

	/// en: 'Special characters not allowed'
	String get NO_SPECIAL_CHARS => 'Special characters not allowed';

	/// en: 'Invalid email address'
	String get INVALID_EMAIL => 'Invalid email address';

	/// en: 'Invalid email format'
	String get INVALID_EMAIL_FORMAT => 'Invalid email format';

	/// en: 'Invalid URL'
	String get INVALID_URL => 'Invalid URL';

	/// en: 'Invalid phone number'
	String get INVALID_PHONE => 'Invalid phone number';

	/// en: 'Invalid date'
	String get INVALID_DATE => 'Invalid date';

	/// en: 'Invalid time'
	String get INVALID_TIME => 'Invalid time';

	/// en: 'Passwords don't match'
	String get PASSWORDS_DONT_MATCH => 'Passwords don\'t match';

	/// en: 'Password too weak'
	String get PASSWORD_TOO_WEAK => 'Password too weak';

	/// en: 'Password must be at least $count characters'
	String PASSWORD_MIN_LENGTH({required Object count}) => 'Password must be at least ${count} characters';

	/// en: 'Password must include uppercase, lowercase and numbers'
	String get PASSWORD_REQUIREMENTS => 'Password must include uppercase, lowercase and numbers';

	/// en: 'Invalid username'
	String get USERNAME_INVALID => 'Invalid username';

	/// en: 'Username too short'
	String get USERNAME_TOO_SHORT => 'Username too short';

	/// en: 'Username too long'
	String get USERNAME_TOO_LONG => 'Username too long';

	/// en: 'This username already exists'
	String get USERNAME_EXISTS => 'This username already exists';

	/// en: 'This email is already registered'
	String get EMAIL_EXISTS => 'This email is already registered';

	/// en: 'Invalid name'
	String get INVALID_NAME => 'Invalid name';

	/// en: 'Name too long'
	String get NAME_TOO_LONG => 'Name too long';

	/// en: 'Invalid age'
	String get INVALID_AGE => 'Invalid age';

	/// en: 'Minimum age: $age years'
	String MIN_AGE({required Object age}) => 'Minimum age: ${age} years';

	/// en: 'Maximum age: $age years'
	String MAX_AGE({required Object age}) => 'Maximum age: ${age} years';

	/// en: 'Numeric values only'
	String get NUMERIC_ONLY => 'Numeric values only';

	/// en: 'Must be a positive number'
	String get POSITIVE_NUMBER => 'Must be a positive number';

	/// en: 'Value out of allowed range'
	String get INVALID_RANGE => 'Value out of allowed range';

	/// en: 'Minimum value: $value'
	String MIN_VALUE({required Object value}) => 'Minimum value: ${value}';

	/// en: 'Maximum value: $value'
	String MAX_VALUE({required Object value}) => 'Maximum value: ${value}';

	/// en: 'Whitespace not allowed'
	String get WHITESPACE_NOT_ALLOWED => 'Whitespace not allowed';

	/// en: 'Must contain at least one uppercase letter'
	String get MUST_CONTAIN_UPPERCASE => 'Must contain at least one uppercase letter';

	/// en: 'Must contain at least one lowercase letter'
	String get MUST_CONTAIN_LOWERCASE => 'Must contain at least one lowercase letter';

	/// en: 'Must contain at least one number'
	String get MUST_CONTAIN_NUMBER => 'Must contain at least one number';

	/// en: 'Must contain at least one symbol'
	String get MUST_CONTAIN_SYMBOL => 'Must contain at least one symbol';

	/// en: 'Field required'
	String get FIELD_REQUIRED => 'Field required';

	/// en: 'Please fill this field'
	String get PLEASE_FILL_FIELD => 'Please fill this field';

	/// en: 'Please check your input'
	String get CHECK_INPUT => 'Please check your input';

	/// en: 'Invalid characters'
	String get INVALID_CHARACTERS => 'Invalid characters';

	/// en: 'Text too short'
	String get TEXT_TOO_SHORT => 'Text too short';

	/// en: 'Text too long'
	String get TEXT_TOO_LONG => 'Text too long';

	/// en: 'Invalid selection'
	String get INVALID_SELECTION => 'Invalid selection';

	/// en: 'You must select an option'
	String get REQUIRED_SELECTION => 'You must select an option';

	/// en: 'Invalid length'
	String get INVALID_LENGTH => 'Invalid length';

	/// en: 'You need to select at least one platform'
	String get SELECT_PLATFORMS => 'You need to select at least one platform';
}

// Path: LOGIN.ERRORS
class TranslationsLoginErrorsEn {
	TranslationsLoginErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Not founded user'
	String get USER => 'Not founded user';

	/// en: 'No valid password'
	String get PASSWORD => 'No valid password';
}

// Path: MATCH.STATUS
class TranslationsMatchStatusEn {
	TranslationsMatchStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Waiting'
	String get WAITING => 'Waiting';

	/// en: 'In progress'
	String get RUNNING => 'In progress';

	/// en: 'Finished'
	String get FINISHED => 'Finished';

	/// en: 'Canceled'
	String get CANCELLED => 'Canceled';
}

// Path: MATCHES.ERRORS
class TranslationsMatchesErrorsEn {
	TranslationsMatchesErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error loading matches'
	String get LOADING_ERROR => 'Error loading matches';

	/// en: 'No matches found'
	String get NO_MATCHES => 'No matches found';

	/// en: 'Failed to join the match'
	String get JOIN_FAILED => 'Failed to join the match';
}

// Path: CONNECTIONS.ERRORS
class TranslationsConnectionsErrorsEn {
	TranslationsConnectionsErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error loading connections'
	String get LOADING_ERROR => 'Error loading connections';

	/// en: 'No connections found'
	String get NO_CONNECTIONS => 'No connections found';
}

// Path: CONNECTIONS.REQUESTS
class TranslationsConnectionsRequestsEn {
	TranslationsConnectionsRequestsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Requests'
	String get TITLE => 'Requests';

	/// en: 'Accepted'
	String get ACCEPTED => 'Accepted';

	/// en: 'Add'
	String get ADD => 'Add';

	/// en: 'Requested'
	String get REQUESTED => 'Requested';

	/// en: 'Rejected'
	String get REJECTED => 'Rejected';

	/// en: 'Pending'
	String get PENDING => 'Pending';

	/// en: 'Accept'
	String get ACCEPT => 'Accept';

	/// en: 'Reject'
	String get REJECT => 'Reject';

	/// en: '$name wants to connect with you'
	String USER_WANTS_TO_CONNECT({required Object name}) => '${name} wants to connect with you';

	/// en: 'Accept request?'
	String get ACCEPT_REQUEST => 'Accept request?';

	/// en: 'Do you want to cancel the request?'
	String get WANT_TO_CANCELL => 'Do you want to cancel the request?';

	/// en: 'Cancel request'
	String get CANCEL => 'Cancel request';
}

// Path: RECOMMENDATIONS.ERRORS
class TranslationsRecommendationsErrorsEn {
	TranslationsRecommendationsErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error loading recommendations'
	String get LOADING => 'Error loading recommendations';
}

// Path: CHAT.ERRORS
class TranslationsChatErrorsEn {
	TranslationsChatErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error loading messages'
	String get LOADING_ERROR => 'Error loading messages';

	/// en: 'Error loading chat'
	String get LOADING_CHAT => 'Error loading chat';

	/// en: 'No friendship data'
	String get NO_DATA => 'No friendship data';

	/// en: 'Error loading user'
	String get LOADING_USER => 'Error loading user';

	/// en: 'No user data'
	String get NO_USER_DATA => 'No user data';
}

// Path: PROFILE.MATCHES_PAGE
class TranslationsProfileMatchesPageEn {
	TranslationsProfileMatchesPageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My matches'
	String get TITLE => 'My matches';

	/// en: 'You haven't created a match yet'
	String get EMPTY => 'You haven\'t created a match yet';
}

// Path: PROFILE.AVAILABILITY
class TranslationsProfileAvailabilityEn {
	TranslationsProfileAvailabilityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Available'
	String get EVERYONE => 'Available';

	/// en: 'Partners Only'
	String get PARTNERS => 'Partners Only';

	/// en: 'Unavailable'
	String get NO => 'Unavailable';
}

// Path: PROFILE.USER_PAGE
class TranslationsProfileUserPageEn {
	TranslationsProfileUserPageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Name'
	String get NAME => 'Name';

	/// en: 'Username'
	String get USERNAME => 'Username';

	/// en: 'Email'
	String get EMAIL => 'Email';

	late final TranslationsProfileUserPageInvitationsEn INVITATIONS = TranslationsProfileUserPageInvitationsEn._(_root);
	late final TranslationsProfileUserPageErrorsEn ERRORS = TranslationsProfileUserPageErrorsEn._(_root);

	/// en: 'Uploading image, wait a moment please'
	String get UPLOADING_IMAGE => 'Uploading image, wait a moment please';

	/// en: 'Updated!'
	String get UPDATED => 'Updated!';

	/// en: 'Update'
	String get UPDATE => 'Update';

	/// en: 'Delete account'
	String get DELETE_ACCOUNT => 'Delete account';

	/// en: 'Your account has been deleted'
	String get ACCOUNT_DELETED => 'Your account has been deleted';
}

// Path: PROFILE.PLATFORMS_PAGE
class TranslationsProfilePlatformsPageEn {
	TranslationsProfilePlatformsPageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your platforms'
	String get TITLE => 'Your platforms';

	/// en: 'Updated platforms!'
	String get SUCCESS => 'Updated platforms!';
}

// Path: ERRORS.SERVER
class TranslationsErrorsServerEn {
	TranslationsErrorsServerEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'User not found'
	String get USER_NOT_FOUND => 'User not found';

	/// en: 'Email in use'
	String get EMAIL_IN_USE => 'Email in use';

	/// en: 'Username in use'
	String get USERNAME_IN_USE => 'Username in use';

	/// en: 'Wrong password'
	String get WRONG_PASSWORD => 'Wrong password';

	/// en: 'Network error'
	String get NETWORK_ERROR => 'Network error';

	/// en: 'No match found'
	String get NO_MATCH_FOUND => 'No match found';

	/// en: 'No game found'
	String get NO_GAME_FOUND => 'No game found';

	/// en: 'Missing authentication token'
	String get MISSING_TOKEN => 'Missing authentication token';

	/// en: 'No message'
	String get NO_MESSAGE => 'No message';

	/// en: 'Not valid extension'
	String get NOT_VALID_EXTENSION => 'Not valid extension';

	/// en: 'Invalid date'
	String get INVALID_DATE => 'Invalid date';

	/// en: 'Wait a minute You have reported this user'
	String get REPORT_EXISTS => 'Wait a minute \n You have reported this user';

	/// en: 'Error loading game, please try again'
	String get LOADING_GAME => 'Error loading game, please try again';

	/// en: 'You must wait at least 15 days to update your email'
	String get EMAIL_DATE_LIMIT => 'You must wait at least 15 days to update your email';

	/// en: 'There is a problem with the image data Please, try another image'
	String get IMAGE_DATA => 'There is a problem with the image data \n Please, try another image';

	/// en: 'User or password incorrect'
	String get INVALID_CREDENTIALS => 'User or password incorrect';

	/// en: 'Unknown error'
	String get UNKNOWN => 'Unknown error';
}

// Path: ERRORS.NETWORK
class TranslationsErrorsNetworkEn {
	TranslationsErrorsNetworkEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Verify your connection'
	String get VERIFY_CONNECTION => 'Verify your connection';
}

// Path: ERRORS.LOCAL
class TranslationsErrorsLocalEn {
	TranslationsErrorsLocalEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Error loading users'
	String get LOADING_USERS => 'Error loading users';

	/// en: 'Error loading user'
	String get LOADING_USER => 'Error loading user';
}

// Path: ERRORS.UI
class TranslationsErrorsUiEn {
	TranslationsErrorsUiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Something went wrong while rendering the UI. Please try reloading the app.'
	String get MAIN => 'Something went wrong while rendering the UI. Please try reloading the app.';

	/// en: 'Technical details'
	String get TECHNICAL_DETAILS => 'Technical details';
}

// Path: PROFILE.USER_PAGE.INVITATIONS
class TranslationsProfileUserPageInvitationsEn {
	TranslationsProfileUserPageInvitationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Accept invitations from:'
	String get TITLE => 'Accept invitations from:';

	/// en: 'Whatever, i want to play'
	String get EVERYONE => 'Whatever, i want to play';

	/// en: 'Only my hommies'
	String get PARTNERS => 'Only my hommies';

	/// en: 'Please, let me alone'
	String get NO => 'Please, let me alone';
}

// Path: PROFILE.USER_PAGE.ERRORS
class TranslationsProfileUserPageErrorsEn {
	TranslationsProfileUserPageErrorsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please verify your information'
	String get VERIFY => 'Please verify your information';

	/// en: 'There is another user using this EMAIL'
	String get EMAIL => 'There is another user using this EMAIL';

	/// en: 'There is another user using this USERNAME'
	String get USERNAME => 'There is another user using this USERNAME';

	/// en: 'The image size cant' moore than 2mb'
	String get IMG_SIZE => 'The image size cant\' moore than 2mb';

	/// en: 'The extension is not valid, please use: 'JPG', 'PNG', 'JPEG''
	String get IMG_EXTENSION => 'The extension is not valid, please use: \'JPG\', \'PNG\', \'JPEG\'';

	/// en: 'Error updating the image'
	String get IMG_UPDATING => 'Error updating the image';

	/// en: 'Error updating'
	String get ERROR_UPDATING => 'Error updating';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'PRESENTATION.TITLE' => 'Connect with gamers around the world',
			'PRESENTATION.SUBTITLE' => 'Create matches for any retro or modern platform',
			'HEADER.PLATFORMS' => 'Platforms',
			'HEADER.MATCH' => 'Create Match!',
			'HEADER.NOTIFICATIONS' => 'Notifications',
			'HEADER.REGISTER' => 'Register',
			'HEADER.LOGIN' => 'Login',
			'HEADER.PROFILE' => 'Profile',
			'HEADER.LOGOUT' => 'Logout',
			'HEADER.INVITATIONS' => 'Invitations',
			'HEADER.JOINED_MATCHES' => 'Joined',
			'HEADER.SETTINGS' => 'Settings',
			'HOME.MATCH' => 'Created match',
			'HOME.MATCHES' => 'Created matches',
			'HOME.CREATE' => 'Create one here',
			'HOME.NO_MATCHES' => 'There is no match created yet',
			'HOME.NO_MATCHES_FOR' => 'There are no matches for',
			'HOME.ERROR_LOADING_MATCHES' => 'Error loading matches',
			'REGISTER.TITLE' => 'Sign Up!',
			'REGISTER.NAME' => 'Name',
			'REGISTER.USERNAME' => 'Username',
			'REGISTER.EMAIL' => 'Email',
			'REGISTER.PASSWORD' => 'Password',
			'REGISTER.PASSWORD2' => 'Repeat password',
			'REGISTER.VALIDATIONS.NAME' => 'The name is not valid',
			'REGISTER.VALIDATIONS.LONG_NAME' => 'The name is too long',
			'REGISTER.VALIDATIONS.USERNAME' => 'The username is not valid',
			'REGISTER.VALIDATIONS.EMAIL' => 'The email is not correct',
			'REGISTER.VALIDATIONS.PASSWORD' => 'The password is too short',
			'REGISTER.VALIDATIONS.PASSWORD2' => 'The passwords are diffenrents',
			'REGISTER.SELECT_PLATFORMS' => 'Please, select your platforms',
			'REGISTER.PHONE' => 'Mobile',
			'REGISTER.SUBTITLE' => 'Do you have an account?',
			'REGISTER.SUB_LOGIN' => ' Login here',
			'REGISTER.NEXT' => 'Next',
			'REGISTER.TOAST_SIGN_UP' => 'Great! Thanks for sign up',
			'REGISTER.SELECT_PLATFORMS_SUBTITLE' => 'The platforms you select will be highlighted',
			'FORM.INPUT.NAME' => 'Name',
			'FORM.INPUT.USERNAME' => 'Username',
			'FORM.INPUT.EMAIL' => 'Email',
			'FORM.INPUT.PASSWORD' => 'Password',
			'FORM.INPUT.PASSWORD2' => 'Repeat password',
			'FORM.INPUT.PLATFORMS' => 'Platforms',
			'FORM.INPUT.REPLY' => 'Reply',
			'FORM.INPUT.MARK_AS_READ' => 'Mark as read',
			'FORM.INPUT.NEW_PASSWORD' => 'New password',
			'FORM.INPUT.USERNAME_EMAIL' => 'Username or Email',
			'FORM.BUTTONS.UPDATE_PASSWORD' => 'Update password',
			'FORM.VALIDATIONS.REQUIRED' => 'This field is required',
			'FORM.VALIDATIONS.REQUIRED_FIELD' => 'Required field',
			'FORM.VALIDATIONS.INVALID_FORMAT' => 'Invalid format',
			'FORM.VALIDATIONS.INVALID_INPUT' => 'Invalid input',
			'FORM.VALIDATIONS.TOO_SHORT' => 'Too short',
			'FORM.VALIDATIONS.TOO_LONG' => 'Too long',
			'FORM.VALIDATIONS.MIN_LENGTH' => ({required Object count}) => 'Minimum ${count} characters',
			'FORM.VALIDATIONS.MAX_LENGTH' => ({required Object count}) => 'Maximum ${count} characters',
			'FORM.VALIDATIONS.MIN_MAX_LENGTH' => ({required Object min, required Object max}) => 'Between ${min} and ${max} characters',
			'FORM.VALIDATIONS.ONLY_LETTERS' => 'Only letters allowed',
			'FORM.VALIDATIONS.ONLY_NUMBERS' => 'Only numbers allowed',
			'FORM.VALIDATIONS.LETTERS_AND_NUMBERS' => 'Only letters and numbers allowed',
			'FORM.VALIDATIONS.NO_SPECIAL_CHARS' => 'Special characters not allowed',
			'FORM.VALIDATIONS.INVALID_EMAIL' => 'Invalid email address',
			'FORM.VALIDATIONS.INVALID_EMAIL_FORMAT' => 'Invalid email format',
			'FORM.VALIDATIONS.INVALID_URL' => 'Invalid URL',
			'FORM.VALIDATIONS.INVALID_PHONE' => 'Invalid phone number',
			'FORM.VALIDATIONS.INVALID_DATE' => 'Invalid date',
			'FORM.VALIDATIONS.INVALID_TIME' => 'Invalid time',
			'FORM.VALIDATIONS.PASSWORDS_DONT_MATCH' => 'Passwords don\'t match',
			'FORM.VALIDATIONS.PASSWORD_TOO_WEAK' => 'Password too weak',
			'FORM.VALIDATIONS.PASSWORD_MIN_LENGTH' => ({required Object count}) => 'Password must be at least ${count} characters',
			'FORM.VALIDATIONS.PASSWORD_REQUIREMENTS' => 'Password must include uppercase, lowercase and numbers',
			'FORM.VALIDATIONS.USERNAME_INVALID' => 'Invalid username',
			'FORM.VALIDATIONS.USERNAME_TOO_SHORT' => 'Username too short',
			'FORM.VALIDATIONS.USERNAME_TOO_LONG' => 'Username too long',
			'FORM.VALIDATIONS.USERNAME_EXISTS' => 'This username already exists',
			'FORM.VALIDATIONS.EMAIL_EXISTS' => 'This email is already registered',
			'FORM.VALIDATIONS.INVALID_NAME' => 'Invalid name',
			'FORM.VALIDATIONS.NAME_TOO_LONG' => 'Name too long',
			'FORM.VALIDATIONS.INVALID_AGE' => 'Invalid age',
			'FORM.VALIDATIONS.MIN_AGE' => ({required Object age}) => 'Minimum age: ${age} years',
			'FORM.VALIDATIONS.MAX_AGE' => ({required Object age}) => 'Maximum age: ${age} years',
			'FORM.VALIDATIONS.NUMERIC_ONLY' => 'Numeric values only',
			'FORM.VALIDATIONS.POSITIVE_NUMBER' => 'Must be a positive number',
			'FORM.VALIDATIONS.INVALID_RANGE' => 'Value out of allowed range',
			'FORM.VALIDATIONS.MIN_VALUE' => ({required Object value}) => 'Minimum value: ${value}',
			'FORM.VALIDATIONS.MAX_VALUE' => ({required Object value}) => 'Maximum value: ${value}',
			'FORM.VALIDATIONS.WHITESPACE_NOT_ALLOWED' => 'Whitespace not allowed',
			'FORM.VALIDATIONS.MUST_CONTAIN_UPPERCASE' => 'Must contain at least one uppercase letter',
			'FORM.VALIDATIONS.MUST_CONTAIN_LOWERCASE' => 'Must contain at least one lowercase letter',
			'FORM.VALIDATIONS.MUST_CONTAIN_NUMBER' => 'Must contain at least one number',
			'FORM.VALIDATIONS.MUST_CONTAIN_SYMBOL' => 'Must contain at least one symbol',
			'FORM.VALIDATIONS.FIELD_REQUIRED' => 'Field required',
			'FORM.VALIDATIONS.PLEASE_FILL_FIELD' => 'Please fill this field',
			'FORM.VALIDATIONS.CHECK_INPUT' => 'Please check your input',
			'FORM.VALIDATIONS.INVALID_CHARACTERS' => 'Invalid characters',
			'FORM.VALIDATIONS.TEXT_TOO_SHORT' => 'Text too short',
			'FORM.VALIDATIONS.TEXT_TOO_LONG' => 'Text too long',
			'FORM.VALIDATIONS.INVALID_SELECTION' => 'Invalid selection',
			'FORM.VALIDATIONS.REQUIRED_SELECTION' => 'You must select an option',
			'FORM.VALIDATIONS.INVALID_LENGTH' => 'Invalid length',
			'FORM.VALIDATIONS.SELECT_PLATFORMS' => 'You need to select at least one platform',
			'RECOVER_PASSWORD.TITLE' => 'Recover your password',
			'RECOVER_PASSWORD.RECOVER_PASSWORD' => 'Recover password',
			'RECOVER_PASSWORD.EMAIL_SENDED' => 'Email sended!',
			'RECOVER_PASSWORD.ERROR_GETTING_INFO' => 'There was an error getting recovering password info',
			'RECOVER_PASSWORD.HOME_PAGE_REDIRECTING' => 'Redirecting to Home Page...',
			'RECOVER_PASSWORD.PASSWORD_UPDATED' => 'Password updated successfully',
			'LOGIN.WELCOME' => 'Welcome, Player',
			'LOGIN.BUTTON' => 'Login',
			'LOGIN.ERRORS.USER' => 'Not founded user',
			'LOGIN.ERRORS.PASSWORD' => 'No valid password',
			'LOGIN.FORGOT_PASSWORD' => 'Forgot password?',
			'LOGIN.SUBTITLE' => 'Don\'t have an account?',
			'LOGIN.SUB_REGISTER' => 'Register here',
			'CREATE_MATCH.TITLE' => 'Select the platform',
			'CREATE_MATCH.DESCRIPTION' => 'Description (optional)',
			'CREATE_MATCH.SEARCH_GAME' => 'Search game',
			'CREATE_MATCH.LOADING_RECOMENDATIONS' => 'Loading recommendations',
			'CREATE_MATCH.SEARCH_RESULTS' => 'Search\'s results',
			'CREATE_MATCH.EMPTY_SEARCH' => 'No founded games, please try another name',
			'CREATE_MATCH.SEARCH_HINT' => 'Type a bit more of the title to find your game',
			'CREATE_MATCH.SEARCH_ERROR' => 'Error searching games, please try again',
			'CREATE_MATCH.PLATFORMS_EMPTY' => 'You have not selected a platform',
			'CREATE_MATCH.ADD_PLATFORMS' => 'Press here for to add a platform',
			'CREATE_MATCH.SEARCHING' => 'Searching',
			'CREATE_MATCH.SEARCH_USER' => 'Invite partners to your match (optional)',
			'CREATE_MATCH.MATCH_NAME' => 'Match name (optional)',
			'CREATE_MATCH.INVITEDS' => 'Inviteds',
			'CREATE_MATCH.DATE' => 'Date',
			'CREATE_MATCH.TIME' => 'Time',
			'CREATE_MATCH.CLOCK_MESSAGE' => 'Press the clock',
			'CREATE_MATCH.SUBMIT' => 'Submit',
			'CREATE_MATCH.CREATE_MATCH' => 'Create Match!',
			'CREATE_MATCH.MATCH_CREATED' => 'Created Match!',
			'CREATE_MATCH.DATE_ERROR' => 'Create a correct date and time',
			'CREATE_MATCH.UPLOADING_MESSAGE' => 'The match is creating',
			'CREATE_MATCH.ERROR' => 'Error creating the match',
			'CREATE_MATCH.TITLE_EMPTY' => 'Title is required',
			'CREATE_MATCH.DURATION' => ({required Object duration}) => 'Duration: ${duration} minutes',
			'MATCH.MATCH_UPDATED' => 'Match updated',
			'MATCH.ERROR_LOADING' => 'Error loading match',
			'MATCH.JOIN_TO_MATCH' => 'Join to match',
			'MATCH.EDIT_MATCH' => 'Edit match',
			'MATCH.LEAVE_MATCH' => 'Leave match',
			'MATCH.CANCEL_MATCH' => 'Cancel match',
			'MATCH.CANCELL_MATCH_QUESTION' => 'Are you sure you want to cancel the match?',
			'MATCH.MATCH_CANCELLED' => 'Match cancelled',
			'MATCH.MATCH_ENDED' => 'Match ended',
			'MATCH.STATUS.WAITING' => 'Waiting',
			'MATCH.STATUS.RUNNING' => 'In progress',
			'MATCH.STATUS.FINISHED' => 'Finished',
			'MATCH.STATUS.CANCELLED' => 'Canceled',
			'SEARCH.TITLE' => 'Search',
			'SEARCH.SEARCH' => 'Search',
			'SEARCH.SEARCH_USERS' => 'Search users',
			'SEARCH.NO_RESULTS' => 'No results found',
			'SEARCH.ERROR_LOADING' => 'Error loading search results',
			'SEARCH.SEARCHING' => 'Searching...',
			'SEARCH.NO_USERS_FOUND' => 'No users found',
			'MATCHES.TITLE' => 'Matches',
			'MATCHES.ALL' => 'All',
			'MATCHES.CREATED' => 'Created',
			'MATCHES.JOINED' => 'Joined',
			'MATCHES.ERRORS.LOADING_ERROR' => 'Error loading matches',
			'MATCHES.ERRORS.NO_MATCHES' => 'No matches found',
			'MATCHES.ERRORS.JOIN_FAILED' => 'Failed to join the match',
			'CONNECTIONS.TITLE' => 'Connections',
			'CONNECTIONS.EMPTY' => 'No connections',
			'CONNECTIONS.LOADING' => 'Loading connections',
			'CONNECTIONS.ERRORS.LOADING_ERROR' => 'Error loading connections',
			'CONNECTIONS.ERRORS.NO_CONNECTIONS' => 'No connections found',
			'CONNECTIONS.HAVE_A_REQUEST' => ({required Object name}) => 'You have requested a connection to ${name}',
			'CONNECTIONS.REQUESTS.TITLE' => 'Requests',
			'CONNECTIONS.REQUESTS.ACCEPTED' => 'Accepted',
			'CONNECTIONS.REQUESTS.ADD' => 'Add',
			'CONNECTIONS.REQUESTS.REQUESTED' => 'Requested',
			'CONNECTIONS.REQUESTS.REJECTED' => 'Rejected',
			'CONNECTIONS.REQUESTS.PENDING' => 'Pending',
			'CONNECTIONS.REQUESTS.ACCEPT' => 'Accept',
			'CONNECTIONS.REQUESTS.REJECT' => 'Reject',
			'CONNECTIONS.REQUESTS.USER_WANTS_TO_CONNECT' => ({required Object name}) => '${name} wants to connect with you',
			'CONNECTIONS.REQUESTS.ACCEPT_REQUEST' => 'Accept request?',
			'CONNECTIONS.REQUESTS.WANT_TO_CANCELL' => 'Do you want to cancel the request?',
			'CONNECTIONS.REQUESTS.CANCEL' => 'Cancel request',
			'RECOMMENDATIONS.TITLE' => 'Recommendations',
			'RECOMMENDATIONS.EMPTY' => 'You haven\'t created any match for this playform yet \nSearch a game to create one!',
			'RECOMMENDATIONS.LOADING' => 'Loading recommendations',
			'RECOMMENDATIONS.FOR_YOU' => 'Recommendations for you',
			'RECOMMENDATIONS.ERRORS.LOADING' => 'Error loading recommendations',
			'CHAT.MESSAGES' => 'Messages',
			'CHAT.MESSAGE' => 'Message',
			'CHAT.NO_MESSAGES' => 'No messages',
			'CHAT.SAY_HI_TO' => ({required Object name}) => 'Say hi to ${name}',
			'CHAT.SAY_HI' => 'Say hi',
			'CHAT.ERRORS.LOADING_ERROR' => 'Error loading messages',
			'CHAT.ERRORS.LOADING_CHAT' => 'Error loading chat',
			'CHAT.ERRORS.NO_DATA' => 'No friendship data',
			'CHAT.ERRORS.LOADING_USER' => 'Error loading user',
			'CHAT.ERRORS.NO_USER_DATA' => 'No user data',
			'CHAT.TODAY' => 'Today',
			'CHAT.YESTERDAY' => 'Yesterday',
			'GAME.GAME' => 'Game',
			'GAME.MATCH' => 'Match',
			'GAME.DATE' => 'Date',
			'GAME.PLATFORM' => 'Platform',
			'NOTIFICATIONS.INVITATIONS' => 'Invitations',
			'NOTIFICATIONS.TITLE' => 'Notifications',
			'NOTIFICATIONS.EMPTY' => 'No notifications',
			'NOTIFICATIONS.ERROR_LOADING' => 'Error loading notifications',
			'NOTIFICATIONS.MATCH_INVITATION' => 'Match Invitation',
			'NOTIFICATIONS.INVITED_TO' => 'You are invited to',
			'NOTIFICATIONS.CONNECTION_REQUEST_TITLE' => 'New Ally!',
			'NOTIFICATIONS.CONNECTION_REQUEST' => ({required Object name}) => '${name} wants to join your team!',
			'NOTIFICATIONS.CONNECTION_ACCEPTED_TITLE' => 'Alliance Formed!',
			'NOTIFICATIONS.CONNECTION_ACCEPTED' => ({required Object name}) => '${name} has joined your team! You can now play together.',
			'NOTIFICATIONS.ACCEPT_REQUEST_TITLE' => 'Accept request?',
			'NOTIFICATIONS.INVITATION_TO_MATCH' => 'You have a new invitation to:',
			'NOTIFICATIONS.MATCH_READY' => 'Match ready',
			'NOTIFICATIONS.MATCH_STARTED' => ({required Object name}) => '${name} has started',
			'PROFILE.YOU' => 'You',
			'PROFILE.MATCHES' => 'Matches',
			'PROFILE.TITLE' => 'Profile',
			'PROFILE.PLATFORMS' => 'Your platforms',
			'PROFILE.MATCHES_PAGE.TITLE' => 'My matches',
			'PROFILE.MATCHES_PAGE.EMPTY' => 'You haven\'t created a match yet',
			'PROFILE.AVAILABILITY.EVERYONE' => 'Available',
			'PROFILE.AVAILABILITY.PARTNERS' => 'Partners Only',
			'PROFILE.AVAILABILITY.NO' => 'Unavailable',
			'PROFILE.USER_PAGE.NAME' => 'Name',
			'PROFILE.USER_PAGE.USERNAME' => 'Username',
			'PROFILE.USER_PAGE.EMAIL' => 'Email',
			'PROFILE.USER_PAGE.INVITATIONS.TITLE' => 'Accept invitations from:',
			'PROFILE.USER_PAGE.INVITATIONS.EVERYONE' => 'Whatever, i want to play',
			'PROFILE.USER_PAGE.INVITATIONS.PARTNERS' => 'Only my hommies',
			'PROFILE.USER_PAGE.INVITATIONS.NO' => 'Please, let me alone',
			'PROFILE.USER_PAGE.ERRORS.VERIFY' => 'Please verify your information',
			'PROFILE.USER_PAGE.ERRORS.EMAIL' => 'There is another user using this EMAIL',
			'PROFILE.USER_PAGE.ERRORS.USERNAME' => 'There is another user using this USERNAME',
			'PROFILE.USER_PAGE.ERRORS.IMG_SIZE' => 'The image size cant\' moore than 2mb',
			'PROFILE.USER_PAGE.ERRORS.IMG_EXTENSION' => 'The extension is not valid, please use: \'JPG\', \'PNG\', \'JPEG\'',
			'PROFILE.USER_PAGE.ERRORS.IMG_UPDATING' => 'Error updating the image',
			'PROFILE.USER_PAGE.ERRORS.ERROR_UPDATING' => 'Error updating',
			'PROFILE.USER_PAGE.UPLOADING_IMAGE' => 'Uploading image, wait a moment please',
			'PROFILE.USER_PAGE.UPDATED' => 'Updated!',
			'PROFILE.USER_PAGE.UPDATE' => 'Update',
			'PROFILE.USER_PAGE.DELETE_ACCOUNT' => 'Delete account',
			'PROFILE.USER_PAGE.ACCOUNT_DELETED' => 'Your account has been deleted',
			'PROFILE.PLATFORMS_PAGE.TITLE' => 'Your platforms',
			'PROFILE.PLATFORMS_PAGE.SUCCESS' => 'Updated platforms!',
			'FRIENDS.TITLE' => 'Friends',
			'FRIENDS.EMPTY' => 'You have no friends yet',
			'FRIENDS.ERROR_LOADING' => 'Error loading friends',
			'REPORTS.CREATED' => 'Report created',
			'REPORTS.REPORT_USER' => 'Report this user',
			'REPORTS.REPORT_TO' => 'Report to',
			'REPORTS.SELECT_TYPE' => 'Select report type',
			'REPORTS.APP_BUG' => 'App bug',
			'REPORTS.OTHER' => 'Other',
			'REPORTS.SPAM' => 'Spam',
			'REPORTS.CHILD_ABUSE' => 'Child abuse',
			'REPORTS.SUBMIT' => 'Submit report',
			'REPORTS.FEEDBACK' => 'Send feedback',
			'UTILS.SHOW_MORE' => 'Show more',
			'UTILS.SHOW_LESS' => 'Show less',
			'UTILS.DETAILS' => 'Details',
			'UTILS.ADMIN' => 'Admin',
			'UTILS.DESCRIPTION' => 'Description',
			'UTILS.SELECT_FILE' => 'Select file',
			'UTILS.FILE' => 'File',
			'UTILS.RELOAD' => 'Reload',
			'UTILS.RECOVERING_PASSWORD_FOR' => ({required Object name}) => 'Recovering password for ${name}',
			'UTILS.KEEPING_CONNECTIONS' => 'Keeping connections active',
			'UTILS.ACCEPT' => 'Accept',
			'UTILS.CANCEL' => 'Cancel',
			'UTILS.REJECT' => 'Reject',
			'UTILS.DISMISS' => 'Dismiss',
			'UTILS.YOU' => 'You',
			'UTILS.NO' => 'No',
			'UTILS.YES' => 'Yes',
			'ALERT.YOU_SURE' => 'Are you sure?',
			'ALERT.CANCEL' => 'Cancel',
			'ALERT.DELETE_MY_ACCOUNT' => 'Delete my account',
			'ERRORS.SERVER.USER_NOT_FOUND' => 'User not found',
			'ERRORS.SERVER.EMAIL_IN_USE' => 'Email in use',
			'ERRORS.SERVER.USERNAME_IN_USE' => 'Username in use',
			'ERRORS.SERVER.WRONG_PASSWORD' => 'Wrong password',
			'ERRORS.SERVER.NETWORK_ERROR' => 'Network error',
			'ERRORS.SERVER.NO_MATCH_FOUND' => 'No match found',
			'ERRORS.SERVER.NO_GAME_FOUND' => 'No game found',
			'ERRORS.SERVER.MISSING_TOKEN' => 'Missing authentication token',
			'ERRORS.SERVER.NO_MESSAGE' => 'No message',
			'ERRORS.SERVER.NOT_VALID_EXTENSION' => 'Not valid extension',
			'ERRORS.SERVER.INVALID_DATE' => 'Invalid date',
			'ERRORS.SERVER.REPORT_EXISTS' => 'Wait a minute \n You have reported this user',
			'ERRORS.SERVER.LOADING_GAME' => 'Error loading game, please try again',
			'ERRORS.SERVER.EMAIL_DATE_LIMIT' => 'You must wait at least 15 days to update your email',
			'ERRORS.SERVER.IMAGE_DATA' => 'There is a problem with the image data \n Please, try another image',
			'ERRORS.SERVER.INVALID_CREDENTIALS' => 'User or password incorrect',
			'ERRORS.SERVER.UNKNOWN' => 'Unknown error',
			'ERRORS.NETWORK.VERIFY_CONNECTION' => 'Verify your connection',
			'ERRORS.LOCAL.LOADING_USERS' => 'Error loading users',
			'ERRORS.LOCAL.LOADING_USER' => 'Error loading user',
			'ERRORS.UI.MAIN' => 'Something went wrong while rendering the UI. Please try reloading the app.',
			'ERRORS.UI.TECHNICAL_DETAILS' => 'Technical details',
			'SHARE.TITLE' => '⚡️ Share this match!',
			'SHARE.SUBJECT' => ({required Object name}) => '🎮 Let\'s play ${name}',
			'SHARE.TEXT' => ({required Object gameName, required Object match}) => '🎮 Let\'s play ${gameName} \n⚡️ Join now here: ${match}',
			'UPDATE.TITLE' => 'NEW VERSION!',
			'UPDATE.MESSAGE' => ({required Object version}) => 'Update madnolia to version ${version} to keep playing.',
			'UPDATE.BUTTON' => 'UPDATE NOW',
			_ => null,
		};
	}
}
