class ApiConstants {
  static const String baseUrl =
      'https://rta-parking-staging-31816802.dev.odoo.com/api/';

  // Auth
  static const String login = '${baseUrl}login';
  static const String register = '${baseUrl}register';
  static const String checkUser = '${baseUrl}check_user';
  static const String forgotPassword = '${baseUrl}forgot-password';
  static const String socialLogin = '${baseUrl}social_login';
  static const String logout = '${baseUrl}logout';

  // Profile
  static const String profile = '${baseUrl}profile';
  static const String updateprofile = '${baseUrl}profile/update';

  // Support & Legal
  static const String support = '${baseUrl}support';
  static const String privacyPolicy = '${baseUrl}privacy_policy';
  static const String about = '${baseUrl}about';

  // Chat
  static const String getMessages = '${baseUrl}messages';
  static const String sendMessage = '${baseUrl}messages/send';

  // Forgot Password
  static const String sendOtp = '${baseUrl}forgot_password/send_otp';
  static const String verifyOtp = '${baseUrl}forgot_password/verify_otp';

  // Home
  static const String home = '${baseUrl}home';

  // Parking
  static const String locationDetails = '${baseUrl}parking/location_details';
  static const String slotDetails = '${baseUrl}parking/slot_details';
  static const String confirmLocation = '${baseUrl}parking/confirm_location';
  static const String parkingBook = '${baseUrl}parking/book';
  static const String parkingTypes = '${baseUrl}parking/types';
  static const String availableSummary = '${baseUrl}parking/available_summary';
  static const String checkAvailability = '${baseUrl}parking/check_availability';

  // Memberships
  static const String memberships = '${baseUrl}memberships';

  // Additional Services
  static const String services = '${baseUrl}services';

  // Booking History
  static const String parkingHistory = '${baseUrl}parking/history';

  // Rewards
  static const String rewards = '${baseUrl}rewards';

  // Vehicles
  static const String vehicles = '${baseUrl}vehicles';

  /// fetch vehicle details

  // Vehicle Types
  static const String vehicleTypes = '${baseUrl}vehicle_types';

  // Settings
  static const String settings = '${baseUrl}settings';

  // Payment
  static const String paymentSummary = '${baseUrl}payment/summary';
  

  // Notifications
  static const String notifications = '${baseUrl}notifications';
  static const String readNotification = '${baseUrl}notifications/read';
  static const String search = '${baseUrl}search';
  static const String lookup = '${baseUrl}lookup';

  //  App Settings (Paymob Configuration)
  static const String appSettings = '${baseUrl}settings';

  // Payment confirm
  static const String paymentConfirm = '${baseUrl}payment/confirm';
  // Paymob Integration (Backend Managed)
  static const String paymobCreatePayment = '${baseUrl}paymob/create/payment';
  static const String paymobPaymentStatus = '${baseUrl}paymob/payment-status';
}
