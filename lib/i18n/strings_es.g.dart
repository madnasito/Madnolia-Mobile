///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEs with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsPresentationEs PRESENTATION = _TranslationsPresentationEs._(_root);
	@override late final _TranslationsHeaderEs HEADER = _TranslationsHeaderEs._(_root);
	@override late final _TranslationsHomeEs HOME = _TranslationsHomeEs._(_root);
	@override late final _TranslationsRegisterEs REGISTER = _TranslationsRegisterEs._(_root);
	@override late final _TranslationsFormEs FORM = _TranslationsFormEs._(_root);
	@override late final _TranslationsRecoverPasswordEs RECOVER_PASSWORD = _TranslationsRecoverPasswordEs._(_root);
	@override late final _TranslationsLoginEs LOGIN = _TranslationsLoginEs._(_root);
	@override late final _TranslationsCreateMatchEs CREATE_MATCH = _TranslationsCreateMatchEs._(_root);
	@override late final _TranslationsMatchEs MATCH = _TranslationsMatchEs._(_root);
	@override late final _TranslationsSearchEs SEARCH = _TranslationsSearchEs._(_root);
	@override late final _TranslationsMatchesEs MATCHES = _TranslationsMatchesEs._(_root);
	@override late final _TranslationsConnectionsEs CONNECTIONS = _TranslationsConnectionsEs._(_root);
	@override late final _TranslationsRecommendationsEs RECOMMENDATIONS = _TranslationsRecommendationsEs._(_root);
	@override late final _TranslationsChatEs CHAT = _TranslationsChatEs._(_root);
	@override late final _TranslationsGameEs GAME = _TranslationsGameEs._(_root);
	@override late final _TranslationsNotificationsEs NOTIFICATIONS = _TranslationsNotificationsEs._(_root);
	@override late final _TranslationsFriendsEs FRIENDS = _TranslationsFriendsEs._(_root);
	@override late final _TranslationsProfileEs PROFILE = _TranslationsProfileEs._(_root);
	@override late final _TranslationsReportsEs REPORTS = _TranslationsReportsEs._(_root);
	@override late final _TranslationsUtilsEs UTILS = _TranslationsUtilsEs._(_root);
	@override late final _TranslationsAlertEs ALERT = _TranslationsAlertEs._(_root);
	@override late final _TranslationsErrorsEs ERRORS = _TranslationsErrorsEs._(_root);
	@override late final _TranslationsShareEs SHARE = _TranslationsShareEs._(_root);
	@override late final _TranslationsUpdateEs UPDATE = _TranslationsUpdateEs._(_root);
}

// Path: PRESENTATION
class _TranslationsPresentationEs implements TranslationsPresentationEn {
	_TranslationsPresentationEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Conecta con gamers de todo el mundo';
	@override String get SUBTITLE => 'Crea partidas para cualquier consola retro o moderna';
}

// Path: HEADER
class _TranslationsHeaderEs implements TranslationsHeaderEn {
	_TranslationsHeaderEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get PLATFORMS => 'Plataformas';
	@override String get MATCH => 'Crear partida';
	@override String get NOTIFICATIONS => 'Notificaciones';
	@override String get INVITATIONS => 'Invitations';
	@override String get JOINED_MATCHES => 'Partidas ingresadas';
	@override String get REGISTER => 'Registrarse';
	@override String get LOGIN => 'Ingresar';
	@override String get PROFILE => 'Perfil';
	@override String get SETTINGS => 'Ajustes';
	@override String get LOGOUT => 'Salir';
}

// Path: HOME
class _TranslationsHomeEs implements TranslationsHomeEn {
	_TranslationsHomeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get MATCH => 'Partida creada';
	@override String get MATCHES => 'Partidas creadas';
	@override String get CREATE => 'Crea una aquí';
	@override String get NO_MATCHES => 'Aun no hay alguna partida creada';
	@override String get NO_MATCHES_FOR => 'Sin partidas';
	@override String get ERROR_LOADING_MATCHES => 'Error cargando partidas';
}

// Path: REGISTER
class _TranslationsRegisterEs implements TranslationsRegisterEn {
	_TranslationsRegisterEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Crear cuenta';
	@override String get NAME => 'Nombre';
	@override String get USERNAME => 'Nombre de usuario';
	@override String get EMAIL => 'Correo';
	@override String get PASSWORD => 'Contraseña';
	@override String get PASSWORD2 => 'Repita la Contraseña';
	@override late final _TranslationsRegisterValidationsEs VALIDATIONS = _TranslationsRegisterValidationsEs._(_root);
	@override String get SELECT_PLATFORMS => 'Selecciona tus plataformas de juegos';
	@override String get PHONE => 'Movil';
	@override String get SUBTITLE => '¿Ya tienes una cuenta?';
	@override String get SUB_LOGIN => ' Inicia sesión';
	@override String get NEXT => 'Siguiente';
	@override String get TOAST_SIGN_UP => '¡Perfecto! Registro exitoso';
	@override String get SELECT_PLATFORMS_SUBTITLE => 'Tus plataformas seleccionadas brillarán';
}

// Path: FORM
class _TranslationsFormEs implements TranslationsFormEn {
	_TranslationsFormEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsFormInputEs INPUT = _TranslationsFormInputEs._(_root);
	@override late final _TranslationsFormButtonsEs BUTTONS = _TranslationsFormButtonsEs._(_root);
	@override late final _TranslationsFormValidationsEs VALIDATIONS = _TranslationsFormValidationsEs._(_root);
}

// Path: RECOVER_PASSWORD
class _TranslationsRecoverPasswordEs implements TranslationsRecoverPasswordEn {
	_TranslationsRecoverPasswordEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Recupera tu contraseña';
	@override String get RECOVER_PASSWORD => 'Recuperar contraseña';
	@override String get EMAIL_SENDED => '¡Correo enviado!';
	@override String get ERROR_GETTING_INFO => 'Hubo un error al cargar la recuperacion de contraseña';
	@override String get HOME_PAGE_REDIRECTING => 'Redirigiendo a la pagina principal...';
	@override String get PASSWORD_UPDATED => 'Contraseña actualizada exitosamente';
}

// Path: LOGIN
class _TranslationsLoginEs implements TranslationsLoginEn {
	_TranslationsLoginEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get WELCOME => 'Ingresar';
	@override String get BUTTON => 'Iniciar Sesión';
	@override late final _TranslationsLoginErrorsEs ERRORS = _TranslationsLoginErrorsEs._(_root);
	@override String get FORGOT_PASSWORD => '¿Olvido la contraseña?';
	@override String get SUBTITLE => '¿No tienes una cuenta?';
	@override String get SUB_REGISTER => 'Regístrate aquí';
}

