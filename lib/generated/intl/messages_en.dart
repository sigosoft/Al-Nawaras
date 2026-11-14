// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(prefix) => "${prefix} Area";

  static String m1(count) => "Available: ${count}";

  static String m2(count) =>
      "${Intl.plural(count, one: '${count} Day', other: '${count} Days')}";

  static String m3(count) =>
      "${Intl.plural(count, one: '${count} Hour', other: '${count} Hours')}";

  static String m4(count) =>
      "${Intl.plural(count, one: '${count} Minute', other: '${count} Minutes')}";

  static String m5(number) => "License: ${number}";

  static String m6(section) => "BOATS PARKING - ${section}";

  static String m7(section) => "BOATS PARKING - ${section} (SHADED)";

  static String m8(section) => "CARAVAN PARKING - ${section}";

  static String m9(section) => "CARAVAN PARKING - ${section}(SHADED)";

  static String m10(length) => "FOOD TRUCK PARKING - Length ${length}m";

  static String m11(date) => "Member Since ${date}";

  static String m12(name) => "${name} Membership";

  static String m13(tab) => "No entries for ${tab} tab";

  static String m14(membership) =>
      "No units available for the selected ${membership} duration. Try another date or parking type.";

  static String m15(field) => "${field} (Optional)";

  static String m16(spot) => "Parked at Spot ${spot}";

  static String m17(type) => "${type} Parking";

  static String m18(amount) => "Pay ${amount}";

  static String m19(count) => "${count} Points";

  static String m20(slotName) => "Selected Slot: ${slotName}";

  static String m21(type) => "Selected Type: ${type}";

  static String m22(width, length) => "${width}m x ${length}m";

  static String m23(slot) => "Spot ${slot}";

  static String m24(date) => "Valid until: ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutAlNawaras": MessageLookupByLibrary.simpleMessage("About Al-Nawaras"),
    "acceptTermsToContinue": MessageLookupByLibrary.simpleMessage(
      "Please accept the Terms and Conditions to continue.",
    ),
    "activePartner": MessageLookupByLibrary.simpleMessage("Active Partner"),
    "activeStatus": MessageLookupByLibrary.simpleMessage("Active"),
    "activeTab": MessageLookupByLibrary.simpleMessage("Active"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "additionalService": MessageLookupByLibrary.simpleMessage(
      "Additional Service",
    ),
    "additionalServices": MessageLookupByLibrary.simpleMessage(
      "Additional Services",
    ),
    "addonServicesOptional": MessageLookupByLibrary.simpleMessage(
      "Add-on Services (Optional)",
    ),
    "agreeToTerms": MessageLookupByLibrary.simpleMessage(
      "I agree to the Terms of Service and Privacy Policy",
    ),
    "agreeToTermsPrivacy": MessageLookupByLibrary.simpleMessage(
      "By proceeding, you agree to our Terms of Service\nand Privacy Policy",
    ),
    "airConditioned": MessageLookupByLibrary.simpleMessage("Air Conditioned"),
    "alNawaras": MessageLookupByLibrary.simpleMessage("Al NAWRAS"),
    "allTab": MessageLookupByLibrary.simpleMessage("All"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account? ",
    ),
    "amLabel": MessageLookupByLibrary.simpleMessage("AM"),
    "amountExclVat": MessageLookupByLibrary.simpleMessage("Amount (excl. VAT)"),
    "amountLabel": MessageLookupByLibrary.simpleMessage("Amount"),
    "applePayLabel": MessageLookupByLibrary.simpleMessage("Apple Pay"),
    "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "areaSuffix": m0,
    "available": MessageLookupByLibrary.simpleMessage("Available"),
    "availableCount": m1,
    "availableSlotTypes": MessageLookupByLibrary.simpleMessage(
      "Available Slot Types",
    ),
    "awayFromParking": MessageLookupByLibrary.simpleMessage(
      "Away from Parking",
    ),
    "basicMembershipBenefits": MessageLookupByLibrary.simpleMessage(
      "Basic Membership Benefits",
    ),
    "biometricsComingSoon": MessageLookupByLibrary.simpleMessage(
      "Biometrics functionality will be available in the next update.",
    ),
    "boatsParking": MessageLookupByLibrary.simpleMessage("Boats Parking"),
    "bookNow": MessageLookupByLibrary.simpleMessage("Book Now!"),
    "bookParking": MessageLookupByLibrary.simpleMessage("Book Parking"),
    "booked": MessageLookupByLibrary.simpleMessage("Booked"),
    "bookingCreatedSlotNotAssigned": MessageLookupByLibrary.simpleMessage(
      "Your booking was created, but the slot could not be assigned. Please contact support.",
    ),
    "bookingDetails": MessageLookupByLibrary.simpleMessage("Booking Details"),
    "bookingHistory": MessageLookupByLibrary.simpleMessage("Booking History"),
    "bookingPayment": MessageLookupByLibrary.simpleMessage("Booking Payment"),
    "bookingSuccessful": MessageLookupByLibrary.simpleMessage(
      "Booking Successful!",
    ),
    "bookings": MessageLookupByLibrary.simpleMessage("Bookings"),
    "buy": MessageLookupByLibrary.simpleMessage("Buy"),
    "buyNow": MessageLookupByLibrary.simpleMessage("Buy Now!"),
    "camera": MessageLookupByLibrary.simpleMessage("Camera"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "caravanParking": MessageLookupByLibrary.simpleMessage("Caravan Parking"),
    "cardDetailsOnSecurePage": MessageLookupByLibrary.simpleMessage(
      "You will enter your card details on the secure Paymob payment page after tapping Pay.",
    ),
    "cashOnSite": MessageLookupByLibrary.simpleMessage("Cash on site"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "chassisHint": MessageLookupByLibrary.simpleMessage(
      "e.g. 1HGCM82633A123456",
    ),
    "chassisNumber": MessageLookupByLibrary.simpleMessage("Chassis Number"),
    "checkNetworkDetail": MessageLookupByLibrary.simpleMessage(
      "Please check your network and try again.",
    ),
    "checkRewards": MessageLookupByLibrary.simpleMessage("Check Rewards"),
    "chooseDateTimeForSlot": MessageLookupByLibrary.simpleMessage(
      "Choose date and time for selecting the slot",
    ),
    "chooseFromGallery": MessageLookupByLibrary.simpleMessage(
      "Choose from Gallery",
    ),
    "choosePlanNeeds": MessageLookupByLibrary.simpleMessage(
      "Choose the membership plan that best suits your needs",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "color": MessageLookupByLibrary.simpleMessage("Color"),
    "colorHint": MessageLookupByLibrary.simpleMessage("e.g. Blue"),
    "comingSoon": MessageLookupByLibrary.simpleMessage("Coming Soon"),
    "comments": MessageLookupByLibrary.simpleMessage("Comments"),
    "completedTab": MessageLookupByLibrary.simpleMessage("Completed"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmLocation": MessageLookupByLibrary.simpleMessage("Confirm Location"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm New Password",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm your password",
    ),
    "confirmationEmailSent": MessageLookupByLibrary.simpleMessage(
      "A confirmation email and invoice have been\nsent to your registered email address.",
    ),
    "connectionTimeout": MessageLookupByLibrary.simpleMessage(
      "Connection timeout. Please check your internet connection.",
    ),
    "couldNotOpenLink": MessageLookupByLibrary.simpleMessage(
      "Could not open link",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
    "createPassword": MessageLookupByLibrary.simpleMessage("Create a password"),
    "credit": MessageLookupByLibrary.simpleMessage("Credit"),
    "creditDebitCard": MessageLookupByLibrary.simpleMessage(
      "Credit/Debit Card",
    ),
    "currency": MessageLookupByLibrary.simpleMessage(" AED"),
    "currentlyNoItemsFoundPleaseTryLater": MessageLookupByLibrary.simpleMessage(
      "Currently no items Found, Please try later...",
    ),
    "dateTime": MessageLookupByLibrary.simpleMessage("Date & Time"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "draftSaved": MessageLookupByLibrary.simpleMessage("Draft Saved"),
    "drivingLicense": MessageLookupByLibrary.simpleMessage(
      "Driving License Number (Optional)",
    ),
    "duration": MessageLookupByLibrary.simpleMessage("Duration"),
    "durationDays": m2,
    "durationHours": m3,
    "durationMinutes": m4,
    "earnPerBooking": MessageLookupByLibrary.simpleMessage(
      "Earn 50 pts per booking",
    ),
    "earnPoints": MessageLookupByLibrary.simpleMessage("Earn Points"),
    "editDetails": MessageLookupByLibrary.simpleMessage("Edit Details"),
    "emailAddress": MessageLookupByLibrary.simpleMessage("Email Address"),
    "emailCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Email cannot be empty",
    ),
    "emailMustContainAt": MessageLookupByLibrary.simpleMessage(
      "Email Address must contain @ symbol",
    ),
    "emailOrMobile": MessageLookupByLibrary.simpleMessage("Email or Mobile"),
    "emailSupport": MessageLookupByLibrary.simpleMessage("Email Support"),
    "enableBiometricsLogin": MessageLookupByLibrary.simpleMessage(
      "Enable Biometrics Login",
    ),
    "endDateLabel": MessageLookupByLibrary.simpleMessage("End Date"),
    "endTimeAfterStartTime": MessageLookupByLibrary.simpleMessage(
      "End time must be after the start time",
    ),
    "endTimeLabel": MessageLookupByLibrary.simpleMessage("End Time"),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enter6DigitOtp": MessageLookupByLibrary.simpleMessage("Enter 6-Digit OTP"),
    "enterComplete6DigitOtp": MessageLookupByLibrary.simpleMessage(
      "Please enter the complete 6-digit OTP",
    ),
    "enterDetailsToReceiveOtp": MessageLookupByLibrary.simpleMessage(
      "Please enter your details to receive an OTP",
    ),
    "enterDrivingLicense": MessageLookupByLibrary.simpleMessage(
      "Enter your Driving License Number",
    ),
    "enterEmail": MessageLookupByLibrary.simpleMessage("Enter your email"),
    "enterEmailOrMobile": MessageLookupByLibrary.simpleMessage(
      "Enter your email or mobile",
    ),
    "enterFullName": MessageLookupByLibrary.simpleMessage(
      "Enter your full name",
    ),
    "enterLicenseNumber": MessageLookupByLibrary.simpleMessage(
      "e.g. DXB 12345",
    ),
    "enterMobileNumber": MessageLookupByLibrary.simpleMessage(
      "Enter your mobile number",
    ),
    "enterNewPassword": MessageLookupByLibrary.simpleMessage(
      "Enter New Password",
    ),
    "enterPassword": MessageLookupByLibrary.simpleMessage(
      "Enter your password",
    ),
    "enterUsernameOrMobile": MessageLookupByLibrary.simpleMessage(
      "Enter Username or Mobile",
    ),
    "enterValidMobileOrEmail": MessageLookupByLibrary.simpleMessage(
      "Enter a valid UAE mobile (+971 XX XXX XXXX) or Email",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorConfirmingLocation": MessageLookupByLibrary.simpleMessage(
      "Slot Not Found",
    ),
    "errorDuringRegistration": MessageLookupByLibrary.simpleMessage(
      "An error occurred during registration",
    ),
    "errorServer": MessageLookupByLibrary.simpleMessage(
      "Error connecting to server",
    ),
    "extend": MessageLookupByLibrary.simpleMessage("Extend"),
    "extraAmount": MessageLookupByLibrary.simpleMessage("Extra Amount"),
    "facebookLoginComingSoon": MessageLookupByLibrary.simpleMessage(
      "Facebook login will be available in the next update",
    ),
    "failedToConfirmLocation": MessageLookupByLibrary.simpleMessage(
      "Slot Not Found",
    ),
    "failedToFetchAboutUs": MessageLookupByLibrary.simpleMessage(
      "Failed to fetch About Us link",
    ),
    "failedToFetchPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "Failed to fetch Privacy Policy",
    ),
    "failedToFetchSupportDetails": MessageLookupByLibrary.simpleMessage(
      "Failed to fetch support details",
    ),
    "failedToFetchTerms": MessageLookupByLibrary.simpleMessage(
      "Failed to fetch Terms and Conditions",
    ),
    "failedToGeneratePaymentUrl": MessageLookupByLibrary.simpleMessage(
      "Failed to generate payment URL. Please try again.",
    ),
    "failedToGetGoogleToken": MessageLookupByLibrary.simpleMessage(
      "Failed to get Google token",
    ),
    "failedToSendImage": MessageLookupByLibrary.simpleMessage(
      "Failed to send image",
    ),
    "failedToSendMessage": MessageLookupByLibrary.simpleMessage(
      "Failed to send message",
    ),
    "foodTruckParking": MessageLookupByLibrary.simpleMessage(
      "Food Truck Parking",
    ),
    "foodTruckParking13m": MessageLookupByLibrary.simpleMessage(
      "Food Truck Parking – 13 m",
    ),
    "foodTruckParking17m": MessageLookupByLibrary.simpleMessage(
      "Food Truck Parking – 17 m",
    ),
    "forAllVehicleTypes": MessageLookupByLibrary.simpleMessage(
      "for All Vehicle Types",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "freeParkingDay": MessageLookupByLibrary.simpleMessage("Free Parking Day"),
    "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
    "gallery": MessageLookupByLibrary.simpleMessage("Gallery"),
    "genericVehicle": MessageLookupByLibrary.simpleMessage("Generic Vehicle"),
    "getDirections": MessageLookupByLibrary.simpleMessage("Get Directions"),
    "getHelpAccount": MessageLookupByLibrary.simpleMessage(
      "Get Help with your account",
    ),
    "goldTier": MessageLookupByLibrary.simpleMessage("Gold"),
    "googlePayLabel": MessageLookupByLibrary.simpleMessage("Google Pay"),
    "guest": MessageLookupByLibrary.simpleMessage("Guest"),
    "heightM": MessageLookupByLibrary.simpleMessage("Height (m)"),
    "helpSupport": MessageLookupByLibrary.simpleMessage("Help & Support"),
    "helpSupportDescription": MessageLookupByLibrary.simpleMessage(
      "Need help? Contact our support team anytime. We’re here to assist you with parking, memberships, payments, and more.",
    ),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "hourUnit": MessageLookupByLibrary.simpleMessage("hour"),
    "howCanWeHelp": MessageLookupByLibrary.simpleMessage(
      "How can we help you?",
    ),
    "howToEarnPoints": MessageLookupByLibrary.simpleMessage("Earn Points"),
    "iAgreeToThe": MessageLookupByLibrary.simpleMessage("I agree to the "),
    "information": MessageLookupByLibrary.simpleMessage("Information"),
    "invalidDuration": MessageLookupByLibrary.simpleMessage("Invalid Duration"),
    "invalidEmailFormat": MessageLookupByLibrary.simpleMessage(
      "Invalid email format",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "Server returned an invalid response.",
    ),
    "inviteFriendsPoints": MessageLookupByLibrary.simpleMessage(
      "Invite friends and earn more points!",
    ),
    "jetskiParking": MessageLookupByLibrary.simpleMessage("Jetski Parking"),
    "jetskiWithTrailerParking": MessageLookupByLibrary.simpleMessage(
      "Jetski with Trailer Parking",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "languageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Switch app language",
    ),
    "learnMoreServices": MessageLookupByLibrary.simpleMessage(
      "Learn more about our services",
    ),
    "lengthM": MessageLookupByLibrary.simpleMessage("Length (m)"),
    "license": m5,
    "linkIsEmpty": MessageLookupByLibrary.simpleMessage("Link is empty"),
    "loadMore": MessageLookupByLibrary.simpleMessage("Load More"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "location": MessageLookupByLibrary.simpleMessage("Location"),
    "locationCodeLabel": MessageLookupByLibrary.simpleMessage(
      "Location Code : ",
    ),
    "locationConfirmedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Location and slot confirmed successfully",
    ),
    "locationLabel": MessageLookupByLibrary.simpleMessage("Location : "),
    "locationTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Location Type : ",
    ),
    "login": MessageLookupByLibrary.simpleMessage("Login"),
    "loginFailedCheckCredentials": MessageLookupByLibrary.simpleMessage(
      "Login failed. Please check your credentials.",
    ),
    "loginSuccessful": MessageLookupByLibrary.simpleMessage("Login successful"),
    "logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to logout?",
    ),
    "make": MessageLookupByLibrary.simpleMessage("Make"),
    "makeHint": MessageLookupByLibrary.simpleMessage("e.g. Yamaha"),
    "manageAccountSecurity": MessageLookupByLibrary.simpleMessage(
      "Manage your account security",
    ),
    "managePaymentOptions": MessageLookupByLibrary.simpleMessage(
      "Manage your payment options",
    ),
    "manageSecurity": MessageLookupByLibrary.simpleMessage(
      "Manage your password and security",
    ),
    "mapBoatsParking": m6,
    "mapBoatsParkingShaded": m7,
    "mapCaravanParking": m8,
    "mapCaravanParkingShaded": m9,
    "mapEntrance": MessageLookupByLibrary.simpleMessage("ENTRANCE"),
    "mapExit": MessageLookupByLibrary.simpleMessage("EXIT"),
    "mapFoodTruckParkingLength": m10,
    "mapJetskiTrailerParking": MessageLookupByLibrary.simpleMessage(
      "JETSKI WITH TRAILER PARKING",
    ),
    "meLabel": MessageLookupByLibrary.simpleMessage("Me"),
    "memberSince": m11,
    "membership": MessageLookupByLibrary.simpleMessage("Membership"),
    "membershipPackage": MessageLookupByLibrary.simpleMessage(
      "Membership Package",
    ),
    "membershipPlans": MessageLookupByLibrary.simpleMessage("Membership Plans"),
    "membershipStatusLabel": MessageLookupByLibrary.simpleMessage(
      "Membership Status",
    ),
    "membershipSubscription": MessageLookupByLibrary.simpleMessage(
      "Membership Subscription",
    ),
    "membershipTitle": m12,
    "membershipType": MessageLookupByLibrary.simpleMessage("Membership Type"),
    "mobileDigitsOnly": MessageLookupByLibrary.simpleMessage(
      "Mobile number must contain only digits after +971",
    ),
    "mobileExactly9Digits": MessageLookupByLibrary.simpleMessage(
      "Mobile number must be exactly 9 digits after +971",
    ),
    "mobileHint": MessageLookupByLibrary.simpleMessage("+971 XX XXX XXXX"),
    "mobileMax9Digits": MessageLookupByLibrary.simpleMessage(
      "Mobile number cannot be more than 9 digits after +971",
    ),
    "mobileNumber": MessageLookupByLibrary.simpleMessage("Mobile Number"),
    "model": MessageLookupByLibrary.simpleMessage("Model"),
    "modelHint": MessageLookupByLibrary.simpleMessage("e.g. Caravel"),
    "month": MessageLookupByLibrary.simpleMessage("month"),
    "monthlyMembership": MessageLookupByLibrary.simpleMessage(
      "Monthly Membership",
    ),
    "monthlyPremium": MessageLookupByLibrary.simpleMessage("Monthly Premium"),
    "myVehicles": MessageLookupByLibrary.simpleMessage("My Vehicles"),
    "nameCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "Name cannot be empty",
    ),
    "navigateSelectSlot": MessageLookupByLibrary.simpleMessage(
      "Please navigate to select your parking slot of your choice.",
    ),
    "navigateToYourParking": MessageLookupByLibrary.simpleMessage(
      "Navigate to\nYour Parking\nSpot",
    ),
    "needAssistanceCall": MessageLookupByLibrary.simpleMessage(
      "Need assistance? Call us at 800-NAWRAS.",
    ),
    "needHelp": MessageLookupByLibrary.simpleMessage("Need help?"),
    "networkError": MessageLookupByLibrary.simpleMessage("Network Error"),
    "networkErrorTryAgain": MessageLookupByLibrary.simpleMessage(
      "A network error occurred. Please try again.",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "no": MessageLookupByLibrary.simpleMessage("No"),
    "noActiveBooking": MessageLookupByLibrary.simpleMessage(
      "No active booking found",
    ),
    "noActivePlan": MessageLookupByLibrary.simpleMessage("No Active Plan"),
    "noBookingHistoryFound": MessageLookupByLibrary.simpleMessage(
      "No booking history found",
    ),
    "noDataAvailable": MessageLookupByLibrary.simpleMessage(
      "No data available",
    ),
    "noDescriptionAvailable": MessageLookupByLibrary.simpleMessage(
      "No description available.",
    ),
    "noEntriesForTab": m13,
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No Internet Connection",
    ),
    "noMembershipPackages": MessageLookupByLibrary.simpleMessage(
      "No membership packages available",
    ),
    "noNotifications": MessageLookupByLibrary.simpleMessage("No notifications"),
    "noPlansFound": MessageLookupByLibrary.simpleMessage(
      "No membership plans found",
    ),
    "noRedeemableRewards": MessageLookupByLibrary.simpleMessage(
      "No redeemable rewards available",
    ),
    "noRulesFound": MessageLookupByLibrary.simpleMessage("No rules found"),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "No matching locations, vehicles or bookings",
    ),
    "noServicesAvailable": MessageLookupByLibrary.simpleMessage(
      "No services available",
    ),
    "noServicesFound": MessageLookupByLibrary.simpleMessage(
      "No services found",
    ),
    "noSlotTypesAvailable": MessageLookupByLibrary.simpleMessage(
      "No slot types available for selected time",
    ),
    "noSlotsAvailable": MessageLookupByLibrary.simpleMessage(
      "No Slots Available",
    ),
    "noSlotsForType": MessageLookupByLibrary.simpleMessage(
      "No slots available for this type.",
    ),
    "noStatus": MessageLookupByLibrary.simpleMessage("No Status"),
    "noUnitsForDuration": m14,
    "noVehicleTypesAvailable": MessageLookupByLibrary.simpleMessage(
      "No vehicle types available",
    ),
    "noVehiclesFound": MessageLookupByLibrary.simpleMessage(
      "No vehicles found",
    ),
    "nolPayLabel": MessageLookupByLibrary.simpleMessage("Nol Pay"),
    "notAvailable": MessageLookupByLibrary.simpleMessage("Not available"),
    "notAvailableShort": MessageLookupByLibrary.simpleMessage("N/A"),
    "notice": MessageLookupByLibrary.simpleMessage("Notice"),
    "notification": MessageLookupByLibrary.simpleMessage("Notification"),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "off": MessageLookupByLibrary.simpleMessage("OFF"),
    "offStatus": MessageLookupByLibrary.simpleMessage("Off"),
    "onlinePaymentNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Online payment for this item is not available yet. Please contact support.",
    ),
    "open": MessageLookupByLibrary.simpleMessage("Open"),
    "opportunity": MessageLookupByLibrary.simpleMessage("Opportunity!"),
    "optionalField": m15,
    "orSignInWith": MessageLookupByLibrary.simpleMessage("Or sign in with"),
    "otpSentSuccessfully": MessageLookupByLibrary.simpleMessage(
      "OTP sent successfully",
    ),
    "parkedAtSpot": m16,
    "parkingFallback": MessageLookupByLibrary.simpleMessage("Parking"),
    "parkingPayment": MessageLookupByLibrary.simpleMessage("Parking Payment"),
    "parkingRenewed": MessageLookupByLibrary.simpleMessage("Parking Renewed"),
    "parkingType": MessageLookupByLibrary.simpleMessage("Parking Type"),
    "parkingTypeSubtitle": m17,
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters long",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "Password reset successful",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "pay": MessageLookupByLibrary.simpleMessage("Pay"),
    "payAmount": m18,
    "payPalLabel": MessageLookupByLibrary.simpleMessage("PayPal"),
    "payment": MessageLookupByLibrary.simpleMessage("Payment"),
    "paymentDeclined": MessageLookupByLibrary.simpleMessage(
      "Payment was declined or failed. Please try again.",
    ),
    "paymentFailed": MessageLookupByLibrary.simpleMessage("Payment Failed"),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Payment Method"),
    "paymentMethodNotImplemented": MessageLookupByLibrary.simpleMessage(
      "Payment method not implemented yet.",
    ),
    "paymentMethods": MessageLookupByLibrary.simpleMessage("Payment Methods"),
    "paymentProcessedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Your payment has been processed\nsuccessfully.",
    ),
    "paymentStatus": MessageLookupByLibrary.simpleMessage("Payment Status"),
    "paymentStillConfirming": MessageLookupByLibrary.simpleMessage(
      "Payment is still being confirmed. Please check Bookings in a moment.",
    ),
    "paymentSuccessful": MessageLookupByLibrary.simpleMessage(
      "Payment Successful!",
    ),
    "paymentSummary": MessageLookupByLibrary.simpleMessage("Payment Summary"),
    "per": MessageLookupByLibrary.simpleMessage("per"),
    "personalInformation": MessageLookupByLibrary.simpleMessage(
      "Personal Information",
    ),
    "phoneSupport": MessageLookupByLibrary.simpleMessage("Phone Support"),
    "planDaily": MessageLookupByLibrary.simpleMessage("Daily"),
    "planHourly": MessageLookupByLibrary.simpleMessage("Hourly"),
    "planMonthly": MessageLookupByLibrary.simpleMessage("Monthly"),
    "planType": MessageLookupByLibrary.simpleMessage("Plan Type"),
    "planWeekly": MessageLookupByLibrary.simpleMessage("Weekly"),
    "planYearly": MessageLookupByLibrary.simpleMessage("Yearly"),
    "pleaseAcceptTerms": MessageLookupByLibrary.simpleMessage(
      "Please accept the Terms and Conditions",
    ),
    "pleaseConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Please confirm your Password",
    ),
    "pleaseEnterEmailAddress": MessageLookupByLibrary.simpleMessage(
      "Please enter your Email Address",
    ),
    "pleaseEnterEmailOrMobile": MessageLookupByLibrary.simpleMessage(
      "Please enter your Email or Mobile Number",
    ),
    "pleaseEnterFullName": MessageLookupByLibrary.simpleMessage(
      "Please enter your Full Name",
    ),
    "pleaseEnterMobileNumber": MessageLookupByLibrary.simpleMessage(
      "Please enter your Mobile Number",
    ),
    "pleaseEnterNewPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter your New Password",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter your Password",
    ),
    "pleaseEnterPlateNumber": MessageLookupByLibrary.simpleMessage(
      "Please enter Vehicle Plate Number",
    ),
    "pleaseEnterUsernameOrMobile": MessageLookupByLibrary.simpleMessage(
      "Please enter your Username or Mobile",
    ),
    "pleaseProvideVehicleDetails": MessageLookupByLibrary.simpleMessage(
      "Please provide your vehicle details",
    ),
    "pleaseSelectDateTimeFirst": MessageLookupByLibrary.simpleMessage(
      "Please select date and time first",
    ),
    "pmLabel": MessageLookupByLibrary.simpleMessage("PM"),
    "points": MessageLookupByLibrary.simpleMessage("points"),
    "pointsCount": m19,
    "pointsPerShare": MessageLookupByLibrary.simpleMessage("10 pts per share"),
    "premiumParkingSolutions": MessageLookupByLibrary.simpleMessage(
      "Premium Parking Solutions",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
    "privacyPolicyNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Privacy policy not available.",
    ),
    "privacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "Review our privacy policy",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profilePicture": MessageLookupByLibrary.simpleMessage("Profile picture"),
    "provideDetailsToRegister": MessageLookupByLibrary.simpleMessage(
      "Please provide your details to create an account",
    ),
    "pts": MessageLookupByLibrary.simpleMessage("pts"),
    "recentActivity": MessageLookupByLibrary.simpleMessage("Recent Activity"),
    "redeem": MessageLookupByLibrary.simpleMessage("Redeem"),
    "redeemPoints": MessageLookupByLibrary.simpleMessage("Redeem Points"),
    "redeemYourRewards": MessageLookupByLibrary.simpleMessage("Redeem Points"),
    "referenceLabel": MessageLookupByLibrary.simpleMessage("Reference"),
    "register": MessageLookupByLibrary.simpleMessage("Register"),
    "registerLater": MessageLookupByLibrary.simpleMessage("Register Later"),
    "registerNewVehicle": MessageLookupByLibrary.simpleMessage(
      "Register New Vehicle",
    ),
    "registrationFailed": MessageLookupByLibrary.simpleMessage(
      "Registration failed",
    ),
    "registrationSuccessful": MessageLookupByLibrary.simpleMessage(
      "Registration successful",
    ),
    "rememberMe": MessageLookupByLibrary.simpleMessage("Remember Me"),
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "renew": MessageLookupByLibrary.simpleMessage("Renew"),
    "replace": MessageLookupByLibrary.simpleMessage("Replace"),
    "requestCancelled": MessageLookupByLibrary.simpleMessage(
      "Request was cancelled.",
    ),
    "requestService": MessageLookupByLibrary.simpleMessage("Request Service"),
    "required": MessageLookupByLibrary.simpleMessage("Required"),
    "resetYourPassword": MessageLookupByLibrary.simpleMessage(
      "Reset your password",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "rewardFallback": MessageLookupByLibrary.simpleMessage("Reward"),
    "rewards": MessageLookupByLibrary.simpleMessage("Rewards"),
    "saveCardForFuture": MessageLookupByLibrary.simpleMessage(
      "Save card for future payments",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Save Changes"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchResults": MessageLookupByLibrary.simpleMessage("Search Results"),
    "securePayment": MessageLookupByLibrary.simpleMessage("Secure Payment"),
    "securedSlots": MessageLookupByLibrary.simpleMessage(
      "300+ secured slots for caravans,\nboats, jet skis & more.",
    ),
    "security": MessageLookupByLibrary.simpleMessage("Security"),
    "select": MessageLookupByLibrary.simpleMessage("Select"),
    "selectAvailableSlotType": MessageLookupByLibrary.simpleMessage(
      "Please select an available slot type.",
    ),
    "selectAvailableSlotTypeFirst": MessageLookupByLibrary.simpleMessage(
      "Please select an available Slot Type first",
    ),
    "selectParkingLocation": MessageLookupByLibrary.simpleMessage(
      "Select Parking Location",
    ),
    "selectRangeServices": MessageLookupByLibrary.simpleMessage(
      "Select from our range of additional services",
    ),
    "selectSlotFromAvailableTypes": MessageLookupByLibrary.simpleMessage(
      "Please select a parking slot from the available types.",
    ),
    "selectSlotOnMapFirst": MessageLookupByLibrary.simpleMessage(
      "Please select a parking slot on the map first.",
    ),
    "selectStartAndEndDateTime": MessageLookupByLibrary.simpleMessage(
      "Please select both start and end date/time.",
    ),
    "selectVehicle": MessageLookupByLibrary.simpleMessage("Select Vehicle"),
    "selectVehicleBeforeProceeding": MessageLookupByLibrary.simpleMessage(
      "Please select a vehicle before proceeding.",
    ),
    "selectVehicleType": MessageLookupByLibrary.simpleMessage(
      "Select Vehicle Type",
    ),
    "selectYourSlot": MessageLookupByLibrary.simpleMessage("Select Your Slot"),
    "selected": MessageLookupByLibrary.simpleMessage("Selected"),
    "selectedSlot": m20,
    "selectedTypeLabel": m21,
    "selectionFullOrBooked": MessageLookupByLibrary.simpleMessage(
      "This selection is currently full or already booked.",
    ),
    "selectionRequired": MessageLookupByLibrary.simpleMessage(
      "Selection Required",
    ),
    "send": MessageLookupByLibrary.simpleMessage("Send"),
    "sendOtp": MessageLookupByLibrary.simpleMessage("Send OTP"),
    "serverErrorOccurred": MessageLookupByLibrary.simpleMessage(
      "Server error occurred.",
    ),
    "service": MessageLookupByLibrary.simpleMessage("Service"),
    "serviceName": MessageLookupByLibrary.simpleMessage("Service Name"),
    "services": MessageLookupByLibrary.simpleMessage("Services"),
    "shaded": MessageLookupByLibrary.simpleMessage("Shaded"),
    "shadedParkingDetail": MessageLookupByLibrary.simpleMessage(
      "Shaded Parking",
    ),
    "share": MessageLookupByLibrary.simpleMessage("Share"),
    "shareEarn": MessageLookupByLibrary.simpleMessage("Share & Earn"),
    "shareMessage": MessageLookupByLibrary.simpleMessage(
      "Check out Al Nawaras Parking App! I am enjoying the rewards. Download now and start earning points.",
    ),
    "sharing": MessageLookupByLibrary.simpleMessage("Sharing"),
    "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
    "signInToYourAccount": MessageLookupByLibrary.simpleMessage(
      "Sign in to your account",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("Sign Out"),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "silverMember": MessageLookupByLibrary.simpleMessage("Silver Member"),
    "silverTier": MessageLookupByLibrary.simpleMessage("Silver"),
    "sizeFormat": m22,
    "sizeLabel": MessageLookupByLibrary.simpleMessage("Parking Size : "),
    "sizeShortLabel": MessageLookupByLibrary.simpleMessage("Size:"),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "slotAlreadyBooked": MessageLookupByLibrary.simpleMessage(
      "This slot is already booked and cannot be selected.",
    ),
    "slotBookedCaps": MessageLookupByLibrary.simpleMessage("BOOKED"),
    "slotFreeCaps": MessageLookupByLibrary.simpleMessage("FREE"),
    "slotNotFoundOrConfirmed": MessageLookupByLibrary.simpleMessage(
      "The selected slot could not be found or confirmed. Please try another selection.",
    ),
    "slotNumberLabel": MessageLookupByLibrary.simpleMessage("Slot Number : "),
    "slotType": MessageLookupByLibrary.simpleMessage("Slot Type"),
    "slotUnavailable": MessageLookupByLibrary.simpleMessage("Slot Unavailable"),
    "smartParking": MessageLookupByLibrary.simpleMessage("Smart Parking"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "spotLabel": m23,
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "standardPlan": MessageLookupByLibrary.simpleMessage("Standard Plan"),
    "standardTier": MessageLookupByLibrary.simpleMessage("Standard"),
    "startDate": MessageLookupByLibrary.simpleMessage("Start Date"),
    "startDateLabel": MessageLookupByLibrary.simpleMessage("Start Date"),
    "startTime": MessageLookupByLibrary.simpleMessage("Start Time"),
    "stateCancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "stateCompleted": MessageLookupByLibrary.simpleMessage("Completed"),
    "stateConfirmed": MessageLookupByLibrary.simpleMessage("Confirmed"),
    "stateDraft": MessageLookupByLibrary.simpleMessage("Draft"),
    "stateExpired": MessageLookupByLibrary.simpleMessage("Expired"),
    "statePaid": MessageLookupByLibrary.simpleMessage("Paid"),
    "statePendingPayment": MessageLookupByLibrary.simpleMessage(
      "Pending Payment",
    ),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "subtotal": MessageLookupByLibrary.simpleMessage("Subtotal"),
    "subtotalLabel": MessageLookupByLibrary.simpleMessage("Subtotal"),
    "success": MessageLookupByLibrary.simpleMessage("Success"),
    "supportLabel": MessageLookupByLibrary.simpleMessage("Support"),
    "takeAPhoto": MessageLookupByLibrary.simpleMessage("Take a Photo"),
    "tapToUploadDocument": MessageLookupByLibrary.simpleMessage(
      "Tap to upload registration document",
    ),
    "tapToUploadPhoto": MessageLookupByLibrary.simpleMessage(
      "Tap to upload vehicle photo",
    ),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "Terms and Conditions",
    ),
    "thankYou": MessageLookupByLibrary.simpleMessage("Thank you!"),
    "thirtyDays": MessageLookupByLibrary.simpleMessage("30 Days"),
    "titleFallback": MessageLookupByLibrary.simpleMessage("Title"),
    "toGoldMember": MessageLookupByLibrary.simpleMessage("To Gold Member"),
    "today": MessageLookupByLibrary.simpleMessage("Today"),
    "tokenNotFound": MessageLookupByLibrary.simpleMessage("Token not found"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "totalAmount": MessageLookupByLibrary.simpleMessage("Total Amount"),
    "totalLabel": MessageLookupByLibrary.simpleMessage("Total"),
    "totalPoints": MessageLookupByLibrary.simpleMessage("Total Points"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
    "twoStepComingSoon": MessageLookupByLibrary.simpleMessage(
      "Two-Step verification will be available in the next update.",
    ),
    "twoStepVerification": MessageLookupByLibrary.simpleMessage(
      "Two-Step Verification",
    ),
    "typeLabel": MessageLookupByLibrary.simpleMessage("Type"),
    "typeYourMessageHere": MessageLookupByLibrary.simpleMessage(
      "Type your message here...",
    ),
    "unableToCheckSlotAvailability": MessageLookupByLibrary.simpleMessage(
      "Unable to check slot availability",
    ),
    "unableToConnectServer": MessageLookupByLibrary.simpleMessage(
      "Unable to connect to the server. Please verify your network.",
    ),
    "unableToCreateBooking": MessageLookupByLibrary.simpleMessage(
      "Unable to create the booking. Please try again.",
    ),
    "unableToFetchAvailability": MessageLookupByLibrary.simpleMessage(
      "Unable to fetch availability",
    ),
    "unableToLoadRewards": MessageLookupByLibrary.simpleMessage(
      "Unable to load rewards",
    ),
    "unexpectedError": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred.",
    ),
    "unexpectedNetworkError": MessageLookupByLibrary.simpleMessage(
      "An unexpected network error occurred.",
    ),
    "unshaded": MessageLookupByLibrary.simpleMessage("Unshaded"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "updateFailed": MessageLookupByLibrary.simpleMessage("Update failed"),
    "updatePersonalDetails": MessageLookupByLibrary.simpleMessage(
      "Update your personal details",
    ),
    "updateSuccessful": MessageLookupByLibrary.simpleMessage(
      "Update successful",
    ),
    "userAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "User already exists. Please login or use a different email.",
    ),
    "userFallback": MessageLookupByLibrary.simpleMessage("User"),
    "usernameOrMobile": MessageLookupByLibrary.simpleMessage(
      "Username or Mobile Number",
    ),
    "validUntil": m24,
    "validity": MessageLookupByLibrary.simpleMessage("Validity"),
    "vat": MessageLookupByLibrary.simpleMessage("VAT (5%)"),
    "vatLabel": MessageLookupByLibrary.simpleMessage("VAT (5%)"),
    "vehicle": MessageLookupByLibrary.simpleMessage("Vehicle"),
    "vehicleCheckIn": MessageLookupByLibrary.simpleMessage("Vehicle Check-in"),
    "vehicleDimensions": MessageLookupByLibrary.simpleMessage(
      "Vehicle Dimensions",
    ),
    "vehicleDirection": MessageLookupByLibrary.simpleMessage(
      "Vehicle Direction",
    ),
    "vehicleLabel": MessageLookupByLibrary.simpleMessage("Vehicle"),
    "vehicleLicenseNumber": MessageLookupByLibrary.simpleMessage(
      "Vehicle Plate Number",
    ),
    "vehiclePhoto": MessageLookupByLibrary.simpleMessage("Vehicle Photo"),
    "vehicleRegisteredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Vehicle registered successfully",
    ),
    "vehicleRegistrationDocument": MessageLookupByLibrary.simpleMessage(
      "Vehicle Registration Document",
    ),
    "vehicleSavedAsDraft": MessageLookupByLibrary.simpleMessage(
      "Vehicle details saved as draft",
    ),
    "vehicleType": MessageLookupByLibrary.simpleMessage("Vehicle Type"),
    "verifyOtp": MessageLookupByLibrary.simpleMessage("Verify OTP"),
    "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
    "viewDetails": MessageLookupByLibrary.simpleMessage("View Details"),
    "viewPastBookings": MessageLookupByLibrary.simpleMessage(
      "View your past bookings",
    ),
    "viewTerms": MessageLookupByLibrary.simpleMessage(
      "View Terms & Conditions",
    ),
    "washService": MessageLookupByLibrary.simpleMessage("Wash Service"),
    "weWillBeBackSoon": MessageLookupByLibrary.simpleMessage(
      "We\'ll be back soon",
    ),
    "welcome": MessageLookupByLibrary.simpleMessage("Welcome"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("Welcome Back!"),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "Secure parking for caravans, jet skis, \nfood trucks, boats and more",
    ),
    "widthM": MessageLookupByLibrary.simpleMessage("Width (m)"),
    "year": MessageLookupByLibrary.simpleMessage("Year"),
    "yearHint": MessageLookupByLibrary.simpleMessage("e.g. 2020"),
    "yearUnit": MessageLookupByLibrary.simpleMessage("year"),
    "yes": MessageLookupByLibrary.simpleMessage("Yes"),
    "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
  };
}
