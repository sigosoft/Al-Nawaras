import 'app_config.dart';

class ApiConstants {
  /// Runtime base URL (dynamic). Updated from remote config / cache.
  static String get baseUrl => AppConfig.instance.apiBaseUrl;

  /// Fallback baked into the app (used before remote config / if fetch fails).
  static const String defaultBaseUrl = AppConfig.defaultApiBaseUrl;

  // Auth
  static String get login => '${baseUrl}login';
  static String get register => '${baseUrl}register';
  static String get checkUser => '${baseUrl}check_user';
  static String get forgotPassword => '${baseUrl}forgot-password';
  static String get socialLogin => '${baseUrl}social_login';
  static String get logout => '${baseUrl}logout';

  // Profile
  static String get profile => '${baseUrl}profile';
  static String get updateprofile => '${baseUrl}profile/update';

  // Support & Legal
  static String get support => '${baseUrl}support';
  static String get privacyPolicy => '${baseUrl}privacy_policy';
  static String get about => '${baseUrl}about';
  static String get termsAndConditions => '${baseUrl}terms_and_conditions';

  // Chat
  static String get getMessages => '${baseUrl}messages';
  static String get sendMessage => '${baseUrl}messages/send';

  // Forgot Password
  static String get sendOtp => '${baseUrl}forgot_password/send_otp';
  static String get verifyOtp => '${baseUrl}forgot_password/verify_otp';

  // Home
  static String get home => '${baseUrl}home';

  // Parking
  static String get locationDetails => '${baseUrl}parking/location_details';
  static String get slotDetails => '${baseUrl}parking/slot_details';
  static String get confirmLocation => '${baseUrl}parking/confirm_location';
  static String get parkingBook => '${baseUrl}parking/book';
  static String get parkingTypes => '${baseUrl}parking/types';
  static String get availableSummary => '${baseUrl}parking/available_summary';
  static String get checkAvailability => '${baseUrl}parking/check_availability';

  // Memberships
  static String get memberships => '${baseUrl}memberships';

  // Additional Services
  static String get services => '${baseUrl}services';

  // Booking History
  static String get parkingHistory => '${baseUrl}parking/history';

  // Rewards
  static String get rewards => '${baseUrl}rewards';

  // Vehicles
  static String get vehicles => '${baseUrl}vehicles';

  // Vehicle Types
  static String get vehicleTypes => '${baseUrl}vehicle_types';

  // Settings
  static String get settings => '${baseUrl}settings';

  // Payment
  static String get paymentSummary => '${baseUrl}payment/summary';

  // Notifications
  static String get notifications => '${baseUrl}notifications';
  static String get readNotification => '${baseUrl}notifications/read';
  static String get search => '${baseUrl}search';
  static String get lookup => '${baseUrl}lookup';

  // App Settings (Paymob Configuration)
  static String get appSettings => '${baseUrl}settings';

  // Payment confirm
  static String get paymentConfirm => '${baseUrl}payment/confirm';
  // Paymob Integration (Backend Managed)
  static String get paymobCreatePayment => '${baseUrl}paymob/create/payment';
  static String get paymobPaymentStatus => '${baseUrl}paymob/payment-status';
}