// Path: CREATE_MATCH
class _TranslationsCreateMatchEs implements TranslationsCreateMatchEn {
	_TranslationsCreateMatchEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Selecciona la plataforma';
	@override String get DESCRIPTION => 'Descripción (opcional)';
	@override String get SEARCH_GAME => 'Buscar juego';
	@override String get LOADING_RECOMENDATIONS => 'Cargando recomendaciones';
	@override String get SEARCH_RESULTS => 'Resultados de la busqueda';
	@override String get EMPTY_SEARCH => 'No se encontraron juegos, por favor intente con otro nombre';
	@override String get SEARCH_HINT => 'Escribe un poco más del título para encontrar tu juego';
	@override String get SEARCH_ERROR => 'Error al buscar juegos, por favor intente de nuevo';
	@override String get PLATFORMS_EMPTY => 'No has seleccionado una plataforma';
	@override String get ADD_PLATFORMS => 'Ingresa aquí para añadir plataformas';
	@override String get SEARCHING => 'Buscando';
	@override String get SEARCH_USER => 'Invitar compañeros a tu partida (opcional)';
	@override String get MATCH_NAME => 'Nombre de la partida (opcional)';
	@override String get INVITEDS => 'Invitados';
	@override String get DATE => 'Fecha';
	@override String get TIME => 'Hora';
	@override String get CLOCK_MESSAGE => 'Presiona el reloj';
	@override String get SUBMIT => 'Enviar';
	@override String get CREATE_MATCH => 'Crear partida';
	@override String get MATCH_CREATED => '¡Partida creada!';
	@override String get DATE_ERROR => 'Cree una fecha y hora correctas';
	@override String get UPLOADING_MESSAGE => 'La partida se está creando';
	@override String get ERROR => 'Error creando la partida, por favor intente de nuevo';
	@override String get TITLE_EMPTY => 'Escriba el titulo';
	@override String DURATION({required Object duration}) => 'Duración: ${duration} minutos';
}

// Path: MATCH
class _TranslationsMatchEs implements TranslationsMatchEn {
	_TranslationsMatchEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get MATCH_UPDATED => 'Partida actualizada';
	@override String get ERROR_LOADING => 'Error cargando partida';
	@override String get JOIN_TO_MATCH => 'Unirse a la partida';
	@override String get EDIT_MATCH => 'Editar partida';
	@override String get LEAVE_MATCH => 'Salir de la partida';
	@override String get CANCEL_MATCH => 'Cancelar partida';
	@override String get CANCELL_MATCH_QUESTION => '¿Estás seguro de que deseas cancelar la partida?';
	@override String get MATCH_CANCELLED => 'Partida cancelada';
	@override String get MATCH_ENDED => 'Partida finalizada';
	@override late final _TranslationsMatchStatusEs STATUS = _TranslationsMatchStatusEs._(_root);
}

// Path: SEARCH
class _TranslationsSearchEs implements TranslationsSearchEn {
	_TranslationsSearchEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Buscar';
	@override String get SEARCH => 'Buscar';
	@override String get SEARCH_USERS => 'Buscar usuarios';
	@override String get NO_RESULTS => 'No se encontraron resultados';
	@override String get ERROR_LOADING => 'Error cargando resultados de búsqueda';
	@override String get SEARCHING => 'Buscando...';
	@override String get NO_USERS_FOUND => 'No se encontraron usuarios';
}

// Path: MATCHES
class _TranslationsMatchesEs implements TranslationsMatchesEn {
	_TranslationsMatchesEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Partidas';
	@override String get ALL => 'Todas';
	@override String get CREATED => 'Creadas';
	@override String get JOINED => 'Ingresadas';
	@override late final _TranslationsMatchesErrorsEs ERRORS = _TranslationsMatchesErrorsEs._(_root);
}

// Path: CONNECTIONS
class _TranslationsConnectionsEs implements TranslationsConnectionsEn {
	_TranslationsConnectionsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Conexiones';
	@override String get EMPTY => 'Sin conexiones';
	@override String get LOADING => 'Cargando conexiones';
	@override late final _TranslationsConnectionsErrorsEs ERRORS = _TranslationsConnectionsErrorsEs._(_root);
	@override String HAVE_A_REQUEST({required Object name}) => 'Tienes una solicitud para ${name}';
	@override late final _TranslationsConnectionsRequestsEs REQUESTS = _TranslationsConnectionsRequestsEs._(_root);
}

// Path: RECOMMENDATIONS
class _TranslationsRecommendationsEs implements TranslationsRecommendationsEn {
	_TranslationsRecommendationsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Recomendaciones';
	@override String get EMPTY => 'Aun no has creado una partida para esta plataforma \n Busca un juego para crear una';
	@override String get LOADING => 'Cargando recomendaciones';
	@override String get FOR_YOU => 'Recomendaciones para ti';
	@override late final _TranslationsRecommendationsErrorsEs ERRORS = _TranslationsRecommendationsErrorsEs._(_root);
}

// Path: CHAT
class _TranslationsChatEs implements TranslationsChatEn {
	_TranslationsChatEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get MESSAGES => 'Mensajes';
	@override String get MESSAGE => 'Mensaje';
	@override String get NO_MESSAGES => 'Sin mensajes';
	@override String SAY_HI_TO({required Object name}) => 'Di hola a ${name}';
	@override String get SAY_HI => 'Saluda';
	@override late final _TranslationsChatErrorsEs ERRORS = _TranslationsChatErrorsEs._(_root);
	@override String get TODAY => 'Hoy';
	@override String get YESTERDAY => 'Ayer';
}

// Path: GAME
class _TranslationsGameEs implements TranslationsGameEn {
	_TranslationsGameEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get GAME => 'Juego';
	@override String get MATCH => 'Partida';
	@override String get DATE => 'Fecha';
	@override String get PLATFORM => 'Plataforma';
}

// Path: NOTIFICATIONS
class _TranslationsNotificationsEs implements TranslationsNotificationsEn {
	_TranslationsNotificationsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get INVITATIONS => 'Invitaciones';
	@override String get TITLE => 'Notificaciones';
	@override String get EMPTY => 'Sin notificaciones';
	@override String get ERROR_LOADING => 'Error cargando notificaciones';
	@override String get MATCH_INVITATION => 'Invitacion a partida';
	@override String get INVITED_TO => 'Fuiste invitado a:';
	@override String CONNECTION_REQUEST({required Object name}) => '${name} quiere conectar contigo';
	@override String get ACCEPT_REQUEST_TITLE => '¿Aceptar solicitud?';
	@override String get INVITATION_TO_MATCH => 'Tienes una invitacion para: ';
	@override String get MATCH_READY => 'Partida lista';
	@override String MATCH_STARTED({required Object name}) => '${name} ha empezado';
}

// Path: FRIENDS
class _TranslationsFriendsEs implements TranslationsFriendsEn {
	_TranslationsFriendsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Amigos';
	@override String get EMPTY => 'Aun no tienes amigos';
	@override String get ERROR_LOADING => 'Error cargando amigos';
}

// Path: PROFILE
class _TranslationsProfileEs implements TranslationsProfileEn {
	_TranslationsProfileEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get YOU => 'Perfil';
	@override String get TITLE => 'Perfil';
	@override String get MATCHES => 'Partidas';
	@override String get PLATFORMS => 'Tus plataformas';
	@override late final _TranslationsProfileMatchesPageEs MATCHES_PAGE = _TranslationsProfileMatchesPageEs._(_root);
	@override late final _TranslationsProfileAvailabilityEs AVAILABILITY = _TranslationsProfileAvailabilityEs._(_root);
	@override late final _TranslationsProfileUserPageEs USER_PAGE = _TranslationsProfileUserPageEs._(_root);
	@override late final _TranslationsProfilePlatformsPageEs PLATFORMS_PAGE = _TranslationsProfilePlatformsPageEs._(_root);
}

// Path: REPORTS
class _TranslationsReportsEs implements TranslationsReportsEn {
	_TranslationsReportsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get CREATED => 'Reporte creado';
	@override String get REPORT_USER => 'Reportar este usuario';
	@override String get REPORT_TO => 'Reportar a';
	@override String get SELECT_TYPE => 'Selecciona el tipo';
	@override String get APP_BUG => 'Bug de la aplicación';
	@override String get OTHER => 'Otro';
	@override String get SPAM => 'Spam';
	@override String get CHILD_ABUSE => 'Abuso de menores';
	@override String get SUBMIT => 'Subir reporte';
	@override String get FEEDBACK => 'Enviar reporte';
}

