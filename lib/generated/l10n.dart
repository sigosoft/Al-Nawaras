// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Credit`
  String get credit {
    return Intl.message('Credit', name: 'credit', desc: '', args: []);
  }

  /// `Currently no items Found, Please try later...`
  String get currentlyNoItemsFoundPleaseTryLater {
    return Intl.message(
      'Currently no items Found, Please try later...',
      name: 'currentlyNoItemsFoundPleaseTryLater',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `OFF`
  String get off {
    return Intl.message('OFF', name: 'off', desc: '', args: []);
  }

  /// `Pay`
  String get pay {
    return Intl.message('Pay', name: 'pay', desc: '', args: []);
  }

  /// `points`
  String get points {
    return Intl.message('points', name: 'points', desc: '', args: []);
  }

  /// `No vehicles found`
  String get noVehiclesFound {
    return Intl.message(
      'No vehicles found',
      name: 'noVehiclesFound',
      desc: '',
      args: [],
    );
  }

  /// `Generic Vehicle`
  String get genericVehicle {
    return Intl.message(
      'Generic Vehicle',
      name: 'genericVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `Replace`
  String get replace {
    return Intl.message('Replace', name: 'replace', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Premium Parking Solutions`
  String get premiumParkingSolutions {
    return Intl.message(
      'Premium Parking Solutions',
      name: 'premiumParkingSolutions',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Sign in to your account`
  String get signInToYourAccount {
    return Intl.message(
      'Sign in to your account',
      name: 'signInToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Email or Mobile`
  String get emailOrMobile {
    return Intl.message(
      'Email or Mobile',
      name: 'emailOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email or mobile`
  String get enterEmailOrMobile {
    return Intl.message(
      'Enter your email or mobile',
      name: 'enterEmailOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter your password`
  String get enterPassword {
    return Intl.message(
      'Enter your password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message('Remember Me', name: 'rememberMe', desc: '', args: []);
  }

  /// `Or sign in with`
  String get orSignInWith {
    return Intl.message(
      'Or sign in with',
      name: 'orSignInWith',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Welcome Back!`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please provide your details to create an account`
  String get provideDetailsToRegister {
    return Intl.message(
      'Please provide your details to create an account',
      name: 'provideDetailsToRegister',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Enter your full name`
  String get enterFullName {
    return Intl.message(
      'Enter your full name',
      name: 'enterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enterEmail {
    return Intl.message(
      'Enter your email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get mobileNumber {
    return Intl.message(
      'Mobile Number',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter your mobile number`
  String get enterMobileNumber {
    return Intl.message(
      'Enter your mobile number',
      name: 'enterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `+971 XX XXX XXXX`
  String get mobileHint {
    return Intl.message(
      '+971 XX XXX XXXX',
      name: 'mobileHint',
      desc: '',
      args: [],
    );
  }

  /// `Driving License Number (Optional)`
  String get drivingLicense {
    return Intl.message(
      'Driving License Number (Optional)',
      name: 'drivingLicense',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Driving License Number`
  String get enterDrivingLicense {
    return Intl.message(
      'Enter your Driving License Number',
      name: 'enterDrivingLicense',
      desc: '',
      args: [],
    );
  }

  /// `Create a password`
  String get createPassword {
    return Intl.message(
      'Create a password',
      name: 'createPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get confirmYourPassword {
    return Intl.message(
      'Confirm your password',
      name: 'confirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the Terms of Service and Privacy Policy`
  String get agreeToTerms {
    return Intl.message(
      'I agree to the Terms of Service and Privacy Policy',
      name: 'agreeToTerms',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Secure parking for caravans, jet skis, \nfood trucks, boats and more`
  String get welcomeDescription {
    return Intl.message(
      'Secure parking for caravans, jet skis, \nfood trucks, boats and more',
      name: 'welcomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Renew`
  String get renew {
    return Intl.message('Renew', name: 'renew', desc: '', args: []);
  }

  /// `Book Parking`
  String get bookParking {
    return Intl.message(
      'Book Parking',
      name: 'bookParking',
      desc: '',
      args: [],
    );
  }

  /// `Request Service`
  String get requestService {
    return Intl.message(
      'Request Service',
      name: 'requestService',
      desc: '',
      args: [],
    );
  }

  /// `Membership Plans`
  String get membershipPlans {
    return Intl.message(
      'Membership Plans',
      name: 'membershipPlans',
      desc: '',
      args: [],
    );
  }

  /// `Buy`
  String get buy {
    return Intl.message('Buy', name: 'buy', desc: '', args: []);
  }

  /// `Navigate to\nYour Parking\nSpot`
  String get navigateToYourParking {
    return Intl.message(
      'Navigate to\nYour Parking\nSpot',
      name: 'navigateToYourParking',
      desc: '',
      args: [],
    );
  }

  /// `Get Directions`
  String get getDirections {
    return Intl.message(
      'Get Directions',
      name: 'getDirections',
      desc: '',
      args: [],
    );
  }

  /// `Smart Parking`
  String get smartParking {
    return Intl.message(
      'Smart Parking',
      name: 'smartParking',
      desc: '',
      args: [],
    );
  }

  /// `for All Vehicle Types`
  String get forAllVehicleTypes {
    return Intl.message(
      'for All Vehicle Types',
      name: 'forAllVehicleTypes',
      desc: '',
      args: [],
    );
  }

  /// `300+ secured slots for caravans,\nboats, jet skis & more.`
  String get securedSlots {
    return Intl.message(
      '300+ secured slots for caravans,\nboats, jet skis & more.',
      name: 'securedSlots',
      desc: '',
      args: [],
    );
  }

  /// `Book Now!`
  String get bookNow {
    return Intl.message('Book Now!', name: 'bookNow', desc: '', args: []);
  }

  /// `Opportunity!`
  String get opportunity {
    return Intl.message(
      'Opportunity!',
      name: 'opportunity',
      desc: '',
      args: [],
    );
  }

  /// `Check Rewards`
  String get checkRewards {
    return Intl.message(
      'Check Rewards',
      name: 'checkRewards',
      desc: '',
      args: [],
    );
  }

  /// `My Vehicles`
  String get myVehicles {
    return Intl.message('My Vehicles', name: 'myVehicles', desc: '', args: []);
  }

  /// `Recent Activity`
  String get recentActivity {
    return Intl.message(
      'Recent Activity',
      name: 'recentActivity',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Register New Vehicle`
  String get registerNewVehicle {
    return Intl.message(
      'Register New Vehicle',
      name: 'registerNewVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Valid until: {date}`
  String validUntil(String date) {
    return Intl.message(
      'Valid until: $date',
      name: 'validUntil',
      desc: '',
      args: [date],
    );
  }

  /// `Parked at Spot {spot}`
  String parkedAtSpot(String spot) {
    return Intl.message(
      'Parked at Spot $spot',
      name: 'parkedAtSpot',
      desc: '',
      args: [spot],
    );
  }

  /// `Away from Parking`
  String get awayFromParking {
    return Intl.message(
      'Away from Parking',
      name: 'awayFromParking',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Premium`
  String get monthlyPremium {
    return Intl.message(
      'Monthly Premium',
      name: 'monthlyPremium',
      desc: '',
      args: [],
    );
  }

  /// `Parking Renewed`
  String get parkingRenewed {
    return Intl.message(
      'Parking Renewed',
      name: 'parkingRenewed',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Check-in`
  String get vehicleCheckIn {
    return Intl.message(
      'Vehicle Check-in',
      name: 'vehicleCheckIn',
      desc: '',
      args: [],
    );
  }

  /// `Parking Payment`
  String get parkingPayment {
    return Intl.message(
      'Parking Payment',
      name: 'parkingPayment',
      desc: '',
      args: [],
    );
  }

  /// `License: {number}`
  String license(String number) {
    return Intl.message(
      'License: $number',
      name: 'license',
      desc: '',
      args: [number],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Bookings`
  String get bookings {
    return Intl.message('Bookings', name: 'bookings', desc: '', args: []);
  }

  /// `Services`
  String get services {
    return Intl.message('Services', name: 'services', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Update your personal details`
  String get updatePersonalDetails {
    return Intl.message(
      'Update your personal details',
      name: 'updatePersonalDetails',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security {
    return Intl.message('Security', name: 'security', desc: '', args: []);
  }

  /// `Manage your password and security`
  String get manageSecurity {
    return Intl.message(
      'Manage your password and security',
      name: 'manageSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Payment Methods`
  String get paymentMethods {
    return Intl.message(
      'Payment Methods',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Manage your payment options`
  String get managePaymentOptions {
    return Intl.message(
      'Manage your payment options',
      name: 'managePaymentOptions',
      desc: '',
      args: [],
    );
  }

  /// `View your past bookings`
  String get viewPastBookings {
    return Intl.message(
      'View your past bookings',
      name: 'viewPastBookings',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get helpSupport {
    return Intl.message(
      'Help & Support',
      name: 'helpSupport',
      desc: '',
      args: [],
    );
  }

  /// `Get Help with your account`
  String get getHelpAccount {
    return Intl.message(
      'Get Help with your account',
      name: 'getHelpAccount',
      desc: '',
      args: [],
    );
  }

  /// `About Al-Nawaras`
  String get aboutAlNawaras {
    return Intl.message(
      'About Al-Nawaras',
      name: 'aboutAlNawaras',
      desc: '',
      args: [],
    );
  }

  /// `Learn more about our services`
  String get learnMoreServices {
    return Intl.message(
      'Learn more about our services',
      name: 'learnMoreServices',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message('Sign Out', name: 'signOut', desc: '', args: []);
  }

  /// `No Status`
  String get noStatus {
    return Intl.message('No Status', name: 'noStatus', desc: '', args: []);
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Select Vehicle`
  String get selectVehicle {
    return Intl.message(
      'Select Vehicle',
      name: 'selectVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load rewards`
  String get unableToLoadRewards {
    return Intl.message(
      'Unable to load rewards',
      name: 'unableToLoadRewards',
      desc: '',
      args: [],
    );
  }

  /// `Earn Points`
  String get howToEarnPoints {
    return Intl.message(
      'Earn Points',
      name: 'howToEarnPoints',
      desc: '',
      args: [],
    );
  }

  /// `Redeem Points`
  String get redeemYourRewards {
    return Intl.message(
      'Redeem Points',
      name: 'redeemYourRewards',
      desc: '',
      args: [],
    );
  }

  /// `Earn 50 pts per booking`
  String get earnPerBooking {
    return Intl.message(
      'Earn 50 pts per booking',
      name: 'earnPerBooking',
      desc: '',
      args: [],
    );
  }

  /// `Sharing`
  String get sharing {
    return Intl.message('Sharing', name: 'sharing', desc: '', args: []);
  }

  /// `10 pts per share`
  String get pointsPerShare {
    return Intl.message(
      '10 pts per share',
      name: 'pointsPerShare',
      desc: '',
      args: [],
    );
  }

  /// `Free Parking Day`
  String get freeParkingDay {
    return Intl.message(
      'Free Parking Day',
      name: 'freeParkingDay',
      desc: '',
      args: [],
    );
  }

  /// `Wash Service`
  String get washService {
    return Intl.message(
      'Wash Service',
      name: 'washService',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Rewards`
  String get rewards {
    return Intl.message('Rewards', name: 'rewards', desc: '', args: []);
  }

  /// `Total Points`
  String get totalPoints {
    return Intl.message(
      'Total Points',
      name: 'totalPoints',
      desc: '',
      args: [],
    );
  }

  /// `{count} Points`
  String pointsCount(String count) {
    return Intl.message(
      '$count Points',
      name: 'pointsCount',
      desc: '',
      args: [count],
    );
  }

  /// `Redeem`
  String get redeem {
    return Intl.message('Redeem', name: 'redeem', desc: '', args: []);
  }

  /// `Member Since {date}`
  String memberSince(String date) {
    return Intl.message(
      'Member Since $date',
      name: 'memberSince',
      desc: '',
      args: [date],
    );
  }

  /// `Parking Type`
  String get parkingType {
    return Intl.message(
      'Parking Type',
      name: 'parkingType',
      desc: '',
      args: [],
    );
  }

  /// `Unshaded`
  String get unshaded {
    return Intl.message('Unshaded', name: 'unshaded', desc: '', args: []);
  }

  /// `Shaded`
  String get shaded {
    return Intl.message('Shaded', name: 'shaded', desc: '', args: []);
  }

  /// `Air Conditioned`
  String get airConditioned {
    return Intl.message(
      'Air Conditioned',
      name: 'airConditioned',
      desc: '',
      args: [],
    );
  }

  /// `Membership Package`
  String get membershipPackage {
    return Intl.message(
      'Membership Package',
      name: 'membershipPackage',
      desc: '',
      args: [],
    );
  }

  /// `Date & Time`
  String get dateTime {
    return Intl.message('Date & Time', name: 'dateTime', desc: '', args: []);
  }

  /// `Start Date`
  String get startDate {
    return Intl.message('Start Date', name: 'startDate', desc: '', args: []);
  }

  /// `Start Time`
  String get startTime {
    return Intl.message('Start Time', name: 'startTime', desc: '', args: []);
  }

  /// `Add-on Services (Optional)`
  String get addonServicesOptional {
    return Intl.message(
      'Add-on Services (Optional)',
      name: 'addonServicesOptional',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `No data available`
  String get noDataAvailable {
    return Intl.message(
      'No data available',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Choose the membership plan that best suits your needs`
  String get choosePlanNeeds {
    return Intl.message(
      'Choose the membership plan that best suits your needs',
      name: 'choosePlanNeeds',
      desc: '',
      args: [],
    );
  }

  /// `No membership plans found`
  String get noPlansFound {
    return Intl.message(
      'No membership plans found',
      name: 'noPlansFound',
      desc: '',
      args: [],
    );
  }

  /// `per`
  String get per {
    return Intl.message('per', name: 'per', desc: '', args: []);
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Additional Services`
  String get additionalServices {
    return Intl.message(
      'Additional Services',
      name: 'additionalServices',
      desc: '',
      args: [],
    );
  }

  /// `Select from our range of additional services`
  String get selectRangeServices {
    return Intl.message(
      'Select from our range of additional services',
      name: 'selectRangeServices',
      desc: '',
      args: [],
    );
  }

  /// `No services found`
  String get noServicesFound {
    return Intl.message(
      'No services found',
      name: 'noServicesFound',
      desc: '',
      args: [],
    );
  }

  /// `Buy Now!`
  String get buyNow {
    return Intl.message('Buy Now!', name: 'buyNow', desc: '', args: []);
  }

  /// `Earn Points`
  String get earnPoints {
    return Intl.message('Earn Points', name: 'earnPoints', desc: '', args: []);
  }

  /// `Redeem Points`
  String get redeemPoints {
    return Intl.message(
      'Redeem Points',
      name: 'redeemPoints',
      desc: '',
      args: [],
    );
  }

  /// `No rules found`
  String get noRulesFound {
    return Intl.message(
      'No rules found',
      name: 'noRulesFound',
      desc: '',
      args: [],
    );
  }

  /// `No redeemable rewards available`
  String get noRedeemableRewards {
    return Intl.message(
      'No redeemable rewards available',
      name: 'noRedeemableRewards',
      desc: '',
      args: [],
    );
  }

  /// `Share & Earn`
  String get shareEarn {
    return Intl.message('Share & Earn', name: 'shareEarn', desc: '', args: []);
  }

  /// `Invite friends and earn more points!`
  String get inviteFriendsPoints {
    return Intl.message(
      'Invite friends and earn more points!',
      name: 'inviteFriendsPoints',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `View Terms & Conditions`
  String get viewTerms {
    return Intl.message(
      'View Terms & Conditions',
      name: 'viewTerms',
      desc: '',
      args: [],
    );
  }

  /// `Payment Successful!`
  String get paymentSuccessful {
    return Intl.message(
      'Payment Successful!',
      name: 'paymentSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Thank you!`
  String get thankYou {
    return Intl.message('Thank you!', name: 'thankYou', desc: '', args: []);
  }

  /// `Your payment has been processed\nsuccessfully.`
  String get paymentProcessedSuccessfully {
    return Intl.message(
      'Your payment has been processed\nsuccessfully.',
      name: 'paymentProcessedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `A confirmation email and invoice have been\nsent to your registered email address.`
  String get confirmationEmailSent {
    return Intl.message(
      'A confirmation email and invoice have been\nsent to your registered email address.',
      name: 'confirmationEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `Need assistance? Call us at 800-NAWRAS.`
  String get needAssistanceCall {
    return Intl.message(
      'Need assistance? Call us at 800-NAWRAS.',
      name: 'needAssistanceCall',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Monthly Membership`
  String get monthlyMembership {
    return Intl.message(
      'Monthly Membership',
      name: 'monthlyMembership',
      desc: '',
      args: [],
    );
  }

  /// `Shaded Parking`
  String get shadedParkingDetail {
    return Intl.message(
      'Shaded Parking',
      name: 'shadedParkingDetail',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle`
  String get vehicle {
    return Intl.message('Vehicle', name: 'vehicle', desc: '', args: []);
  }

  /// `Duration`
  String get duration {
    return Intl.message('Duration', name: 'duration', desc: '', args: []);
  }

  /// `30 Days`
  String get thirtyDays {
    return Intl.message('30 Days', name: 'thirtyDays', desc: '', args: []);
  }

  /// `Subtotal`
  String get subtotalLabel {
    return Intl.message('Subtotal', name: 'subtotalLabel', desc: '', args: []);
  }

  /// `VAT (5%)`
  String get vatLabel {
    return Intl.message('VAT (5%)', name: 'vatLabel', desc: '', args: []);
  }

  /// `Total`
  String get totalLabel {
    return Intl.message('Total', name: 'totalLabel', desc: '', args: []);
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `No Internet Connection`
  String get noInternetConnection {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please check your network and try again.`
  String get checkNetworkDetail {
    return Intl.message(
      'Please check your network and try again.',
      name: 'checkNetworkDetail',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Direction`
  String get vehicleDirection {
    return Intl.message(
      'Vehicle Direction',
      name: 'vehicleDirection',
      desc: '',
      args: [],
    );
  }

  /// `Select Parking Location`
  String get selectParkingLocation {
    return Intl.message(
      'Select Parking Location',
      name: 'selectParkingLocation',
      desc: '',
      args: [],
    );
  }

  /// `Please navigate to select your parking slot of your choice.`
  String get navigateSelectSlot {
    return Intl.message(
      'Please navigate to select your parking slot of your choice.',
      name: 'navigateSelectSlot',
      desc: '',
      args: [],
    );
  }

  /// `Location Code : `
  String get locationCodeLabel {
    return Intl.message(
      'Location Code : ',
      name: 'locationCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Slot Number : `
  String get slotNumberLabel {
    return Intl.message(
      'Slot Number : ',
      name: 'slotNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Location : `
  String get locationLabel {
    return Intl.message(
      'Location : ',
      name: 'locationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Location Type : `
  String get locationTypeLabel {
    return Intl.message(
      'Location Type : ',
      name: 'locationTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Parking Size : `
  String get sizeLabel {
    return Intl.message(
      'Parking Size : ',
      name: 'sizeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Size:`
  String get sizeShortLabel {
    return Intl.message('Size:', name: 'sizeShortLabel', desc: '', args: []);
  }

  /// `Confirm Location`
  String get confirmLocation {
    return Intl.message(
      'Confirm Location',
      name: 'confirmLocation',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message('Available', name: 'available', desc: '', args: []);
  }

  /// `Booked`
  String get booked {
    return Intl.message('Booked', name: 'booked', desc: '', args: []);
  }

  /// `Selected`
  String get selected {
    return Intl.message('Selected', name: 'selected', desc: '', args: []);
  }

  /// `Jetski Parking`
  String get jetskiParking {
    return Intl.message(
      'Jetski Parking',
      name: 'jetskiParking',
      desc: '',
      args: [],
    );
  }

  /// `Food Truck Parking`
  String get foodTruckParking {
    return Intl.message(
      'Food Truck Parking',
      name: 'foodTruckParking',
      desc: '',
      args: [],
    );
  }

  /// `Boats Parking`
  String get boatsParking {
    return Intl.message(
      'Boats Parking',
      name: 'boatsParking',
      desc: '',
      args: [],
    );
  }

  /// `Caravan Parking`
  String get caravanParking {
    return Intl.message(
      'Caravan Parking',
      name: 'caravanParking',
      desc: '',
      args: [],
    );
  }

  /// `Jetski with Trailer Parking`
  String get jetskiWithTrailerParking {
    return Intl.message(
      'Jetski with Trailer Parking',
      name: 'jetskiWithTrailerParking',
      desc: '',
      args: [],
    );
  }

  /// `Food Truck Parking – 17 m`
  String get foodTruckParking17m {
    return Intl.message(
      'Food Truck Parking – 17 m',
      name: 'foodTruckParking17m',
      desc: '',
      args: [],
    );
  }

  /// `Food Truck Parking – 13 m`
  String get foodTruckParking13m {
    return Intl.message(
      'Food Truck Parking – 13 m',
      name: 'foodTruckParking13m',
      desc: '',
      args: [],
    );
  }

  /// `{prefix} Area`
  String areaSuffix(String prefix) {
    return Intl.message(
      '$prefix Area',
      name: 'areaSuffix',
      desc: '',
      args: [prefix],
    );
  }

  /// `Open`
  String get open {
    return Intl.message('Open', name: 'open', desc: '', args: []);
  }

  /// `Standard`
  String get standard {
    return Intl.message('Standard', name: 'standard', desc: '', args: []);
  }

  /// `Location and slot confirmed successfully`
  String get locationConfirmedSuccessfully {
    return Intl.message(
      'Location and slot confirmed successfully',
      name: 'locationConfirmedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Slot Not Found`
  String get failedToConfirmLocation {
    return Intl.message(
      'Slot Not Found',
      name: 'failedToConfirmLocation',
      desc: '',
      args: [],
    );
  }

  /// `Slot Not Found`
  String get errorConfirmingLocation {
    return Intl.message(
      'Slot Not Found',
      name: 'errorConfirmingLocation',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message('Payment', name: 'payment', desc: '', args: []);
  }

  /// `Payment Summary`
  String get paymentSummary {
    return Intl.message(
      'Payment Summary',
      name: 'paymentSummary',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Credit/Debit Card`
  String get creditDebitCard {
    return Intl.message(
      'Credit/Debit Card',
      name: 'creditDebitCard',
      desc: '',
      args: [],
    );
  }

  /// `Apple Pay`
  String get applePayLabel {
    return Intl.message('Apple Pay', name: 'applePayLabel', desc: '', args: []);
  }

  /// `Google Pay`
  String get googlePayLabel {
    return Intl.message(
      'Google Pay',
      name: 'googlePayLabel',
      desc: '',
      args: [],
    );
  }

  /// `PayPal`
  String get payPalLabel {
    return Intl.message('PayPal', name: 'payPalLabel', desc: '', args: []);
  }

  /// `Nol Pay`
  String get nolPayLabel {
    return Intl.message('Nol Pay', name: 'nolPayLabel', desc: '', args: []);
  }

  /// `Cash on site`
  String get cashOnSite {
    return Intl.message('Cash on site', name: 'cashOnSite', desc: '', args: []);
  }

  /// `Save card for future payments`
  String get saveCardForFuture {
    return Intl.message(
      'Save card for future payments',
      name: 'saveCardForFuture',
      desc: '',
      args: [],
    );
  }

  /// `Pay {amount}`
  String payAmount(String amount) {
    return Intl.message(
      'Pay $amount',
      name: 'payAmount',
      desc: '',
      args: [amount],
    );
  }

  /// `By proceeding, you agree to our Terms of Service\nand Privacy Policy`
  String get agreeToTermsPrivacy {
    return Intl.message(
      'By proceeding, you agree to our Terms of Service\nand Privacy Policy',
      name: 'agreeToTermsPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `Booking History`
  String get bookingHistory {
    return Intl.message(
      'Booking History',
      name: 'bookingHistory',
      desc: '',
      args: [],
    );
  }

  /// `No booking history found`
  String get noBookingHistoryFound {
    return Intl.message(
      'No booking history found',
      name: 'noBookingHistoryFound',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get allTab {
    return Intl.message('All', name: 'allTab', desc: '', args: []);
  }

  /// `Active`
  String get activeTab {
    return Intl.message('Active', name: 'activeTab', desc: '', args: []);
  }

  /// `Completed`
  String get completedTab {
    return Intl.message('Completed', name: 'completedTab', desc: '', args: []);
  }

  /// `Booking Details`
  String get bookingDetails {
    return Intl.message(
      'Booking Details',
      name: 'bookingDetails',
      desc: '',
      args: [],
    );
  }

  /// `Reference`
  String get referenceLabel {
    return Intl.message(
      'Reference',
      name: 'referenceLabel',
      desc: '',
      args: [],
    );
  }

  /// `No entries for {tab} tab`
  String noEntriesForTab(String tab) {
    return Intl.message(
      'No entries for $tab tab',
      name: 'noEntriesForTab',
      desc: '',
      args: [tab],
    );
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `Extend`
  String get extend {
    return Intl.message('Extend', name: 'extend', desc: '', args: []);
  }

  /// `Load More`
  String get loadMore {
    return Intl.message('Load More', name: 'loadMore', desc: '', args: []);
  }

  /// `month`
  String get month {
    return Intl.message('month', name: 'month', desc: '', args: []);
  }

  /// `Additional Service`
  String get additionalService {
    return Intl.message(
      'Additional Service',
      name: 'additionalService',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amountLabel {
    return Intl.message('Amount', name: 'amountLabel', desc: '', args: []);
  }

  /// `Start Date`
  String get startDateLabel {
    return Intl.message(
      'Start Date',
      name: 'startDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `End Date`
  String get endDateLabel {
    return Intl.message('End Date', name: 'endDateLabel', desc: '', args: []);
  }

  /// `Membership Status`
  String get membershipStatusLabel {
    return Intl.message(
      'Membership Status',
      name: 'membershipStatusLabel',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get activeStatus {
    return Intl.message('Active', name: 'activeStatus', desc: '', args: []);
  }

  /// `Need help?`
  String get needHelp {
    return Intl.message('Need help?', name: 'needHelp', desc: '', args: []);
  }

  /// `Al NAWRAS`
  String get alNawaras {
    return Intl.message('Al NAWRAS', name: 'alNawaras', desc: '', args: []);
  }

  /// `We'll be back soon`
  String get weWillBeBackSoon {
    return Intl.message(
      'We\'ll be back soon',
      name: 'weWillBeBackSoon',
      desc: '',
      args: [],
    );
  }

  /// `No notifications`
  String get noNotifications {
    return Intl.message(
      'No notifications',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `To Gold Member`
  String get toGoldMember {
    return Intl.message(
      'To Gold Member',
      name: 'toGoldMember',
      desc: '',
      args: [],
    );
  }

  /// `Search Results`
  String get searchResults {
    return Intl.message(
      'Search Results',
      name: 'searchResults',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Check out Al Nawaras Parking App! I am enjoying the rewards. Download now and start earning points.`
  String get shareMessage {
    return Intl.message(
      'Check out Al Nawaras Parking App! I am enjoying the rewards. Download now and start earning points.',
      name: 'shareMessage',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Are you sure you want to logout?`
  String get logoutConfirm {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logoutConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `pts`
  String get pts {
    return Intl.message('pts', name: 'pts', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `Standard`
  String get standardTier {
    return Intl.message('Standard', name: 'standardTier', desc: '', args: []);
  }

  /// `Silver`
  String get silverTier {
    return Intl.message('Silver', name: 'silverTier', desc: '', args: []);
  }

  /// `Gold`
  String get goldTier {
    return Intl.message('Gold', name: 'goldTier', desc: '', args: []);
  }

  /// `No Active Plan`
  String get noActivePlan {
    return Intl.message(
      'No Active Plan',
      name: 'noActivePlan',
      desc: '',
      args: [],
    );
  }

  /// `Service Name`
  String get serviceName {
    return Intl.message(
      'Service Name',
      name: 'serviceName',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle`
  String get vehicleLabel {
    return Intl.message('Vehicle', name: 'vehicleLabel', desc: '', args: []);
  }

  /// `Booking Successful!`
  String get bookingSuccessful {
    return Intl.message(
      'Booking Successful!',
      name: 'bookingSuccessful',
      desc: '',
      args: [],
    );
  }

  /// ` AED`
  String get currency {
    return Intl.message(' AED', name: 'currency', desc: '', args: []);
  }

  /// `Error connecting to server`
  String get errorServer {
    return Intl.message(
      'Error connecting to server',
      name: 'errorServer',
      desc: '',
      args: [],
    );
  }

  /// `Reset your password`
  String get resetYourPassword {
    return Intl.message(
      'Reset your password',
      name: 'resetYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your details to receive an OTP`
  String get enterDetailsToReceiveOtp {
    return Intl.message(
      'Please enter your details to receive an OTP',
      name: 'enterDetailsToReceiveOtp',
      desc: '',
      args: [],
    );
  }

  /// `Username or Mobile Number`
  String get usernameOrMobile {
    return Intl.message(
      'Username or Mobile Number',
      name: 'usernameOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `Enter Username or Mobile`
  String get enterUsernameOrMobile {
    return Intl.message(
      'Enter Username or Mobile',
      name: 'enterUsernameOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get enterNewPassword {
    return Intl.message(
      'Enter New Password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get sendOtp {
    return Intl.message('Send OTP', name: 'sendOtp', desc: '', args: []);
  }

  /// `Enter 6-Digit OTP`
  String get enter6DigitOtp {
    return Intl.message(
      'Enter 6-Digit OTP',
      name: 'enter6DigitOtp',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP`
  String get verifyOtp {
    return Intl.message('Verify OTP', name: 'verifyOtp', desc: '', args: []);
  }

  /// `Edit Details`
  String get editDetails {
    return Intl.message(
      'Edit Details',
      name: 'editDetails',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Review our privacy policy`
  String get privacyPolicySubtitle {
    return Intl.message(
      'Review our privacy policy',
      name: 'privacyPolicySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `VAT (5%)`
  String get vat {
    return Intl.message('VAT (5%)', name: 'vat', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Switch app language`
  String get languageSubtitle {
    return Intl.message(
      'Switch app language',
      name: 'languageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Available Slot Types`
  String get availableSlotTypes {
    return Intl.message(
      'Available Slot Types',
      name: 'availableSlotTypes',
      desc: '',
      args: [],
    );
  }

  /// `Selected Slot: {slotName}`
  String selectedSlot(String slotName) {
    return Intl.message(
      'Selected Slot: $slotName',
      name: 'selectedSlot',
      desc: '',
      args: [slotName],
    );
  }

  /// `Please select date and time first`
  String get pleaseSelectDateTimeFirst {
    return Intl.message(
      'Please select date and time first',
      name: 'pleaseSelectDateTimeFirst',
      desc: '',
      args: [],
    );
  }

  /// `No slot types available for selected time`
  String get noSlotTypesAvailable {
    return Intl.message(
      'No slot types available for selected time',
      name: 'noSlotTypesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Slot Type`
  String get slotType {
    return Intl.message('Slot Type', name: 'slotType', desc: '', args: []);
  }

  /// `Available: {count}`
  String availableCount(String count) {
    return Intl.message(
      'Available: $count',
      name: 'availableCount',
      desc: '',
      args: [count],
    );
  }

  /// `End Time`
  String get endTimeLabel {
    return Intl.message('End Time', name: 'endTimeLabel', desc: '', args: []);
  }

  /// `No services available`
  String get noServicesAvailable {
    return Intl.message(
      'No services available',
      name: 'noServicesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `This slot is already booked and cannot be selected.`
  String get slotAlreadyBooked {
    return Intl.message(
      'This slot is already booked and cannot be selected.',
      name: 'slotAlreadyBooked',
      desc: '',
      args: [],
    );
  }

  /// `{width}m X {length}m`
  String sizeFormat(String width, String length) {
    return Intl.message(
      '${width}m X ${length}m',
      name: 'sizeFormat',
      desc: '',
      args: [width, length],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Please provide your vehicle details`
  String get pleaseProvideVehicleDetails {
    return Intl.message(
      'Please provide your vehicle details',
      name: 'pleaseProvideVehicleDetails',
      desc: '',
      args: [],
    );
  }

  /// `Select Vehicle Type`
  String get selectVehicleType {
    return Intl.message(
      'Select Vehicle Type',
      name: 'selectVehicleType',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Plate Number`
  String get vehicleLicenseNumber {
    return Intl.message(
      'Vehicle Plate Number',
      name: 'vehicleLicenseNumber',
      desc: '',
      args: [],
    );
  }

  /// `e.g. DXB 12345`
  String get enterLicenseNumber {
    return Intl.message(
      'e.g. DXB 12345',
      name: 'enterLicenseNumber',
      desc: '',
      args: [],
    );
  }

  /// `Make`
  String get make {
    return Intl.message('Make', name: 'make', desc: '', args: []);
  }

  /// `e.g. Yamaha`
  String get makeHint {
    return Intl.message('e.g. Yamaha', name: 'makeHint', desc: '', args: []);
  }

  /// `Model`
  String get model {
    return Intl.message('Model', name: 'model', desc: '', args: []);
  }

  /// `e.g. Caravel`
  String get modelHint {
    return Intl.message('e.g. Caravel', name: 'modelHint', desc: '', args: []);
  }

  /// `Chassis Number`
  String get chassisNumber {
    return Intl.message(
      'Chassis Number',
      name: 'chassisNumber',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 1HGCM82633A123456`
  String get chassisHint {
    return Intl.message(
      'e.g. 1HGCM82633A123456',
      name: 'chassisHint',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message('Year', name: 'year', desc: '', args: []);
  }

  /// `e.g. 2020`
  String get yearHint {
    return Intl.message('e.g. 2020', name: 'yearHint', desc: '', args: []);
  }

  /// `Vehicle Dimensions`
  String get vehicleDimensions {
    return Intl.message(
      'Vehicle Dimensions',
      name: 'vehicleDimensions',
      desc: '',
      args: [],
    );
  }

  /// `Length (m)`
  String get lengthM {
    return Intl.message('Length (m)', name: 'lengthM', desc: '', args: []);
  }

  /// `Width (m)`
  String get widthM {
    return Intl.message('Width (m)', name: 'widthM', desc: '', args: []);
  }

  /// `Height (m)`
  String get heightM {
    return Intl.message('Height (m)', name: 'heightM', desc: '', args: []);
  }

  /// `Comments`
  String get comments {
    return Intl.message('Comments', name: 'comments', desc: '', args: []);
  }

  /// `Vehicle Photo`
  String get vehiclePhoto {
    return Intl.message(
      'Vehicle Photo',
      name: 'vehiclePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Tap to upload vehicle photo`
  String get tapToUploadPhoto {
    return Intl.message(
      'Tap to upload vehicle photo',
      name: 'tapToUploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Registration Document`
  String get vehicleRegistrationDocument {
    return Intl.message(
      'Vehicle Registration Document',
      name: 'vehicleRegistrationDocument',
      desc: '',
      args: [],
    );
  }

  /// `Tap to upload registration document`
  String get tapToUploadDocument {
    return Intl.message(
      'Tap to upload registration document',
      name: 'tapToUploadDocument',
      desc: '',
      args: [],
    );
  }

  /// `Register Later`
  String get registerLater {
    return Intl.message(
      'Register Later',
      name: 'registerLater',
      desc: '',
      args: [],
    );
  }

  /// `No vehicle types available`
  String get noVehicleTypesAvailable {
    return Intl.message(
      'No vehicle types available',
      name: 'noVehicleTypesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Service`
  String get service {
    return Intl.message('Service', name: 'service', desc: '', args: []);
  }

  /// `No description available.`
  String get noDescriptionAvailable {
    return Intl.message(
      'No description available.',
      name: 'noDescriptionAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Online payment for this item is not available yet. Please contact support.`
  String get onlinePaymentNotAvailable {
    return Intl.message(
      'Online payment for this item is not available yet. Please contact support.',
      name: 'onlinePaymentNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No active booking found`
  String get noActiveBooking {
    return Intl.message(
      'No active booking found',
      name: 'noActiveBooking',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Type`
  String get vehicleType {
    return Intl.message(
      'Vehicle Type',
      name: 'vehicleType',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message('Status', name: 'status', desc: '', args: []);
  }

  /// `Active Partner`
  String get activePartner {
    return Intl.message(
      'Active Partner',
      name: 'activePartner',
      desc: '',
      args: [],
    );
  }

  /// `No matching locations, vehicles or bookings`
  String get noSearchResults {
    return Intl.message(
      'No matching locations, vehicles or bookings',
      name: 'noSearchResults',
      desc: '',
      args: [],
    );
  }

  /// `Amount (excl. VAT)`
  String get amountExclVat {
    return Intl.message(
      'Amount (excl. VAT)',
      name: 'amountExclVat',
      desc: '',
      args: [],
    );
  }

  /// `You will enter your card details on the secure Paymob payment page after tapping Pay.`
  String get cardDetailsOnSecurePage {
    return Intl.message(
      'You will enter your card details on the secure Paymob payment page after tapping Pay.',
      name: 'cardDetailsOnSecurePage',
      desc: '',
      args: [],
    );
  }

  /// `Could not open link`
  String get couldNotOpenLink {
    return Intl.message(
      'Could not open link',
      name: 'couldNotOpenLink',
      desc: '',
      args: [],
    );
  }

  /// `Link is empty`
  String get linkIsEmpty {
    return Intl.message(
      'Link is empty',
      name: 'linkIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch About Us link`
  String get failedToFetchAboutUs {
    return Intl.message(
      'Failed to fetch About Us link',
      name: 'failedToFetchAboutUs',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred.`
  String get unexpectedError {
    return Intl.message(
      'An unexpected error occurred.',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Notice`
  String get notice {
    return Intl.message('Notice', name: 'notice', desc: '', args: []);
  }

  /// `Unable to fetch availability`
  String get unableToFetchAvailability {
    return Intl.message(
      'Unable to fetch availability',
      name: 'unableToFetchAvailability',
      desc: '',
      args: [],
    );
  }

  /// `Unable to check slot availability`
  String get unableToCheckSlotAvailability {
    return Intl.message(
      'Unable to check slot availability',
      name: 'unableToCheckSlotAvailability',
      desc: '',
      args: [],
    );
  }

  /// `No Slots Available`
  String get noSlotsAvailable {
    return Intl.message(
      'No Slots Available',
      name: 'noSlotsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No units available for the selected {membership} duration. Try another date or parking type.`
  String noUnitsForDuration(String membership) {
    return Intl.message(
      'No units available for the selected $membership duration. Try another date or parking type.',
      name: 'noUnitsForDuration',
      desc: '',
      args: [membership],
    );
  }

  /// `Selection Required`
  String get selectionRequired {
    return Intl.message(
      'Selection Required',
      name: 'selectionRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please select a vehicle before proceeding.`
  String get selectVehicleBeforeProceeding {
    return Intl.message(
      'Please select a vehicle before proceeding.',
      name: 'selectVehicleBeforeProceeding',
      desc: '',
      args: [],
    );
  }

  /// `Please select both start and end date/time.`
  String get selectStartAndEndDateTime {
    return Intl.message(
      'Please select both start and end date/time.',
      name: 'selectStartAndEndDateTime',
      desc: '',
      args: [],
    );
  }

  /// `Please select a parking slot on the map first.`
  String get selectSlotOnMapFirst {
    return Intl.message(
      'Please select a parking slot on the map first.',
      name: 'selectSlotOnMapFirst',
      desc: '',
      args: [],
    );
  }

  /// `Please select an available slot type.`
  String get selectAvailableSlotType {
    return Intl.message(
      'Please select an available slot type.',
      name: 'selectAvailableSlotType',
      desc: '',
      args: [],
    );
  }

  /// `Please select a parking slot from the available types.`
  String get selectSlotFromAvailableTypes {
    return Intl.message(
      'Please select a parking slot from the available types.',
      name: 'selectSlotFromAvailableTypes',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Duration`
  String get invalidDuration {
    return Intl.message(
      'Invalid Duration',
      name: 'invalidDuration',
      desc: '',
      args: [],
    );
  }

  /// `End time must be after the start time`
  String get endTimeAfterStartTime {
    return Intl.message(
      'End time must be after the start time',
      name: 'endTimeAfterStartTime',
      desc: '',
      args: [],
    );
  }

  /// `Please select an available Slot Type first`
  String get selectAvailableSlotTypeFirst {
    return Intl.message(
      'Please select an available Slot Type first',
      name: 'selectAvailableSlotTypeFirst',
      desc: '',
      args: [],
    );
  }

  /// `Your booking was created, but the slot could not be assigned. Please contact support.`
  String get bookingCreatedSlotNotAssigned {
    return Intl.message(
      'Your booking was created, but the slot could not be assigned. Please contact support.',
      name: 'bookingCreatedSlotNotAssigned',
      desc: '',
      args: [],
    );
  }

  /// `The selected slot could not be found or confirmed. Please try another selection.`
  String get slotNotFoundOrConfirmed {
    return Intl.message(
      'The selected slot could not be found or confirmed. Please try another selection.',
      name: 'slotNotFoundOrConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Unable to create the booking. Please try again.`
  String get unableToCreateBooking {
    return Intl.message(
      'Unable to create the booking. Please try again.',
      name: 'unableToCreateBooking',
      desc: '',
      args: [],
    );
  }

  /// `Slot Unavailable`
  String get slotUnavailable {
    return Intl.message(
      'Slot Unavailable',
      name: 'slotUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `This selection is currently full or already booked.`
  String get selectionFullOrBooked {
    return Intl.message(
      'This selection is currently full or already booked.',
      name: 'selectionFullOrBooked',
      desc: '',
      args: [],
    );
  }

  /// `Booking Payment`
  String get bookingPayment {
    return Intl.message(
      'Booking Payment',
      name: 'bookingPayment',
      desc: '',
      args: [],
    );
  }

  /// `Membership Type`
  String get membershipType {
    return Intl.message(
      'Membership Type',
      name: 'membershipType',
      desc: '',
      args: [],
    );
  }

  /// `Membership`
  String get membership {
    return Intl.message('Membership', name: 'membership', desc: '', args: []);
  }

  /// `Type`
  String get typeLabel {
    return Intl.message('Type', name: 'typeLabel', desc: '', args: []);
  }

  /// `N/A`
  String get notAvailableShort {
    return Intl.message('N/A', name: 'notAvailableShort', desc: '', args: []);
  }

  /// `{type} Parking`
  String parkingTypeSubtitle(String type) {
    return Intl.message(
      '$type Parking',
      name: 'parkingTypeSubtitle',
      desc: '',
      args: [type],
    );
  }

  /// `Required`
  String get required {
    return Intl.message('Required', name: 'required', desc: '', args: []);
  }

  /// `Please accept the Terms and Conditions to continue.`
  String get acceptTermsToContinue {
    return Intl.message(
      'Please accept the Terms and Conditions to continue.',
      name: 'acceptTermsToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Coming Soon`
  String get comingSoon {
    return Intl.message('Coming Soon', name: 'comingSoon', desc: '', args: []);
  }

  /// `A network error occurred. Please try again.`
  String get networkErrorTryAgain {
    return Intl.message(
      'A network error occurred. Please try again.',
      name: 'networkErrorTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long`
  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 6 characters long',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter your Password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch support details`
  String get failedToFetchSupportDetails {
    return Intl.message(
      'Failed to fetch support details',
      name: 'failedToFetchSupportDetails',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Username or Mobile`
  String get pleaseEnterUsernameOrMobile {
    return Intl.message(
      'Please enter your Username or Mobile',
      name: 'pleaseEnterUsernameOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid UAE mobile (+971 XX XXX XXXX) or Email`
  String get enterValidMobileOrEmail {
    return Intl.message(
      'Enter a valid UAE mobile (+971 XX XXX XXXX) or Email',
      name: 'enterValidMobileOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Login successful`
  String get loginSuccessful {
    return Intl.message(
      'Login successful',
      name: 'loginSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Login failed. Please check your credentials.`
  String get loginFailedCheckCredentials {
    return Intl.message(
      'Login failed. Please check your credentials.',
      name: 'loginFailedCheckCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Failed to get Google token`
  String get failedToGetGoogleToken {
    return Intl.message(
      'Failed to get Google token',
      name: 'failedToGetGoogleToken',
      desc: '',
      args: [],
    );
  }

  /// `Facebook login will be available in the next update`
  String get facebookLoginComingSoon {
    return Intl.message(
      'Facebook login will be available in the next update',
      name: 'facebookLoginComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Failed to generate payment URL. Please try again.`
  String get failedToGeneratePaymentUrl {
    return Intl.message(
      'Failed to generate payment URL. Please try again.',
      name: 'failedToGeneratePaymentUrl',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch Privacy Policy`
  String get failedToFetchPrivacyPolicy {
    return Intl.message(
      'Failed to fetch Privacy Policy',
      name: 'failedToFetchPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Token not found`
  String get tokenNotFound {
    return Intl.message(
      'Token not found',
      name: 'tokenNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot be empty`
  String get nameCannotBeEmpty {
    return Intl.message(
      'Name cannot be empty',
      name: 'nameCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Email cannot be empty`
  String get emailCannotBeEmpty {
    return Intl.message(
      'Email cannot be empty',
      name: 'emailCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email format`
  String get invalidEmailFormat {
    return Intl.message(
      'Invalid email format',
      name: 'invalidEmailFormat',
      desc: '',
      args: [],
    );
  }

  /// `Update successful`
  String get updateSuccessful {
    return Intl.message(
      'Update successful',
      name: 'updateSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Update failed`
  String get updateFailed {
    return Intl.message(
      'Update failed',
      name: 'updateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Full Name`
  String get pleaseEnterFullName {
    return Intl.message(
      'Please enter your Full Name',
      name: 'pleaseEnterFullName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Email Address`
  String get pleaseEnterEmailAddress {
    return Intl.message(
      'Please enter your Email Address',
      name: 'pleaseEnterEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Email Address must contain @ symbol`
  String get emailMustContainAt {
    return Intl.message(
      'Email Address must contain @ symbol',
      name: 'emailMustContainAt',
      desc: '',
      args: [],
    );
  }

  /// `Please accept the Terms and Conditions`
  String get pleaseAcceptTerms {
    return Intl.message(
      'Please accept the Terms and Conditions',
      name: 'pleaseAcceptTerms',
      desc: '',
      args: [],
    );
  }

  /// `User already exists. Please login or use a different email.`
  String get userAlreadyExists {
    return Intl.message(
      'User already exists. Please login or use a different email.',
      name: 'userAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Registration successful`
  String get registrationSuccessful {
    return Intl.message(
      'Registration successful',
      name: 'registrationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Registration failed`
  String get registrationFailed {
    return Intl.message(
      'Registration failed',
      name: 'registrationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Vehicle Plate Number`
  String get pleaseEnterPlateNumber {
    return Intl.message(
      'Please enter Vehicle Plate Number',
      name: 'pleaseEnterPlateNumber',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle registered successfully`
  String get vehicleRegisteredSuccessfully {
    return Intl.message(
      'Vehicle registered successfully',
      name: 'vehicleRegisteredSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred during registration`
  String get errorDuringRegistration {
    return Intl.message(
      'An error occurred during registration',
      name: 'errorDuringRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Draft Saved`
  String get draftSaved {
    return Intl.message('Draft Saved', name: 'draftSaved', desc: '', args: []);
  }

  /// `Vehicle details saved as draft`
  String get vehicleSavedAsDraft {
    return Intl.message(
      'Vehicle details saved as draft',
      name: 'vehicleSavedAsDraft',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch Terms and Conditions`
  String get failedToFetchTerms {
    return Intl.message(
      'Failed to fetch Terms and Conditions',
      name: 'failedToFetchTerms',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Email or Mobile Number`
  String get pleaseEnterEmailOrMobile {
    return Intl.message(
      'Please enter your Email or Mobile Number',
      name: 'pleaseEnterEmailOrMobile',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your New Password`
  String get pleaseEnterNewPassword {
    return Intl.message(
      'Please enter your New Password',
      name: 'pleaseEnterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your Password`
  String get pleaseConfirmPassword {
    return Intl.message(
      'Please confirm your Password',
      name: 'pleaseConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `OTP sent successfully`
  String get otpSentSuccessfully {
    return Intl.message(
      'OTP sent successfully',
      name: 'otpSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the complete 6-digit OTP`
  String get enterComplete6DigitOtp {
    return Intl.message(
      'Please enter the complete 6-digit OTP',
      name: 'enterComplete6DigitOtp',
      desc: '',
      args: [],
    );
  }

  /// `Password reset successful`
  String get passwordResetSuccessful {
    return Intl.message(
      'Password reset successful',
      name: 'passwordResetSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Membership Subscription`
  String get membershipSubscription {
    return Intl.message(
      'Membership Subscription',
      name: 'membershipSubscription',
      desc: '',
      args: [],
    );
  }

  /// `Plan Type`
  String get planType {
    return Intl.message('Plan Type', name: 'planType', desc: '', args: []);
  }

  /// `Validity`
  String get validity {
    return Intl.message('Validity', name: 'validity', desc: '', args: []);
  }

  /// `Basic Membership Benefits`
  String get basicMembershipBenefits {
    return Intl.message(
      'Basic Membership Benefits',
      name: 'basicMembershipBenefits',
      desc: '',
      args: [],
    );
  }

  /// `Standard Plan`
  String get standardPlan {
    return Intl.message(
      'Standard Plan',
      name: 'standardPlan',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send message`
  String get failedToSendMessage {
    return Intl.message(
      'Failed to send message',
      name: 'failedToSendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send image`
  String get failedToSendImage {
    return Intl.message(
      'Failed to send image',
      name: 'failedToSendImage',
      desc: '',
      args: [],
    );
  }

  /// `Network Error`
  String get networkError {
    return Intl.message(
      'Network Error',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout. Please check your internet connection.`
  String get connectionTimeout {
    return Intl.message(
      'Connection timeout. Please check your internet connection.',
      name: 'connectionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Unable to connect to the server. Please verify your network.`
  String get unableToConnectServer {
    return Intl.message(
      'Unable to connect to the server. Please verify your network.',
      name: 'unableToConnectServer',
      desc: '',
      args: [],
    );
  }

  /// `Server error occurred.`
  String get serverErrorOccurred {
    return Intl.message(
      'Server error occurred.',
      name: 'serverErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Server returned an invalid response.`
  String get invalidServerResponse {
    return Intl.message(
      'Server returned an invalid response.',
      name: 'invalidServerResponse',
      desc: '',
      args: [],
    );
  }

  /// `Request was cancelled.`
  String get requestCancelled {
    return Intl.message(
      'Request was cancelled.',
      name: 'requestCancelled',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected network error occurred.`
  String get unexpectedNetworkError {
    return Intl.message(
      'An unexpected network error occurred.',
      name: 'unexpectedNetworkError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Mobile Number`
  String get pleaseEnterMobileNumber {
    return Intl.message(
      'Please enter your Mobile Number',
      name: 'pleaseEnterMobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number must contain only digits after +971`
  String get mobileDigitsOnly {
    return Intl.message(
      'Mobile number must contain only digits after +971',
      name: 'mobileDigitsOnly',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number must be exactly 9 digits after +971`
  String get mobileExactly9Digits {
    return Intl.message(
      'Mobile number must be exactly 9 digits after +971',
      name: 'mobileExactly9Digits',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number cannot be more than 9 digits after +971`
  String get mobileMax9Digits {
    return Intl.message(
      'Mobile number cannot be more than 9 digits after +971',
      name: 'mobileMax9Digits',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message('Information', name: 'information', desc: '', args: []);
  }

  /// `Payment method not implemented yet.`
  String get paymentMethodNotImplemented {
    return Intl.message(
      'Payment method not implemented yet.',
      name: 'paymentMethodNotImplemented',
      desc: '',
      args: [],
    );
  }

  /// `Payment Failed`
  String get paymentFailed {
    return Intl.message(
      'Payment Failed',
      name: 'paymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Payment was declined or failed. Please try again.`
  String get paymentDeclined {
    return Intl.message(
      'Payment was declined or failed. Please try again.',
      name: 'paymentDeclined',
      desc: '',
      args: [],
    );
  }

  /// `Payment Status`
  String get paymentStatus {
    return Intl.message(
      'Payment Status',
      name: 'paymentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Payment is still being confirmed. Please check Bookings in a moment.`
  String get paymentStillConfirming {
    return Intl.message(
      'Payment is still being confirmed. Please check Bookings in a moment.',
      name: 'paymentStillConfirming',
      desc: '',
      args: [],
    );
  }

  /// `Manage your account security`
  String get manageAccountSecurity {
    return Intl.message(
      'Manage your account security',
      name: 'manageAccountSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Enable Biometrics Login`
  String get enableBiometricsLogin {
    return Intl.message(
      'Enable Biometrics Login',
      name: 'enableBiometricsLogin',
      desc: '',
      args: [],
    );
  }

  /// `Biometrics functionality will be available in the next update.`
  String get biometricsComingSoon {
    return Intl.message(
      'Biometrics functionality will be available in the next update.',
      name: 'biometricsComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Two-Step Verification`
  String get twoStepVerification {
    return Intl.message(
      'Two-Step Verification',
      name: 'twoStepVerification',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get offStatus {
    return Intl.message('Off', name: 'offStatus', desc: '', args: []);
  }

  /// `Two-Step verification will be available in the next update.`
  String get twoStepComingSoon {
    return Intl.message(
      'Two-Step verification will be available in the next update.',
      name: 'twoStepComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Slot`
  String get selectYourSlot {
    return Intl.message(
      'Select Your Slot',
      name: 'selectYourSlot',
      desc: '',
      args: [],
    );
  }

  /// `No slots available for this type.`
  String get noSlotsForType {
    return Intl.message(
      'No slots available for this type.',
      name: 'noSlotsForType',
      desc: '',
      args: [],
    );
  }

  /// `FREE`
  String get slotFreeCaps {
    return Intl.message('FREE', name: 'slotFreeCaps', desc: '', args: []);
  }

  /// `BOOKED`
  String get slotBookedCaps {
    return Intl.message('BOOKED', name: 'slotBookedCaps', desc: '', args: []);
  }

  /// `Selected Type: {type}`
  String selectedTypeLabel(String type) {
    return Intl.message(
      'Selected Type: $type',
      name: 'selectedTypeLabel',
      desc: '',
      args: [type],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Choose date and time for selecting the slot`
  String get chooseDateTimeForSlot {
    return Intl.message(
      'Choose date and time for selecting the slot',
      name: 'chooseDateTimeForSlot',
      desc: '',
      args: [],
    );
  }

  /// `No membership packages available`
  String get noMembershipPackages {
    return Intl.message(
      'No membership packages available',
      name: 'noMembershipPackages',
      desc: '',
      args: [],
    );
  }

  /// `I agree to the `
  String get iAgreeToThe {
    return Intl.message(
      'I agree to the ',
      name: 'iAgreeToThe',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get hourUnit {
    return Intl.message('hour', name: 'hourUnit', desc: '', args: []);
  }

  /// `year`
  String get yearUnit {
    return Intl.message('year', name: 'yearUnit', desc: '', args: []);
  }

  /// `Parking`
  String get parkingFallback {
    return Intl.message('Parking', name: 'parkingFallback', desc: '', args: []);
  }

  /// `AM`
  String get amLabel {
    return Intl.message('AM', name: 'amLabel', desc: '', args: []);
  }

  /// `PM`
  String get pmLabel {
    return Intl.message('PM', name: 'pmLabel', desc: '', args: []);
  }

  /// `Take a Photo`
  String get takeAPhoto {
    return Intl.message('Take a Photo', name: 'takeAPhoto', desc: '', args: []);
  }

  /// `Choose from Gallery`
  String get chooseFromGallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'chooseFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Type your message here...`
  String get typeYourMessageHere {
    return Intl.message(
      'Type your message here...',
      name: 'typeYourMessageHere',
      desc: '',
      args: [],
    );
  }

  /// `How can we help you?`
  String get howCanWeHelp {
    return Intl.message(
      'How can we help you?',
      name: 'howCanWeHelp',
      desc: '',
      args: [],
    );
  }

  /// `Need help? Contact our support team anytime. We’re here to assist you with parking, memberships, payments, and more.`
  String get helpSupportDescription {
    return Intl.message(
      'Need help? Contact our support team anytime. We’re here to assist you with parking, memberships, payments, and more.',
      name: 'helpSupportDescription',
      desc: '',
      args: [],
    );
  }

  /// `Email Support`
  String get emailSupport {
    return Intl.message(
      'Email Support',
      name: 'emailSupport',
      desc: '',
      args: [],
    );
  }

  /// `Phone Support`
  String get phoneSupport {
    return Intl.message(
      'Phone Support',
      name: 'phoneSupport',
      desc: '',
      args: [],
    );
  }

  /// `Not available`
  String get notAvailable {
    return Intl.message(
      'Not available',
      name: 'notAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy not available.`
  String get privacyPolicyNotAvailable {
    return Intl.message(
      'Privacy policy not available.',
      name: 'privacyPolicyNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Profile picture`
  String get profilePicture {
    return Intl.message(
      'Profile picture',
      name: 'profilePicture',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Secure Payment`
  String get securePayment {
    return Intl.message(
      'Secure Payment',
      name: 'securePayment',
      desc: '',
      args: [],
    );
  }

  /// `JETSKI WITH TRAILER PARKING`
  String get mapJetskiTrailerParking {
    return Intl.message(
      'JETSKI WITH TRAILER PARKING',
      name: 'mapJetskiTrailerParking',
      desc: '',
      args: [],
    );
  }

  /// `BOATS PARKING - {section}`
  String mapBoatsParking(String section) {
    return Intl.message(
      'BOATS PARKING - $section',
      name: 'mapBoatsParking',
      desc: '',
      args: [section],
    );
  }

  /// `BOATS PARKING - {section} (SHADED)`
  String mapBoatsParkingShaded(String section) {
    return Intl.message(
      'BOATS PARKING - $section (SHADED)',
      name: 'mapBoatsParkingShaded',
      desc: '',
      args: [section],
    );
  }

  /// `CARAVAN PARKING - {section}`
  String mapCaravanParking(String section) {
    return Intl.message(
      'CARAVAN PARKING - $section',
      name: 'mapCaravanParking',
      desc: '',
      args: [section],
    );
  }

  /// `CARAVAN PARKING - {section}(SHADED)`
  String mapCaravanParkingShaded(String section) {
    return Intl.message(
      'CARAVAN PARKING - $section(SHADED)',
      name: 'mapCaravanParkingShaded',
      desc: '',
      args: [section],
    );
  }

  /// `FOOD TRUCK PARKING - Length {length}m`
  String mapFoodTruckParkingLength(String length) {
    return Intl.message(
      'FOOD TRUCK PARKING - Length ${length}m',
      name: 'mapFoodTruckParkingLength',
      desc: '',
      args: [length],
    );
  }

  /// `EXIT`
  String get mapExit {
    return Intl.message('EXIT', name: 'mapExit', desc: '', args: []);
  }

  /// `ENTRANCE`
  String get mapEntrance {
    return Intl.message('ENTRANCE', name: 'mapEntrance', desc: '', args: []);
  }

  /// `{name} Membership`
  String membershipTitle(String name) {
    return Intl.message(
      '$name Membership',
      name: 'membershipTitle',
      desc: '',
      args: [name],
    );
  }

  /// `{field} (Optional)`
  String optionalField(String field) {
    return Intl.message(
      '$field (Optional)',
      name: 'optionalField',
      desc: '',
      args: [field],
    );
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `e.g. Blue`
  String get colorHint {
    return Intl.message('e.g. Blue', name: 'colorHint', desc: '', args: []);
  }

  /// `Extra Amount`
  String get extraAmount {
    return Intl.message(
      'Extra Amount',
      name: 'extraAmount',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get userFallback {
    return Intl.message('User', name: 'userFallback', desc: '', args: []);
  }

  /// `Silver Member`
  String get silverMember {
    return Intl.message(
      'Silver Member',
      name: 'silverMember',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get titleFallback {
    return Intl.message('Title', name: 'titleFallback', desc: '', args: []);
  }

  /// `Reward`
  String get rewardFallback {
    return Intl.message('Reward', name: 'rewardFallback', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Guest`
  String get guest {
    return Intl.message('Guest', name: 'guest', desc: '', args: []);
  }

  /// `Spot {slot}`
  String spotLabel(String slot) {
    return Intl.message(
      'Spot $slot',
      name: 'spotLabel',
      desc: '',
      args: [slot],
    );
  }

  /// `Confirmed`
  String get stateConfirmed {
    return Intl.message(
      'Confirmed',
      name: 'stateConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get stateCancelled {
    return Intl.message(
      'Cancelled',
      name: 'stateCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get stateCompleted {
    return Intl.message(
      'Completed',
      name: 'stateCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get stateExpired {
    return Intl.message('Expired', name: 'stateExpired', desc: '', args: []);
  }

  /// `Draft`
  String get stateDraft {
    return Intl.message('Draft', name: 'stateDraft', desc: '', args: []);
  }

  /// `Pending Payment`
  String get statePendingPayment {
    return Intl.message(
      'Pending Payment',
      name: 'statePendingPayment',
      desc: '',
      args: [],
    );
  }

  /// `Paid`
  String get statePaid {
    return Intl.message('Paid', name: 'statePaid', desc: '', args: []);
  }

  /// `Hourly`
  String get planHourly {
    return Intl.message('Hourly', name: 'planHourly', desc: '', args: []);
  }

  /// `Daily`
  String get planDaily {
    return Intl.message('Daily', name: 'planDaily', desc: '', args: []);
  }

  /// `Weekly`
  String get planWeekly {
    return Intl.message('Weekly', name: 'planWeekly', desc: '', args: []);
  }

  /// `Monthly`
  String get planMonthly {
    return Intl.message('Monthly', name: 'planMonthly', desc: '', args: []);
  }

  /// `Yearly`
  String get planYearly {
    return Intl.message('Yearly', name: 'planYearly', desc: '', args: []);
  }

  /// `Me`
  String get meLabel {
    return Intl.message('Me', name: 'meLabel', desc: '', args: []);
  }

  /// `Support`
  String get supportLabel {
    return Intl.message('Support', name: 'supportLabel', desc: '', args: []);
  }

  /// `{count, plural, =1{{count} Day} other{{count} Days}}`
  String durationDays(int count) {
    return Intl.plural(
      count,
      one: '$count Day',
      other: '$count Days',
      name: 'durationDays',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{{count} Hour} other{{count} Hours}}`
  String durationHours(int count) {
    return Intl.plural(
      count,
      one: '$count Hour',
      other: '$count Hours',
      name: 'durationHours',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{{count} Minute} other{{count} Minutes}}`
  String durationMinutes(int count) {
    return Intl.plural(
      count,
      one: '$count Minute',
      other: '$count Minutes',
      name: 'durationMinutes',
      desc: '',
      args: [count],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
