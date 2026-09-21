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

  /// `Size : `
  String get sizeLabel {
    return Intl.message('Size : ', name: 'sizeLabel', desc: '', args: []);
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

  /// `{width}m x {length}m`
  String sizeFormat(String width, String length) {
    return Intl.message(
      '${width}m x ${length}m',
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