// Path: UTILS
class _TranslationsUtilsEs implements TranslationsUtilsEn {
	_TranslationsUtilsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get SHOW_MORE => 'Mostrar más';
	@override String get SHOW_LESS => 'Mostrar menos';
	@override String get DETAILS => 'Detalles';
	@override String get ADMIN => 'Admin';
	@override String get DESCRIPTION => 'Descripción';
	@override String get SELECT_FILE => 'Seleccionar archivo';
	@override String get FILE => 'Archivo';
	@override String get RELOAD => 'Recargar';
	@override String RECOVERING_PASSWORD_FOR({required Object name}) => 'Recuperando contraseña para ${name}';
	@override String get KEEPING_CONNECTIONS => 'Manteniendo conexiones activas';
	@override String get ACCEPT => 'Aceptar';
	@override String get CANCEL => 'Cancelar';
	@override String get REJECT => 'Rechazar';
	@override String get DISMISS => 'Descartar';
	@override String get YOU => 'Tu';
	@override String get NO => 'No';
	@override String get YES => 'Si';
}

// Path: ALERT
class _TranslationsAlertEs implements TranslationsAlertEn {
	_TranslationsAlertEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get YOU_SURE => '¿Estás seguro?';
	@override String get CANCEL => 'Cancelar';
	@override String get DELETE_MY_ACCOUNT => 'Borrar mi cuenta';
}

// Path: ERRORS
class _TranslationsErrorsEs implements TranslationsErrorsEn {
	_TranslationsErrorsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsErrorsServerEs SERVER = _TranslationsErrorsServerEs._(_root);
	@override late final _TranslationsErrorsNetworkEs NETWORK = _TranslationsErrorsNetworkEs._(_root);
	@override late final _TranslationsErrorsLocalEs LOCAL = _TranslationsErrorsLocalEs._(_root);
	@override late final _TranslationsErrorsUiEs UI = _TranslationsErrorsUiEs._(_root);
}

// Path: SHARE
class _TranslationsShareEs implements TranslationsShareEn {
	_TranslationsShareEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => '⚡️ ¡Comparte esta partida!';
	@override String SUBJECT({required Object name}) => '🎮 Juguemos ${name}';
	@override String TEXT({required Object gameName, required Object match}) => '🎮 Juguemos ${gameName} \n⚡️ Unete aqui: ${match}';
}

// Path: UPDATE
class _TranslationsUpdateEs implements TranslationsUpdateEn {
	_TranslationsUpdateEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => '¡NUEVA VERSIÓN!';
	@override String MESSAGE({required Object version}) => 'Actualiza madnolia a la versión ${version} para seguir jugando.';
	@override String get BUTTON => 'ACTUALIZAR AHORA';
}

// Path: REGISTER.VALIDATIONS
class _TranslationsRegisterValidationsEs implements TranslationsRegisterValidationsEn {
	_TranslationsRegisterValidationsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get NAME => 'El nombre no es valido';
	@override String get LONG_NAME => 'El nombre es muy largo';
	@override String get USERNAME => 'El nombre de usuario no es valido';
	@override String get EMAIL => 'Ingrese una dirección de correo correcta';
	@override String get PASSWORD => 'La contraseña es muy corta';
	@override String get PASSWORD2 => 'Las contraseñas son diferentes';
}

// Path: FORM.INPUT
class _TranslationsFormInputEs implements TranslationsFormInputEn {
	_TranslationsFormInputEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get NAME => 'Nombre';
	@override String get USERNAME => 'Nombre de usuario';
	@override String get EMAIL => 'Correo';
	@override String get PASSWORD => 'Contraseña';
	@override String get PASSWORD2 => 'Repita la Contraseña';
	@override String get PLATFORMS => 'Plataformas';
	@override String get REPLY => 'Responder';
	@override String get MARK_AS_READ => 'Marcar como leido';
	@override String get NEW_PASSWORD => 'Nueva contraseña';
	@override String get USERNAME_EMAIL => 'Nombre de Usuario o Correo';
}

// Path: FORM.BUTTONS
class _TranslationsFormButtonsEs implements TranslationsFormButtonsEn {
	_TranslationsFormButtonsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get UPDATE_PASSWORD => 'Actualizar contraseña';
}

// Path: FORM.VALIDATIONS
class _TranslationsFormValidationsEs implements TranslationsFormValidationsEn {
	_TranslationsFormValidationsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get REQUIRED => 'Este campo es requerido';
	@override String get REQUIRED_FIELD => 'Campo requerido';
	@override String get INVALID_FORMAT => 'Formato no válido';
	@override String get INVALID_INPUT => 'Entrada no válida';
	@override String get TOO_SHORT => 'Muy corto';
	@override String get TOO_LONG => 'Muy largo';
	@override String MIN_LENGTH({required Object count}) => 'Mínimo ${count} caracteres';
	@override String MAX_LENGTH({required Object count}) => 'Máximo ${count} caracteres';
	@override String MIN_MAX_LENGTH({required Object min, required Object max}) => 'Entre ${min} y ${max} caracteres';
	@override String get ONLY_LETTERS => 'Solo letras permitidas';
	@override String get ONLY_NUMBERS => 'Solo números permitidos';
	@override String get LETTERS_AND_NUMBERS => 'Solo letras y números permitidos';
	@override String get NO_SPECIAL_CHARS => 'No se permiten caracteres especiales';
	@override String get INVALID_EMAIL => 'Correo electrónico no válido';
	@override String get INVALID_EMAIL_FORMAT => 'Formato de correo inválido';
	@override String get INVALID_URL => 'URL no válida';
	@override String get INVALID_PHONE => 'Número de teléfono no válido';
	@override String get INVALID_DATE => 'Fecha no válida';
	@override String get INVALID_TIME => 'Hora no válida';
	@override String get PASSWORDS_DONT_MATCH => 'Las contraseñas no coinciden';
	@override String get PASSWORD_TOO_WEAK => 'Contraseña muy débil';
	@override String PASSWORD_MIN_LENGTH({required Object count}) => 'La contraseña debe tener al menos ${count} caracteres';
	@override String get PASSWORD_REQUIREMENTS => 'La contraseña debe incluir mayúsculas, minúsculas y números';
	@override String get USERNAME_INVALID => 'Nombre de usuario no válido';
	@override String get USERNAME_TOO_SHORT => 'Nombre de usuario muy corto';
	@override String get USERNAME_TOO_LONG => 'Nombre de usuario muy largo';
	@override String get USERNAME_EXISTS => 'Este nombre de usuario ya existe';
	@override String get EMAIL_EXISTS => 'Este correo ya está registrado';
	@override String get INVALID_NAME => 'Nombre no válido';
	@override String get NAME_TOO_LONG => 'Nombre muy largo';
	@override String get INVALID_AGE => 'Edad no válida';
	@override String MIN_AGE({required Object age}) => 'Edad mínima: ${age} años';
	@override String MAX_AGE({required Object age}) => 'Edad máxima: ${age} años';
	@override String get NUMERIC_ONLY => 'Solo valores numéricos';
	@override String get POSITIVE_NUMBER => 'Debe ser un número positivo';
	@override String get INVALID_RANGE => 'Valor fuera del rango permitido';
	@override String MIN_VALUE({required Object value}) => 'Valor mínimo: ${value}';
	@override String MAX_VALUE({required Object value}) => 'Valor máximo: ${value}';
	@override String get WHITESPACE_NOT_ALLOWED => 'No se permiten espacios en blanco';
	@override String get MUST_CONTAIN_UPPERCASE => 'Debe contener al menos una mayúscula';
	@override String get MUST_CONTAIN_LOWERCASE => 'Debe contener al menos una minúscula';
	@override String get MUST_CONTAIN_NUMBER => 'Debe contener al menos un número';
	@override String get MUST_CONTAIN_SYMBOL => 'Debe contener al menos un símbolo';
	@override String get FIELD_REQUIRED => 'Campo obligatorio';
	@override String get PLEASE_FILL_FIELD => 'Por favor completa este campo';
	@override String get CHECK_INPUT => 'Revisa la información ingresada';
	@override String get INVALID_CHARACTERS => 'Caracteres no válidos';
	@override String get TEXT_TOO_SHORT => 'Texto muy corto';
	@override String get TEXT_TOO_LONG => 'Texto muy largo';
	@override String get INVALID_SELECTION => 'Selección no válida';
	@override String get REQUIRED_SELECTION => 'Debes seleccionar una opción';
	@override String get INVALID_LENGTH => 'Longitud no válida';
	@override String get SELECT_PLATFORMS => 'Necesitas seleccionar al menos una plataforma';
}

// Path: LOGIN.ERRORS
class _TranslationsLoginErrorsEs implements TranslationsLoginErrorsEn {
	_TranslationsLoginErrorsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get USER => 'No se ha encontrado al usuario';
	@override String get PASSWORD => 'La contraseña es invalida';
}

// Path: MATCH.STATUS
class _TranslationsMatchStatusEs implements TranslationsMatchStatusEn {
	_TranslationsMatchStatusEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get WAITING => 'En espera';
	@override String get RUNNING => 'En curso';
	@override String get FINISHED => 'Finalizada';
	@override String get CANCELLED => 'Cancelada';
}

// Path: MATCHES.ERRORS
class _TranslationsMatchesErrorsEs implements TranslationsMatchesErrorsEn {
	_TranslationsMatchesErrorsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get LOADING_ERROR => 'Error cargando partidas';
	@override String get NO_MATCHES => 'No hay partidas';
	@override String get JOIN_FAILED => 'Error al ingresar a la partida';
}

// Path: CONNECTIONS.ERRORS
class _TranslationsConnectionsErrorsEs implements TranslationsConnectionsErrorsEn {
	_TranslationsConnectionsErrorsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get LOADING_ERROR => 'Error cargando conexiones';
	@override String get NO_CONNECTIONS => 'Sin conexiones';
}

// Path: CONNECTIONS.REQUESTS
class _TranslationsConnectionsRequestsEs implements TranslationsConnectionsRequestsEn {
	_TranslationsConnectionsRequestsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Solicitudes';
	@override String get ACCEPTED => 'Aceptada';
	@override String get ADD => 'Añadir';
	@override String get REQUESTED => 'Solicitada';
	@override String get REJECTED => 'Rechazada';
	@override String get PENDING => 'Pendiente';
	@override String get ACCEPT => 'Aceptar';
	@override String get REJECT => 'Rechazar';
	@override String USER_WANTS_TO_CONNECT({required Object name}) => '${name} quiere conectar contigo';
	@override String get ACCEPT_REQUEST => '¿Aceptar solicitud?';
	@override String get WANT_TO_CANCELL => '¿Deseas cancelar la solicitud?';
	@override String get CANCEL => 'Cancelar solicitud';
}

// Path: RECOMMENDATIONS.ERRORS
class _TranslationsRecommendationsErrorsEs implements TranslationsRecommendationsErrorsEn {
	_TranslationsRecommendationsErrorsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get LOADING => 'Error cargando recomendaciones';
}

// Path: CHAT.ERRORS
class _TranslationsChatErrorsEs implements TranslationsChatErrorsEn {
	_TranslationsChatErrorsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get LOADING_ERROR => 'Error cargando mensajes';
	@override String get LOADING_CHAT => 'Error cargando el chat';
	@override String get NO_DATA => 'Sin datos de amistad';
	@override String get LOADING_USER => 'Error cargando usuario';
	@override String get NO_USER_DATA => 'Sin datos del usuario';
}

// Path: PROFILE.MATCHES_PAGE
class _TranslationsProfileMatchesPageEs implements TranslationsProfileMatchesPageEn {
	_TranslationsProfileMatchesPageEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Mis partidas';
	@override String get EMPTY => 'Aun no has creado una partida';
}

// Path: PROFILE.AVAILABILITY
class _TranslationsProfileAvailabilityEs implements TranslationsProfileAvailabilityEn {
	_TranslationsProfileAvailabilityEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get EVERYONE => 'Disponible';
	@override String get PARTNERS => 'Solo colegas';
	@override String get NO => 'No molestar';
}

// Path: PROFILE.USER_PAGE
class _TranslationsProfileUserPageEs implements TranslationsProfileUserPageEn {
	_TranslationsProfileUserPageEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get NAME => 'Nombre';
	@override String get USERNAME => 'Nombre de usuario';
	@override String get EMAIL => 'Correo';
	@override late final _TranslationsProfileUserPageInvitationsEs INVITATIONS = _TranslationsProfileUserPageInvitationsEs._(_root);
	@override late final _TranslationsProfileUserPageErrorsEs ERRORS = _TranslationsProfileUserPageErrorsEs._(_root);
	@override String get UPLOADING_IMAGE => 'Subiendo la imagen, espere un momento por favor';
	@override String get UPDATED => 'Datos actualizados';
	@override String get UPDATE => 'Actualizar';
	@override String get DELETE_ACCOUNT => 'Eliminar cuenta';
	@override String get ACCOUNT_DELETED => 'Tu cuenta ha sido borrada';
}

// Path: PROFILE.PLATFORMS_PAGE
class _TranslationsProfilePlatformsPageEs implements TranslationsProfilePlatformsPageEn {
	_TranslationsProfilePlatformsPageEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Tus plataformas';
	@override String get SUCCESS => '¡Plataformas actualizadas!';
}

// Path: ERRORS.SERVER
class _TranslationsErrorsServerEs implements TranslationsErrorsServerEn {
	_TranslationsErrorsServerEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get USER_NOT_FOUND => 'Usuario no encontrado';
	@override String get EMAIL_IN_USE => 'Email en uso';
	@override String get USERNAME_IN_USE => 'Nombre de usuario en uso';
	@override String get WRONG_PASSWORD => 'Contraseña incorrecta';
	@override String get NETWORK_ERROR => 'Error en la red';
	@override String get NO_MATCH_FOUND => 'No hay partida encontrada';
	@override String get NO_GAME_FOUND => 'Juego no encontrado';
	@override String get MISSING_TOKEN => 'Falta el token';
	@override String get NO_MESSAGE => 'No hay mensaje';
	@override String get NOT_VALID_EXTENSION => 'Extensión no valida';
	@override String get INVALID_DATE => 'Fecha invalida';
	@override String get REPORT_EXISTS => 'Espera \n Ya has reportado a este usuario';
	@override String get LOADING_GAME => 'Error cargando el juego, vuelva a intentarlo';
	@override String get EMAIL_DATE_LIMIT => 'Debe esperar al menos 15 dias para poder actualizar su correo';
	@override String get IMAGE_DATA => 'Hubo un problema al cargar esta imagen \nPor favor, suba otra imagen';
	@override String get INVALID_CREDENTIALS => 'Usuario o contraseña incorrectos';
	@override String get UNKNOWN => 'Error desconocido';
}

// Path: ERRORS.NETWORK
class _TranslationsErrorsNetworkEs implements TranslationsErrorsNetworkEn {
	_TranslationsErrorsNetworkEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get VERIFY_CONNECTION => 'Verifica tu conexión';
}

// Path: ERRORS.LOCAL
class _TranslationsErrorsLocalEs implements TranslationsErrorsLocalEn {
	_TranslationsErrorsLocalEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get LOADING_USERS => 'Error cargando usuarios';
	@override String get LOADING_USER => 'Error cargando usuario';
}

// Path: ERRORS.UI
class _TranslationsErrorsUiEs implements TranslationsErrorsUiEn {
	_TranslationsErrorsUiEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get MAIN => 'Algo salió mal al renderizar la UI. Por favor, recarga la app.';
	@override String get TECHNICAL_DETAILS => 'Detalles técnicos';
}

// Path: PROFILE.USER_PAGE.INVITATIONS
class _TranslationsProfileUserPageInvitationsEs implements TranslationsProfileUserPageInvitationsEn {
	_TranslationsProfileUserPageInvitationsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get TITLE => 'Aceptar invitaciondes de:';
	@override String get EVERYONE => 'Lo que sea, quiero jugar';
	@override String get PARTNERS => 'Solo colegas';
	@override String get NO => 'Ya, dejame en paz';
}

// Path: PROFILE.USER_PAGE.ERRORS
class _TranslationsProfileUserPageErrorsEs implements TranslationsProfileUserPageErrorsEn {
	_TranslationsProfileUserPageErrorsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get VERIFY => 'Por favor verifica tú información';
	@override String get EMAIL => 'Ya hay una cuenta registrada con este CORREO';
	@override String get USERNAME => 'Ya hay otro usuario usando este NOMBRE DE USUARIO';
	@override String get IMG_SIZE => 'La imagen no puede ser mayor de 2MB';
	@override String get IMG_EXTENSION => 'La extensión no es valida, por favor usa: \'JPG\', \'JPEG\'. \'PNG\'';
	@override String get IMG_UPDATING => 'Error actualizando la imagen';
	@override String get ERROR_UPDATING => 'Error actualizando';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'PRESENTATION.TITLE' => 'Conecta con gamers de todo el mundo',
			'PRESENTATION.SUBTITLE' => 'Crea partidas para cualquier consola retro o moderna',
			'HEADER.PLATFORMS' => 'Plataformas',
			'HEADER.MATCH' => 'Crear partida',
			'HEADER.NOTIFICATIONS' => 'Notificaciones',
			'HEADER.INVITATIONS' => 'Invitations',
			'HEADER.JOINED_MATCHES' => 'Partidas ingresadas',
			'HEADER.REGISTER' => 'Registrarse',
			'HEADER.LOGIN' => 'Ingresar',
			'HEADER.PROFILE' => 'Perfil',
			'HEADER.SETTINGS' => 'Ajustes',
			'HEADER.LOGOUT' => 'Salir',
			'HOME.MATCH' => 'Partida creada',
			'HOME.MATCHES' => 'Partidas creadas',
			'HOME.CREATE' => 'Crea una aquí',
			'HOME.NO_MATCHES' => 'Aun no hay alguna partida creada',
			'HOME.NO_MATCHES_FOR' => 'Sin partidas',
			'HOME.ERROR_LOADING_MATCHES' => 'Error cargando partidas',
			'REGISTER.TITLE' => 'Crear cuenta',
			'REGISTER.NAME' => 'Nombre',
			'REGISTER.USERNAME' => 'Nombre de usuario',
			'REGISTER.EMAIL' => 'Correo',
			'REGISTER.PASSWORD' => 'Contraseña',
			'REGISTER.PASSWORD2' => 'Repita la Contraseña',
			'REGISTER.VALIDATIONS.NAME' => 'El nombre no es valido',
			'REGISTER.VALIDATIONS.LONG_NAME' => 'El nombre es muy largo',
			'REGISTER.VALIDATIONS.USERNAME' => 'El nombre de usuario no es valido',
			'REGISTER.VALIDATIONS.EMAIL' => 'Ingrese una dirección de correo correcta',
			'REGISTER.VALIDATIONS.PASSWORD' => 'La contraseña es muy corta',
			'REGISTER.VALIDATIONS.PASSWORD2' => 'Las contraseñas son diferentes',
			'REGISTER.SELECT_PLATFORMS' => 'Selecciona tus plataformas de juegos',
			'REGISTER.PHONE' => 'Movil',
			'REGISTER.SUBTITLE' => '¿Ya tienes una cuenta?',
			'REGISTER.SUB_LOGIN' => ' Inicia sesión',
			'REGISTER.NEXT' => 'Siguiente',
			'REGISTER.TOAST_SIGN_UP' => '¡Perfecto! Registro exitoso',
			'REGISTER.SELECT_PLATFORMS_SUBTITLE' => 'Tus plataformas seleccionadas brillarán',
			'FORM.INPUT.NAME' => 'Nombre',
			'FORM.INPUT.USERNAME' => 'Nombre de usuario',
			'FORM.INPUT.EMAIL' => 'Correo',
			'FORM.INPUT.PASSWORD' => 'Contraseña',
			'FORM.INPUT.PASSWORD2' => 'Repita la Contraseña',
			'FORM.INPUT.PLATFORMS' => 'Plataformas',
			'FORM.INPUT.REPLY' => 'Responder',
			'FORM.INPUT.MARK_AS_READ' => 'Marcar como leido',
			'FORM.INPUT.NEW_PASSWORD' => 'Nueva contraseña',
			'FORM.INPUT.USERNAME_EMAIL' => 'Nombre de Usuario o Correo',
			'FORM.BUTTONS.UPDATE_PASSWORD' => 'Actualizar contraseña',
			'FORM.VALIDATIONS.REQUIRED' => 'Este campo es requerido',
			'FORM.VALIDATIONS.REQUIRED_FIELD' => 'Campo requerido',
			'FORM.VALIDATIONS.INVALID_FORMAT' => 'Formato no válido',
			'FORM.VALIDATIONS.INVALID_INPUT' => 'Entrada no válida',
			'FORM.VALIDATIONS.TOO_SHORT' => 'Muy corto',
			'FORM.VALIDATIONS.TOO_LONG' => 'Muy largo',
			'FORM.VALIDATIONS.MIN_LENGTH' => ({required Object count}) => 'Mínimo ${count} caracteres',
			'FORM.VALIDATIONS.MAX_LENGTH' => ({required Object count}) => 'Máximo ${count} caracteres',
			'FORM.VALIDATIONS.MIN_MAX_LENGTH' => ({required Object min, required Object max}) => 'Entre ${min} y ${max} caracteres',
			'FORM.VALIDATIONS.ONLY_LETTERS' => 'Solo letras permitidas',
			'FORM.VALIDATIONS.ONLY_NUMBERS' => 'Solo números permitidos',
			'FORM.VALIDATIONS.LETTERS_AND_NUMBERS' => 'Solo letras y números permitidos',
			'FORM.VALIDATIONS.NO_SPECIAL_CHARS' => 'No se permiten caracteres especiales',
			'FORM.VALIDATIONS.INVALID_EMAIL' => 'Correo electrónico no válido',
			'FORM.VALIDATIONS.INVALID_EMAIL_FORMAT' => 'Formato de correo inválido',
			'FORM.VALIDATIONS.INVALID_URL' => 'URL no válida',
			'FORM.VALIDATIONS.INVALID_PHONE' => 'Número de teléfono no válido',
			'FORM.VALIDATIONS.INVALID_DATE' => 'Fecha no válida',
			'FORM.VALIDATIONS.INVALID_TIME' => 'Hora no válida',
			'FORM.VALIDATIONS.PASSWORDS_DONT_MATCH' => 'Las contraseñas no coinciden',
			'FORM.VALIDATIONS.PASSWORD_TOO_WEAK' => 'Contraseña muy débil',
			'FORM.VALIDATIONS.PASSWORD_MIN_LENGTH' => ({required Object count}) => 'La contraseña debe tener al menos ${count} caracteres',
			'FORM.VALIDATIONS.PASSWORD_REQUIREMENTS' => 'La contraseña debe incluir mayúsculas, minúsculas y números',
			'FORM.VALIDATIONS.USERNAME_INVALID' => 'Nombre de usuario no válido',
			'FORM.VALIDATIONS.USERNAME_TOO_SHORT' => 'Nombre de usuario muy corto',
			'FORM.VALIDATIONS.USERNAME_TOO_LONG' => 'Nombre de usuario muy largo',
			'FORM.VALIDATIONS.USERNAME_EXISTS' => 'Este nombre de usuario ya existe',
			'FORM.VALIDATIONS.EMAIL_EXISTS' => 'Este correo ya está registrado',
			'FORM.VALIDATIONS.INVALID_NAME' => 'Nombre no válido',
			'FORM.VALIDATIONS.NAME_TOO_LONG' => 'Nombre muy largo',
			'FORM.VALIDATIONS.INVALID_AGE' => 'Edad no válida',
			'FORM.VALIDATIONS.MIN_AGE' => ({required Object age}) => 'Edad mínima: ${age} años',
			'FORM.VALIDATIONS.MAX_AGE' => ({required Object age}) => 'Edad máxima: ${age} años',
			'FORM.VALIDATIONS.NUMERIC_ONLY' => 'Solo valores numéricos',
			'FORM.VALIDATIONS.POSITIVE_NUMBER' => 'Debe ser un número positivo',
			'FORM.VALIDATIONS.INVALID_RANGE' => 'Valor fuera del rango permitido',
			'FORM.VALIDATIONS.MIN_VALUE' => ({required Object value}) => 'Valor mínimo: ${value}',
			'FORM.VALIDATIONS.MAX_VALUE' => ({required Object value}) => 'Valor máximo: ${value}',
			'FORM.VALIDATIONS.WHITESPACE_NOT_ALLOWED' => 'No se permiten espacios en blanco',
			'FORM.VALIDATIONS.MUST_CONTAIN_UPPERCASE' => 'Debe contener al menos una mayúscula',
			'FORM.VALIDATIONS.MUST_CONTAIN_LOWERCASE' => 'Debe contener al menos una minúscula',
			'FORM.VALIDATIONS.MUST_CONTAIN_NUMBER' => 'Debe contener al menos un número',
			'FORM.VALIDATIONS.MUST_CONTAIN_SYMBOL' => 'Debe contener al menos un símbolo',
			'FORM.VALIDATIONS.FIELD_REQUIRED' => 'Campo obligatorio',
			'FORM.VALIDATIONS.PLEASE_FILL_FIELD' => 'Por favor completa este campo',
			'FORM.VALIDATIONS.CHECK_INPUT' => 'Revisa la información ingresada',
			'FORM.VALIDATIONS.INVALID_CHARACTERS' => 'Caracteres no válidos',
			'FORM.VALIDATIONS.TEXT_TOO_SHORT' => 'Texto muy corto',
			'FORM.VALIDATIONS.TEXT_TOO_LONG' => 'Texto muy largo',
			'FORM.VALIDATIONS.INVALID_SELECTION' => 'Selección no válida',
			'FORM.VALIDATIONS.REQUIRED_SELECTION' => 'Debes seleccionar una opción',
			'FORM.VALIDATIONS.INVALID_LENGTH' => 'Longitud no válida',
			'FORM.VALIDATIONS.SELECT_PLATFORMS' => 'Necesitas seleccionar al menos una plataforma',
			'RECOVER_PASSWORD.TITLE' => 'Recupera tu contraseña',
			'RECOVER_PASSWORD.RECOVER_PASSWORD' => 'Recuperar contraseña',
			'RECOVER_PASSWORD.EMAIL_SENDED' => '¡Correo enviado!',
			'RECOVER_PASSWORD.ERROR_GETTING_INFO' => 'Hubo un error al cargar la recuperacion de contraseña',
			'RECOVER_PASSWORD.HOME_PAGE_REDIRECTING' => 'Redirigiendo a la pagina principal...',
			'RECOVER_PASSWORD.PASSWORD_UPDATED' => 'Contraseña actualizada exitosamente',
			'LOGIN.WELCOME' => 'Ingresar',
			'LOGIN.BUTTON' => 'Iniciar Sesión',
			'LOGIN.ERRORS.USER' => 'No se ha encontrado al usuario',
			'LOGIN.ERRORS.PASSWORD' => 'La contraseña es invalida',
			'LOGIN.FORGOT_PASSWORD' => '¿Olvido la contraseña?',
			'LOGIN.SUBTITLE' => '¿No tienes una cuenta?',
			'LOGIN.SUB_REGISTER' => 'Regístrate aquí',
			'CREATE_MATCH.TITLE' => 'Selecciona la plataforma',
			'CREATE_MATCH.DESCRIPTION' => 'Descripción (opcional)',
			'CREATE_MATCH.SEARCH_GAME' => 'Buscar juego',
			'CREATE_MATCH.LOADING_RECOMENDATIONS' => 'Cargando recomendaciones',
			'CREATE_MATCH.SEARCH_RESULTS' => 'Resultados de la busqueda',
			'CREATE_MATCH.EMPTY_SEARCH' => 'No se encontraron juegos, por favor intente con otro nombre',
			'CREATE_MATCH.SEARCH_HINT' => 'Escribe un poco más del título para encontrar tu juego',
			'CREATE_MATCH.SEARCH_ERROR' => 'Error al buscar juegos, por favor intente de nuevo',
			'CREATE_MATCH.PLATFORMS_EMPTY' => 'No has seleccionado una plataforma',
			'CREATE_MATCH.ADD_PLATFORMS' => 'Ingresa aquí para añadir plataformas',
			'CREATE_MATCH.SEARCHING' => 'Buscando',
			'CREATE_MATCH.SEARCH_USER' => 'Invitar compañeros a tu partida (opcional)',
			'CREATE_MATCH.MATCH_NAME' => 'Nombre de la partida (opcional)',
			'CREATE_MATCH.INVITEDS' => 'Invitados',
			'CREATE_MATCH.DATE' => 'Fecha',
			'CREATE_MATCH.TIME' => 'Hora',
			'CREATE_MATCH.CLOCK_MESSAGE' => 'Presiona el reloj',
			'CREATE_MATCH.SUBMIT' => 'Enviar',
			'CREATE_MATCH.CREATE_MATCH' => 'Crear partida',
			'CREATE_MATCH.MATCH_CREATED' => '¡Partida creada!',
			'CREATE_MATCH.DATE_ERROR' => 'Cree una fecha y hora correctas',
			'CREATE_MATCH.UPLOADING_MESSAGE' => 'La partida se está creando',
			'CREATE_MATCH.ERROR' => 'Error creando la partida, por favor intente de nuevo',
			'CREATE_MATCH.TITLE_EMPTY' => 'Escriba el titulo',
			'CREATE_MATCH.DURATION' => ({required Object duration}) => 'Duración: ${duration} minutos',
			'MATCH.MATCH_UPDATED' => 'Partida actualizada',
			'MATCH.ERROR_LOADING' => 'Error cargando partida',
			'MATCH.JOIN_TO_MATCH' => 'Unirse a la partida',
			'MATCH.EDIT_MATCH' => 'Editar partida',
			'MATCH.LEAVE_MATCH' => 'Salir de la partida',
			'MATCH.CANCEL_MATCH' => 'Cancelar partida',
			'MATCH.CANCELL_MATCH_QUESTION' => '¿Estás seguro de que deseas cancelar la partida?',
			'MATCH.MATCH_CANCELLED' => 'Partida cancelada',
			'MATCH.MATCH_ENDED' => 'Partida finalizada',
			'MATCH.STATUS.WAITING' => 'En espera',
			'MATCH.STATUS.RUNNING' => 'En curso',
			'MATCH.STATUS.FINISHED' => 'Finalizada',
			'MATCH.STATUS.CANCELLED' => 'Cancelada',
			'SEARCH.TITLE' => 'Buscar',
			'SEARCH.SEARCH' => 'Buscar',
			'SEARCH.SEARCH_USERS' => 'Buscar usuarios',
			'SEARCH.NO_RESULTS' => 'No se encontraron resultados',
			'SEARCH.ERROR_LOADING' => 'Error cargando resultados de búsqueda',
			'SEARCH.SEARCHING' => 'Buscando...',
			'SEARCH.NO_USERS_FOUND' => 'No se encontraron usuarios',
			'MATCHES.TITLE' => 'Partidas',
			'MATCHES.ALL' => 'Todas',
			'MATCHES.CREATED' => 'Creadas',
			'MATCHES.JOINED' => 'Ingresadas',
			'MATCHES.ERRORS.LOADING_ERROR' => 'Error cargando partidas',
			'MATCHES.ERRORS.NO_MATCHES' => 'No hay partidas',
			'MATCHES.ERRORS.JOIN_FAILED' => 'Error al ingresar a la partida',
			'CONNECTIONS.TITLE' => 'Conexiones',
			'CONNECTIONS.EMPTY' => 'Sin conexiones',
			'CONNECTIONS.LOADING' => 'Cargando conexiones',
			'CONNECTIONS.ERRORS.LOADING_ERROR' => 'Error cargando conexiones',
			'CONNECTIONS.ERRORS.NO_CONNECTIONS' => 'Sin conexiones',
			'CONNECTIONS.HAVE_A_REQUEST' => ({required Object name}) => 'Tienes una solicitud para ${name}',
			'CONNECTIONS.REQUESTS.TITLE' => 'Solicitudes',
			'CONNECTIONS.REQUESTS.ACCEPTED' => 'Aceptada',
			'CONNECTIONS.REQUESTS.ADD' => 'Añadir',
			'CONNECTIONS.REQUESTS.REQUESTED' => 'Solicitada',
			'CONNECTIONS.REQUESTS.REJECTED' => 'Rechazada',
			'CONNECTIONS.REQUESTS.PENDING' => 'Pendiente',
			'CONNECTIONS.REQUESTS.ACCEPT' => 'Aceptar',
			'CONNECTIONS.REQUESTS.REJECT' => 'Rechazar',
			'CONNECTIONS.REQUESTS.USER_WANTS_TO_CONNECT' => ({required Object name}) => '${name} quiere conectar contigo',
			'CONNECTIONS.REQUESTS.ACCEPT_REQUEST' => '¿Aceptar solicitud?',
			'CONNECTIONS.REQUESTS.WANT_TO_CANCELL' => '¿Deseas cancelar la solicitud?',
			'CONNECTIONS.REQUESTS.CANCEL' => 'Cancelar solicitud',
			'RECOMMENDATIONS.TITLE' => 'Recomendaciones',
			'RECOMMENDATIONS.EMPTY' => 'Aun no has creado una partida para esta plataforma \n Busca un juego para crear una',
			'RECOMMENDATIONS.LOADING' => 'Cargando recomendaciones',
			'RECOMMENDATIONS.FOR_YOU' => 'Recomendaciones para ti',
			'RECOMMENDATIONS.ERRORS.LOADING' => 'Error cargando recomendaciones',
			'CHAT.MESSAGES' => 'Mensajes',
			'CHAT.MESSAGE' => 'Mensaje',
			'CHAT.NO_MESSAGES' => 'Sin mensajes',
			'CHAT.SAY_HI_TO' => ({required Object name}) => 'Di hola a ${name}',
			'CHAT.SAY_HI' => 'Saluda',
			'CHAT.ERRORS.LOADING_ERROR' => 'Error cargando mensajes',
			'CHAT.ERRORS.LOADING_CHAT' => 'Error cargando el chat',
			'CHAT.ERRORS.NO_DATA' => 'Sin datos de amistad',
			'CHAT.ERRORS.LOADING_USER' => 'Error cargando usuario',
			'CHAT.ERRORS.NO_USER_DATA' => 'Sin datos del usuario',
			'CHAT.TODAY' => 'Hoy',
			'CHAT.YESTERDAY' => 'Ayer',
			'GAME.GAME' => 'Juego',
			'GAME.MATCH' => 'Partida',
			'GAME.DATE' => 'Fecha',
			'GAME.PLATFORM' => 'Plataforma',
			'NOTIFICATIONS.INVITATIONS' => 'Invitaciones',
			'NOTIFICATIONS.TITLE' => 'Notificaciones',
			'NOTIFICATIONS.EMPTY' => 'Sin notificaciones',
			'NOTIFICATIONS.ERROR_LOADING' => 'Error cargando notificaciones',
			'NOTIFICATIONS.MATCH_INVITATION' => 'Invitacion a partida',
			'NOTIFICATIONS.INVITED_TO' => 'Fuiste invitado a:',
			'NOTIFICATIONS.CONNECTION_REQUEST' => ({required Object name}) => '${name} quiere conectar contigo',
			'NOTIFICATIONS.ACCEPT_REQUEST_TITLE' => '¿Aceptar solicitud?',
			'NOTIFICATIONS.INVITATION_TO_MATCH' => 'Tienes una invitacion para: ',
			'NOTIFICATIONS.MATCH_READY' => 'Partida lista',
			'NOTIFICATIONS.MATCH_STARTED' => ({required Object name}) => '${name} ha empezado',
			'FRIENDS.TITLE' => 'Amigos',
			'FRIENDS.EMPTY' => 'Aun no tienes amigos',
			'FRIENDS.ERROR_LOADING' => 'Error cargando amigos',
			'PROFILE.YOU' => 'Perfil',
			'PROFILE.TITLE' => 'Perfil',
			'PROFILE.MATCHES' => 'Partidas',
			'PROFILE.PLATFORMS' => 'Tus plataformas',
			'PROFILE.MATCHES_PAGE.TITLE' => 'Mis partidas',
			'PROFILE.MATCHES_PAGE.EMPTY' => 'Aun no has creado una partida',
			'PROFILE.AVAILABILITY.EVERYONE' => 'Disponible',
			'PROFILE.AVAILABILITY.PARTNERS' => 'Solo colegas',
			'PROFILE.AVAILABILITY.NO' => 'No molestar',
			'PROFILE.USER_PAGE.NAME' => 'Nombre',
			'PROFILE.USER_PAGE.USERNAME' => 'Nombre de usuario',
			'PROFILE.USER_PAGE.EMAIL' => 'Correo',
			'PROFILE.USER_PAGE.INVITATIONS.TITLE' => 'Aceptar invitaciondes de:',
			'PROFILE.USER_PAGE.INVITATIONS.EVERYONE' => 'Lo que sea, quiero jugar',
			'PROFILE.USER_PAGE.INVITATIONS.PARTNERS' => 'Solo colegas',
			'PROFILE.USER_PAGE.INVITATIONS.NO' => 'Ya, dejame en paz',
			'PROFILE.USER_PAGE.ERRORS.VERIFY' => 'Por favor verifica tú información',
			'PROFILE.USER_PAGE.ERRORS.EMAIL' => 'Ya hay una cuenta registrada con este CORREO',
			'PROFILE.USER_PAGE.ERRORS.USERNAME' => 'Ya hay otro usuario usando este NOMBRE DE USUARIO',
			'PROFILE.USER_PAGE.ERRORS.IMG_SIZE' => 'La imagen no puede ser mayor de 2MB',
			'PROFILE.USER_PAGE.ERRORS.IMG_EXTENSION' => 'La extensión no es valida, por favor usa: \'JPG\', \'JPEG\'. \'PNG\'',
			'PROFILE.USER_PAGE.ERRORS.IMG_UPDATING' => 'Error actualizando la imagen',
			'PROFILE.USER_PAGE.ERRORS.ERROR_UPDATING' => 'Error actualizando',
			'PROFILE.USER_PAGE.UPLOADING_IMAGE' => 'Subiendo la imagen, espere un momento por favor',
			'PROFILE.USER_PAGE.UPDATED' => 'Datos actualizados',
			'PROFILE.USER_PAGE.UPDATE' => 'Actualizar',
			'PROFILE.USER_PAGE.DELETE_ACCOUNT' => 'Eliminar cuenta',
			'PROFILE.USER_PAGE.ACCOUNT_DELETED' => 'Tu cuenta ha sido borrada',
			'PROFILE.PLATFORMS_PAGE.TITLE' => 'Tus plataformas',
			'PROFILE.PLATFORMS_PAGE.SUCCESS' => '¡Plataformas actualizadas!',
			'REPORTS.CREATED' => 'Reporte creado',
			'REPORTS.REPORT_USER' => 'Reportar este usuario',
			'REPORTS.REPORT_TO' => 'Reportar a',
			'REPORTS.SELECT_TYPE' => 'Selecciona el tipo',
			'REPORTS.APP_BUG' => 'Bug de la aplicación',
			'REPORTS.OTHER' => 'Otro',
			'REPORTS.SPAM' => 'Spam',
			'REPORTS.CHILD_ABUSE' => 'Abuso de menores',
			'REPORTS.SUBMIT' => 'Subir reporte',
			'REPORTS.FEEDBACK' => 'Enviar reporte',
			'UTILS.SHOW_MORE' => 'Mostrar más',
			'UTILS.SHOW_LESS' => 'Mostrar menos',
			'UTILS.DETAILS' => 'Detalles',
			'UTILS.ADMIN' => 'Admin',
			'UTILS.DESCRIPTION' => 'Descripción',
			'UTILS.SELECT_FILE' => 'Seleccionar archivo',
			'UTILS.FILE' => 'Archivo',
			'UTILS.RELOAD' => 'Recargar',
			'UTILS.RECOVERING_PASSWORD_FOR' => ({required Object name}) => 'Recuperando contraseña para ${name}',
			'UTILS.KEEPING_CONNECTIONS' => 'Manteniendo conexiones activas',
			'UTILS.ACCEPT' => 'Aceptar',
			'UTILS.CANCEL' => 'Cancelar',
			'UTILS.REJECT' => 'Rechazar',
			'UTILS.DISMISS' => 'Descartar',
			'UTILS.YOU' => 'Tu',
			'UTILS.NO' => 'No',
			'UTILS.YES' => 'Si',
			'ALERT.YOU_SURE' => '¿Estás seguro?',
			'ALERT.CANCEL' => 'Cancelar',
			'ALERT.DELETE_MY_ACCOUNT' => 'Borrar mi cuenta',
			'ERRORS.SERVER.USER_NOT_FOUND' => 'Usuario no encontrado',
			'ERRORS.SERVER.EMAIL_IN_USE' => 'Email en uso',
			'ERRORS.SERVER.USERNAME_IN_USE' => 'Nombre de usuario en uso',
			'ERRORS.SERVER.WRONG_PASSWORD' => 'Contraseña incorrecta',
			'ERRORS.SERVER.NETWORK_ERROR' => 'Error en la red',
			'ERRORS.SERVER.NO_MATCH_FOUND' => 'No hay partida encontrada',
			'ERRORS.SERVER.NO_GAME_FOUND' => 'Juego no encontrado',
			'ERRORS.SERVER.MISSING_TOKEN' => 'Falta el token',
			'ERRORS.SERVER.NO_MESSAGE' => 'No hay mensaje',
			'ERRORS.SERVER.NOT_VALID_EXTENSION' => 'Extensión no valida',
			'ERRORS.SERVER.INVALID_DATE' => 'Fecha invalida',
			'ERRORS.SERVER.REPORT_EXISTS' => 'Espera \n Ya has reportado a este usuario',
			'ERRORS.SERVER.LOADING_GAME' => 'Error cargando el juego, vuelva a intentarlo',
			'ERRORS.SERVER.EMAIL_DATE_LIMIT' => 'Debe esperar al menos 15 dias para poder actualizar su correo',
			'ERRORS.SERVER.IMAGE_DATA' => 'Hubo un problema al cargar esta imagen \nPor favor, suba otra imagen',
			'ERRORS.SERVER.INVALID_CREDENTIALS' => 'Usuario o contraseña incorrectos',
			'ERRORS.SERVER.UNKNOWN' => 'Error desconocido',
			'ERRORS.NETWORK.VERIFY_CONNECTION' => 'Verifica tu conexión',
			'ERRORS.LOCAL.LOADING_USERS' => 'Error cargando usuarios',
			'ERRORS.LOCAL.LOADING_USER' => 'Error cargando usuario',
			'ERRORS.UI.MAIN' => 'Algo salió mal al renderizar la UI. Por favor, recarga la app.',
			'ERRORS.UI.TECHNICAL_DETAILS' => 'Detalles técnicos',
			'SHARE.TITLE' => '⚡️ ¡Comparte esta partida!',
			'SHARE.SUBJECT' => ({required Object name}) => '🎮 Juguemos ${name}',
			'SHARE.TEXT' => ({required Object gameName, required Object match}) => '🎮 Juguemos ${gameName} \n⚡️ Unete aqui: ${match}',
			'UPDATE.TITLE' => '¡NUEVA VERSIÓN!',
			'UPDATE.MESSAGE' => ({required Object version}) => 'Actualiza madnolia a la versión ${version} para seguir jugando.',
			'UPDATE.BUTTON' => 'ACTUALIZAR AHORA',
			_ => null,
		};
	}
}
