// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(prefix) => "منطقة ${prefix}";

  static String m1(count) => "المتاح: ${count}";

  static String m2(count) =>
      "${Intl.plural(count, one: 'يوم واحد', two: 'يومان', few: '${count} أيام', many: '${count} يومًا', other: '${count} يوم')}";

  static String m3(count) =>
      "${Intl.plural(count, one: 'ساعة واحدة', two: 'ساعتان', few: '${count} ساعات', many: '${count} ساعة', other: '${count} ساعة')}";

  static String m4(count) =>
      "${Intl.plural(count, one: 'دقيقة واحدة', two: 'دقيقتان', few: '${count} دقائق', many: '${count} دقيقة', other: '${count} دقيقة')}";

  static String m5(number) => "الترخيص: ${number}";

  static String m6(section) => "موقف القوارب - ${section}";

  static String m7(section) => "موقف القوارب - ${section} (مظلل)";

  static String m8(section) => "موقف الكرفانات - ${section}";

  static String m9(section) => "موقف الكرفانات - ${section} (مظلل)";

  static String m10(length) => "موقف شاحنات الطعام - الطول ${length} م";

  static String m11(date) => "عضو منذ ${date}";

  static String m12(name) => "عضوية ${name}";

  static String m13(tab) => "لا توجد مدخلات لعلامة تبويب ${tab}";

  static String m14(membership) =>
      "لا توجد مواقف متاحة للمدة المحددة (${membership}). جرّب تاريخًا آخر أو نوع موقف مختلفًا.";

  static String m15(field) => "${field} (اختياري)";

  static String m16(spot) => "مركون في الموقف ${spot}";

  static String m17(type) => "موقف ${type}";

  static String m18(amount) => "دفع ${amount}";

  static String m19(count) => "${count} نقطة";

  static String m20(slotName) => "الموقف المختار: ${slotName}";

  static String m21(type) => "النوع المحدد: ${type}";

  static String m22(width, length) => "${width}م X ${length}م";

  static String m23(slot) => "الموقف ${slot}";

  static String m24(date) => "صالح حتى: ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutAlNawaras": MessageLookupByLibrary.simpleMessage("عن النورس"),
    "acceptTermsToContinue": MessageLookupByLibrary.simpleMessage(
      "يرجى الموافقة على الشروط والأحكام للمتابعة",
    ),
    "activePartner": MessageLookupByLibrary.simpleMessage("شريك نشط"),
    "activeStatus": MessageLookupByLibrary.simpleMessage("نشط"),
    "activeTab": MessageLookupByLibrary.simpleMessage("نشط"),
    "add": MessageLookupByLibrary.simpleMessage("إضافة"),
    "additionalService": MessageLookupByLibrary.simpleMessage("خدمة إضافية"),
    "additionalServices": MessageLookupByLibrary.simpleMessage("خدمات إضافية"),
    "addonServicesOptional": MessageLookupByLibrary.simpleMessage(
      "خدمات إضافية (اختياري)",
    ),
    "agreeToTerms": MessageLookupByLibrary.simpleMessage(
      "أوافق على شروط الخدمة وسياسة الخصوصية",
    ),
    "agreeToTermsPrivacy": MessageLookupByLibrary.simpleMessage(
      "من خلال المتابعة، فإنك توافق على شروط الخدمة\nوسياسة الخصوصية الخاصة بنا",
    ),
    "airConditioned": MessageLookupByLibrary.simpleMessage("مكيف"),
    "alNawaras": MessageLookupByLibrary.simpleMessage("النورس"),
    "allTab": MessageLookupByLibrary.simpleMessage("الكل"),
    "alreadyHaveAccount": MessageLookupByLibrary.simpleMessage(
      "هل لديك حساب بالفعل؟",
    ),
    "amLabel": MessageLookupByLibrary.simpleMessage("ص"),
    "amountExclVat": MessageLookupByLibrary.simpleMessage(
      "المبلغ (غير شامل الضريبة)",
    ),
    "amountLabel": MessageLookupByLibrary.simpleMessage("المبلغ"),
    "applePayLabel": MessageLookupByLibrary.simpleMessage("آبل باي"),
    "arabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "areaSuffix": m0,
    "available": MessageLookupByLibrary.simpleMessage("متاح"),
    "availableCount": m1,
    "availableSlotTypes": MessageLookupByLibrary.simpleMessage(
      "أنواع المواقف المتاحة",
    ),
    "awayFromParking": MessageLookupByLibrary.simpleMessage("بعيد عن الموقف"),
    "basicMembershipBenefits": MessageLookupByLibrary.simpleMessage(
      "مزايا العضوية الأساسية",
    ),
    "biometricsComingSoon": MessageLookupByLibrary.simpleMessage(
      "ستتوفر ميزة تسجيل الدخول بالبصمة في التحديث القادم.",
    ),
    "boatsParking": MessageLookupByLibrary.simpleMessage("مواقف القوارب"),
    "bookNow": MessageLookupByLibrary.simpleMessage("احجز الآن!"),
    "bookParking": MessageLookupByLibrary.simpleMessage("حجز موقف"),
    "booked": MessageLookupByLibrary.simpleMessage("محجوز"),
    "bookingCreatedSlotNotAssigned": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء حجزك، لكن تعذّر تخصيص الموقف. يرجى التواصل مع الدعم.",
    ),
    "bookingDetails": MessageLookupByLibrary.simpleMessage("تفاصيل الحجز"),
    "bookingHistory": MessageLookupByLibrary.simpleMessage("سجل الحجوزات"),
    "bookingPayment": MessageLookupByLibrary.simpleMessage("دفع الحجز"),
    "bookingSuccessful": MessageLookupByLibrary.simpleMessage(
      "نجحت عملية الحجز!",
    ),
    "bookings": MessageLookupByLibrary.simpleMessage("الحجوزات"),
    "buy": MessageLookupByLibrary.simpleMessage("شراء"),
    "buyNow": MessageLookupByLibrary.simpleMessage("اشترِ الآن!"),
    "camera": MessageLookupByLibrary.simpleMessage("الكاميرا"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "caravanParking": MessageLookupByLibrary.simpleMessage("مواقف الكرفانات"),
    "cardDetailsOnSecurePage": MessageLookupByLibrary.simpleMessage(
      "ستُدخل بيانات بطاقتك في صفحة الدفع الآمنة من Paymob بعد الضغط على ادفع.",
    ),
    "cashOnSite": MessageLookupByLibrary.simpleMessage("نقداً في الموقع"),
    "changePassword": MessageLookupByLibrary.simpleMessage("تغيير كلمة المرور"),
    "chassisHint": MessageLookupByLibrary.simpleMessage(
      "مثال: 1HGCM82633A123456",
    ),
    "chassisNumber": MessageLookupByLibrary.simpleMessage("رقم الشاسيه"),
    "checkNetworkDetail": MessageLookupByLibrary.simpleMessage(
      "يرجى التحقق من الشبكة والمحاولة مرة أخرى.",
    ),
    "checkRewards": MessageLookupByLibrary.simpleMessage("تحقق من المكافآت"),
    "chooseDateTimeForSlot": MessageLookupByLibrary.simpleMessage(
      "اختر التاريخ والوقت لتحديد الموقف",
    ),
    "chooseFromGallery": MessageLookupByLibrary.simpleMessage(
      "الاختيار من المعرض",
    ),
    "choosePlanNeeds": MessageLookupByLibrary.simpleMessage(
      "اختر خطة العضوية التي تناسب احتياجاتك",
    ),
    "close": MessageLookupByLibrary.simpleMessage("إغلاق"),
    "color": MessageLookupByLibrary.simpleMessage("اللون"),
    "colorHint": MessageLookupByLibrary.simpleMessage("مثال: أزرق"),
    "comingSoon": MessageLookupByLibrary.simpleMessage("قريبًا"),
    "comments": MessageLookupByLibrary.simpleMessage("تعليقات"),
    "completedTab": MessageLookupByLibrary.simpleMessage("مكتمل"),
    "confirm": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "confirmLocation": MessageLookupByLibrary.simpleMessage("تأكيد الموقع"),
    "confirmNewPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور الجديدة",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "confirmYourPassword": MessageLookupByLibrary.simpleMessage(
      "أكد كلمة المرور الخاصة بك",
    ),
    "confirmationEmailSent": MessageLookupByLibrary.simpleMessage(
      "تم إرسال بريد إلكتروني للتأكيد وفاتورة إلى\nعنوان بريدك الإلكتروني المسجل.",
    ),
    "connectionTimeout": MessageLookupByLibrary.simpleMessage(
      "انتهت مهلة الاتصال. يرجى التحقق من اتصالك بالإنترنت.",
    ),
    "couldNotOpenLink": MessageLookupByLibrary.simpleMessage(
      "تعذّر فتح الرابط",
    ),
    "createAccount": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
    "createPassword": MessageLookupByLibrary.simpleMessage("أنشئ كلمة مرور"),
    "credit": MessageLookupByLibrary.simpleMessage("إضافة"),
    "creditDebitCard": MessageLookupByLibrary.simpleMessage("بطاقة ائتمان/خصم"),
    "currency": MessageLookupByLibrary.simpleMessage("د.إ"),
    "currentlyNoItemsFoundPleaseTryLater": MessageLookupByLibrary.simpleMessage(
      "لا توجد عناصر حالياً، يرجى المحاولة لاحقاً",
    ),
    "dateTime": MessageLookupByLibrary.simpleMessage("التاريخ والوقت"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage("ليس لديك حساب؟"),
    "draftSaved": MessageLookupByLibrary.simpleMessage("تم حفظ المسودة"),
    "drivingLicense": MessageLookupByLibrary.simpleMessage(
      "رقم رخصة القيادة (اختياري)",
    ),
    "duration": MessageLookupByLibrary.simpleMessage("المدة"),
    "durationDays": m2,
    "durationHours": m3,
    "durationMinutes": m4,
    "earnPerBooking": MessageLookupByLibrary.simpleMessage(
      "اكسب 50 نقطة لكل حجز",
    ),
    "earnPoints": MessageLookupByLibrary.simpleMessage("كسب النقاط"),
    "editDetails": MessageLookupByLibrary.simpleMessage("تعديل التفاصيل"),
    "emailAddress": MessageLookupByLibrary.simpleMessage(
      "عنوان البريد الإلكتروني",
    ),
    "emailCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "لا يمكن ترك البريد الإلكتروني فارغًا",
    ),
    "emailMustContainAt": MessageLookupByLibrary.simpleMessage(
      "يجب أن يحتوي البريد الإلكتروني على الرمز @",
    ),
    "emailOrMobile": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني أو الهاتف",
    ),
    "emailSupport": MessageLookupByLibrary.simpleMessage(
      "الدعم عبر البريد الإلكتروني",
    ),
    "enableBiometricsLogin": MessageLookupByLibrary.simpleMessage(
      "تفعيل تسجيل الدخول بالبصمة",
    ),
    "endDateLabel": MessageLookupByLibrary.simpleMessage("تاريخ الانتهاء"),
    "endTimeAfterStartTime": MessageLookupByLibrary.simpleMessage(
      "يجب أن يكون وقت الانتهاء بعد وقت البدء",
    ),
    "endTimeLabel": MessageLookupByLibrary.simpleMessage("وقت الانتهاء"),
    "english": MessageLookupByLibrary.simpleMessage("الإنجليزية"),
    "enter6DigitOtp": MessageLookupByLibrary.simpleMessage(
      "أدخل رمز OTP المكون من 6 أرقام",
    ),
    "enterComplete6DigitOtp": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال رمز التحقق المكوّن من 6 أرقام كاملاً",
    ),
    "enterDetailsToReceiveOtp": MessageLookupByLibrary.simpleMessage(
      "الرجاء إدخال التفاصيل الخاصة بك لتلقي رمز OTP",
    ),
    "enterDrivingLicense": MessageLookupByLibrary.simpleMessage(
      "أدخل رقم رخصة القيادة",
    ),
    "enterEmail": MessageLookupByLibrary.simpleMessage("أدخل بريدك الإلكتروني"),
    "enterEmailOrMobile": MessageLookupByLibrary.simpleMessage(
      "أدخل البريد الإلكتروني أو الهاتف",
    ),
    "enterFullName": MessageLookupByLibrary.simpleMessage("أدخل اسمك الكامل"),
    "enterLicenseNumber": MessageLookupByLibrary.simpleMessage(
      "مثال: DXB 12345",
    ),
    "enterMobileNumber": MessageLookupByLibrary.simpleMessage(
      "أدخل رقم هاتفك المحمول",
    ),
    "enterNewPassword": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة المرور الجديدة",
    ),
    "enterPassword": MessageLookupByLibrary.simpleMessage("أدخل كلمة المرور"),
    "enterUsernameOrMobile": MessageLookupByLibrary.simpleMessage(
      "أدخل اسم المستخدم أو رقم الهاتف المحمول",
    ),
    "enterValidMobileOrEmail": MessageLookupByLibrary.simpleMessage(
      "أدخل رقم جوال إماراتي صالح (+971 XX XXX XXXX) أو بريدًا إلكترونيًا",
    ),
    "error": MessageLookupByLibrary.simpleMessage("خطأ"),
    "errorConfirmingLocation": MessageLookupByLibrary.simpleMessage(
      "الموقف غير موجود",
    ),
    "errorDuringRegistration": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ أثناء التسجيل",
    ),
    "errorServer": MessageLookupByLibrary.simpleMessage(
      "خطأ في الاتصال بالخادم",
    ),
    "extend": MessageLookupByLibrary.simpleMessage("تمديد"),
    "extraAmount": MessageLookupByLibrary.simpleMessage("مبلغ إضافي"),
    "facebookLoginComingSoon": MessageLookupByLibrary.simpleMessage(
      "سيتوفر تسجيل الدخول عبر Facebook في التحديث القادم",
    ),
    "failedToConfirmLocation": MessageLookupByLibrary.simpleMessage(
      "الموقف غير موجود",
    ),
    "failedToFetchAboutUs": MessageLookupByLibrary.simpleMessage(
      "تعذّر جلب رابط \"من نحن\"",
    ),
    "failedToFetchPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
      "تعذّر جلب سياسة الخصوصية",
    ),
    "failedToFetchSupportDetails": MessageLookupByLibrary.simpleMessage(
      "تعذّر جلب بيانات الدعم",
    ),
    "failedToFetchTerms": MessageLookupByLibrary.simpleMessage(
      "تعذّر جلب الشروط والأحكام",
    ),
    "failedToGeneratePaymentUrl": MessageLookupByLibrary.simpleMessage(
      "تعذّر إنشاء رابط الدفع. يرجى المحاولة مرة أخرى.",
    ),
    "failedToGetGoogleToken": MessageLookupByLibrary.simpleMessage(
      "تعذّر الحصول على رمز Google",
    ),
    "failedToSendImage": MessageLookupByLibrary.simpleMessage(
      "تعذّر إرسال الصورة",
    ),
    "failedToSendMessage": MessageLookupByLibrary.simpleMessage(
      "تعذّر إرسال الرسالة",
    ),
    "foodTruckParking": MessageLookupByLibrary.simpleMessage(
      "مواقف شاحنات الطعام",
    ),
    "foodTruckParking13m": MessageLookupByLibrary.simpleMessage(
      "موقف شاحنات الطعام – 13 م",
    ),
    "foodTruckParking17m": MessageLookupByLibrary.simpleMessage(
      "موقف شاحنات الطعام – 17 م",
    ),
    "forAllVehicleTypes": MessageLookupByLibrary.simpleMessage(
      "لكافة أنواع المركبات",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
    "freeParkingDay": MessageLookupByLibrary.simpleMessage("يوم مواقف مجاني"),
    "fullName": MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
    "gallery": MessageLookupByLibrary.simpleMessage("المعرض"),
    "genericVehicle": MessageLookupByLibrary.simpleMessage("مركبة عامة"),
    "getDirections": MessageLookupByLibrary.simpleMessage(
      "الحصول على الاتجاهات",
    ),
    "getHelpAccount": MessageLookupByLibrary.simpleMessage(
      "احصل على مساعدة بشأن حسابك",
    ),
    "goldTier": MessageLookupByLibrary.simpleMessage("ذهبي"),
    "googlePayLabel": MessageLookupByLibrary.simpleMessage("جوجل باي"),
    "guest": MessageLookupByLibrary.simpleMessage("ضيف"),
    "heightM": MessageLookupByLibrary.simpleMessage("الارتفاع (م)"),
    "helpSupport": MessageLookupByLibrary.simpleMessage("المساعدة والدعم"),
    "helpSupportDescription": MessageLookupByLibrary.simpleMessage(
      "هل تحتاج إلى مساعدة؟ تواصل مع فريق الدعم في أي وقت. نحن هنا لمساعدتك في المواقف والعضويات والمدفوعات وغير ذلك.",
    ),
    "home": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "hourUnit": MessageLookupByLibrary.simpleMessage("ساعة"),
    "howCanWeHelp": MessageLookupByLibrary.simpleMessage("كيف يمكننا مساعدتك؟"),
    "howToEarnPoints": MessageLookupByLibrary.simpleMessage("كيفية كسب النقاط"),
    "iAgreeToThe": MessageLookupByLibrary.simpleMessage("أوافق على "),
    "information": MessageLookupByLibrary.simpleMessage("معلومات"),
    "invalidDuration": MessageLookupByLibrary.simpleMessage("مدة غير صالحة"),
    "invalidEmailFormat": MessageLookupByLibrary.simpleMessage(
      "صيغة البريد الإلكتروني غير صحيحة",
    ),
    "invalidServerResponse": MessageLookupByLibrary.simpleMessage(
      "أرسل الخادم استجابة غير صالحة.",
    ),
    "inviteFriendsPoints": MessageLookupByLibrary.simpleMessage(
      "ادعُ الأصدقاء واكسب المزيد من النقاط!",
    ),
    "jetskiParking": MessageLookupByLibrary.simpleMessage("مواقف الجت سكي"),
    "jetskiWithTrailerParking": MessageLookupByLibrary.simpleMessage(
      "موقف الجت سكي مع المقطورة",
    ),
    "language": MessageLookupByLibrary.simpleMessage("اللغة"),
    "languageSubtitle": MessageLookupByLibrary.simpleMessage(
      "تغيير لغة التطبيق",
    ),
    "learnMoreServices": MessageLookupByLibrary.simpleMessage(
      "تعرف على المزيد عن خدماتنا",
    ),
    "lengthM": MessageLookupByLibrary.simpleMessage("الطول (م)"),
    "license": m5,
    "linkIsEmpty": MessageLookupByLibrary.simpleMessage("الرابط غير متوفر"),
    "loadMore": MessageLookupByLibrary.simpleMessage("تحميل المزيد"),
    "loading": MessageLookupByLibrary.simpleMessage("جارٍ التحميل..."),
    "location": MessageLookupByLibrary.simpleMessage("الموقع"),
    "locationCodeLabel": MessageLookupByLibrary.simpleMessage("رمز الموقع : "),
    "locationConfirmedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "تم تأكيد الموقع والموقف بنجاح",
    ),
    "locationLabel": MessageLookupByLibrary.simpleMessage("الموقع : "),
    "locationTypeLabel": MessageLookupByLibrary.simpleMessage("نوع الموقع : "),
    "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "loginFailedCheckCredentials": MessageLookupByLibrary.simpleMessage(
      "فشل تسجيل الدخول. يرجى التحقق من بيانات الدخول.",
    ),
    "loginSuccessful": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل الدخول بنجاح",
    ),
    "logout": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "logoutConfirm": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد أنك تريد تسجيل الخروج؟",
    ),
    "make": MessageLookupByLibrary.simpleMessage("الماركة"),
    "makeHint": MessageLookupByLibrary.simpleMessage("مثال: ياماها"),
    "manageAccountSecurity": MessageLookupByLibrary.simpleMessage(
      "إدارة أمان حسابك",
    ),
    "managePaymentOptions": MessageLookupByLibrary.simpleMessage(
      "إدارة خيارات الدفع",
    ),
    "manageSecurity": MessageLookupByLibrary.simpleMessage(
      "إدارة كلمة المرور والأمان",
    ),
    "mapBoatsParking": m6,
    "mapBoatsParkingShaded": m7,
    "mapCaravanParking": m8,
    "mapCaravanParkingShaded": m9,
    "mapEntrance": MessageLookupByLibrary.simpleMessage("دخول"),
    "mapExit": MessageLookupByLibrary.simpleMessage("خروج"),
    "mapFoodTruckParkingLength": m10,
    "mapJetskiTrailerParking": MessageLookupByLibrary.simpleMessage(
      "موقف الجت سكي مع المقطورة",
    ),
    "meLabel": MessageLookupByLibrary.simpleMessage("أنا"),
    "memberSince": m11,
    "membership": MessageLookupByLibrary.simpleMessage("العضوية"),
    "membershipPackage": MessageLookupByLibrary.simpleMessage("باقة العضوية"),
    "membershipPlans": MessageLookupByLibrary.simpleMessage("خطط العضوية"),
    "membershipStatusLabel": MessageLookupByLibrary.simpleMessage(
      "حالة العضوية",
    ),
    "membershipSubscription": MessageLookupByLibrary.simpleMessage(
      "اشتراك العضوية",
    ),
    "membershipTitle": m12,
    "membershipType": MessageLookupByLibrary.simpleMessage("نوع العضوية"),
    "mobileDigitsOnly": MessageLookupByLibrary.simpleMessage(
      "يجب أن يحتوي رقم الجوال على أرقام فقط بعد +971",
    ),
    "mobileExactly9Digits": MessageLookupByLibrary.simpleMessage(
      "يجب أن يتكون رقم الجوال من 9 أرقام بالضبط بعد +971",
    ),
    "mobileHint": MessageLookupByLibrary.simpleMessage("+971 XX XXX XXXX"),
    "mobileMax9Digits": MessageLookupByLibrary.simpleMessage(
      "لا يمكن أن يتجاوز رقم الجوال 9 أرقام بعد +971",
    ),
    "mobileNumber": MessageLookupByLibrary.simpleMessage("رقم الهاتف المحمول"),
    "model": MessageLookupByLibrary.simpleMessage("الموديل"),
    "modelHint": MessageLookupByLibrary.simpleMessage("مثال: كارافيل"),
    "month": MessageLookupByLibrary.simpleMessage("شهر"),
    "monthlyMembership": MessageLookupByLibrary.simpleMessage("عضوية شهرية"),
    "monthlyPremium": MessageLookupByLibrary.simpleMessage("قسط شهري"),
    "myVehicles": MessageLookupByLibrary.simpleMessage("مركباتي"),
    "nameCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
      "لا يمكن ترك الاسم فارغًا",
    ),
    "navigateSelectSlot": MessageLookupByLibrary.simpleMessage(
      "يرجى التنقل لاختيار موقف السيارات الذي تفضله.",
    ),
    "navigateToYourParking": MessageLookupByLibrary.simpleMessage(
      "انتقل إلى\nموقف سيارتك",
    ),
    "needAssistanceCall": MessageLookupByLibrary.simpleMessage(
      "هل تحتاج إلى مساعدة؟ اتصل بنا على 800-NAWRAS.",
    ),
    "needHelp": MessageLookupByLibrary.simpleMessage("تحتاج مساعدة؟"),
    "networkError": MessageLookupByLibrary.simpleMessage("خطأ في الشبكة"),
    "networkErrorTryAgain": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ في الشبكة. يرجى المحاولة مرة أخرى.",
    ),
    "newPassword": MessageLookupByLibrary.simpleMessage("كلمة مرور جديدة"),
    "next": MessageLookupByLibrary.simpleMessage("التالي"),
    "no": MessageLookupByLibrary.simpleMessage("لا"),
    "noActiveBooking": MessageLookupByLibrary.simpleMessage("لا يوجد حجز نشط"),
    "noActiveBookings": MessageLookupByLibrary.simpleMessage(
      "لا توجد حجوزات نشطة",
    ),
    "noActivePlan": MessageLookupByLibrary.simpleMessage("لا توجد خطة نشطة"),
    "noBookingHistoryFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على سجل حجوزات",
    ),
    "noCompletedBookings": MessageLookupByLibrary.simpleMessage(
      "لا توجد حجوزات مكتملة",
    ),
    "noDataAvailable": MessageLookupByLibrary.simpleMessage("لا تتوفر بيانات"),
    "noDescriptionAvailable": MessageLookupByLibrary.simpleMessage(
      "لا يوجد وصف متاح",
    ),
    "noEntriesForTab": m13,
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "لا يوجد اتصال بالإنترنت",
    ),
    "noMembershipPackages": MessageLookupByLibrary.simpleMessage(
      "لا توجد باقات عضوية متاحة",
    ),
    "noNotifications": MessageLookupByLibrary.simpleMessage("لا توجد إشعارات"),
    "noPlansFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على خطط عضوية",
    ),
    "noRedeemableRewards": MessageLookupByLibrary.simpleMessage(
      "لا توجد مكافآت قابلة للاستبدال",
    ),
    "noRulesFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على قواعد",
    ),
    "noSearchResults": MessageLookupByLibrary.simpleMessage(
      "لا توجد مواقع أو مركبات أو حجوزات مطابقة",
    ),
    "noServicesAvailable": MessageLookupByLibrary.simpleMessage(
      "لا توجد خدمات متاحة",
    ),
    "noServicesFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على خدمات",
    ),
    "noSlotTypesAvailable": MessageLookupByLibrary.simpleMessage(
      "لا توجد أنواع مواقف متاحة للوقت المختار",
    ),
    "noSlotsAvailable": MessageLookupByLibrary.simpleMessage(
      "لا توجد مواقف متاحة",
    ),
    "noSlotsForType": MessageLookupByLibrary.simpleMessage(
      "لا توجد مواقف متاحة لهذا النوع.",
    ),
    "noStatus": MessageLookupByLibrary.simpleMessage("لا توجد حالة"),
    "noUnitsForDuration": m14,
    "noVehicleTypesAvailable": MessageLookupByLibrary.simpleMessage(
      "لا توجد أنواع مركبات متاحة",
    ),
    "noVehiclesFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على مركبات",
    ),
    "nolPayLabel": MessageLookupByLibrary.simpleMessage("نول باي"),
    "notAvailable": MessageLookupByLibrary.simpleMessage("غير متوفر"),
    "notAvailableShort": MessageLookupByLibrary.simpleMessage("غير متوفر"),
    "notice": MessageLookupByLibrary.simpleMessage("تنبيه"),
    "notification": MessageLookupByLibrary.simpleMessage("إشعار"),
    "notifications": MessageLookupByLibrary.simpleMessage("الإشعارات"),
    "off": MessageLookupByLibrary.simpleMessage("خصم"),
    "offStatus": MessageLookupByLibrary.simpleMessage("متوقف"),
    "onlinePaymentNotAvailable": MessageLookupByLibrary.simpleMessage(
      "الدفع الإلكتروني لهذا العنصر غير متاح حالياً. يرجى التواصل مع الدعم.",
    ),
    "open": MessageLookupByLibrary.simpleMessage("مفتوح"),
    "opportunity": MessageLookupByLibrary.simpleMessage("فرصة!"),
    "optionalField": m15,
    "orSignInWith": MessageLookupByLibrary.simpleMessage(
      "أو سجل الدخول باستخدام",
    ),
    "otpSentSuccessfully": MessageLookupByLibrary.simpleMessage(
      "تم إرسال رمز التحقق بنجاح",
    ),
    "parkedAtSpot": m16,
    "parkingFallback": MessageLookupByLibrary.simpleMessage("موقف"),
    "parkingPayment": MessageLookupByLibrary.simpleMessage("دفع رسوم الموقف"),
    "parkingRenewed": MessageLookupByLibrary.simpleMessage("تم تجديد الموقف"),
    "parkingType": MessageLookupByLibrary.simpleMessage("نوع الموقف"),
    "parkingTypeSubtitle": m17,
    "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "يجب ألا تقل كلمة المرور عن 6 أحرف",
    ),
    "passwordResetSuccessful": MessageLookupByLibrary.simpleMessage(
      "تمت إعادة تعيين كلمة المرور بنجاح",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "كلمتا المرور غير متطابقتين",
    ),
    "pay": MessageLookupByLibrary.simpleMessage("ادفع"),
    "payAmount": m18,
    "payPalLabel": MessageLookupByLibrary.simpleMessage("باي بال"),
    "payment": MessageLookupByLibrary.simpleMessage("الدفع"),
    "paymentDeclined": MessageLookupByLibrary.simpleMessage(
      "تم رفض الدفع أو فشله. يرجى المحاولة مرة أخرى.",
    ),
    "paymentFailed": MessageLookupByLibrary.simpleMessage("فشل الدفع"),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("طريقة الدفع"),
    "paymentMethodNotImplemented": MessageLookupByLibrary.simpleMessage(
      "طريقة الدفع هذه غير متاحة بعد.",
    ),
    "paymentMethods": MessageLookupByLibrary.simpleMessage("طرق الدفع"),
    "paymentProcessedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "تمت معالجة دفعتك\nبنجاح.",
    ),
    "paymentStatus": MessageLookupByLibrary.simpleMessage("حالة الدفع"),
    "paymentStillConfirming": MessageLookupByLibrary.simpleMessage(
      "لا يزال تأكيد الدفع قيد المعالجة. يرجى مراجعة الحجوزات بعد قليل.",
    ),
    "paymentSuccessful": MessageLookupByLibrary.simpleMessage(
      "نجحت عملية الدفع!",
    ),
    "paymentSummary": MessageLookupByLibrary.simpleMessage("ملخص الدفع"),
    "per": MessageLookupByLibrary.simpleMessage("لكل"),
    "periodDay": MessageLookupByLibrary.simpleMessage("يوم"),
    "periodHour": MessageLookupByLibrary.simpleMessage("ساعة"),
    "periodMonth": MessageLookupByLibrary.simpleMessage("شهر"),
    "periodWeek": MessageLookupByLibrary.simpleMessage("أسبوع"),
    "periodYear": MessageLookupByLibrary.simpleMessage("سنة"),
    "personalInformation": MessageLookupByLibrary.simpleMessage(
      "المعلومات الشخصية",
    ),
    "phoneSupport": MessageLookupByLibrary.simpleMessage("الدعم الهاتفي"),
    "planDaily": MessageLookupByLibrary.simpleMessage("يومي"),
    "planHourly": MessageLookupByLibrary.simpleMessage("بالساعة"),
    "planMonthly": MessageLookupByLibrary.simpleMessage("شهري"),
    "planType": MessageLookupByLibrary.simpleMessage("نوع الخطة"),
    "planWeekly": MessageLookupByLibrary.simpleMessage("أسبوعي"),
    "planYearly": MessageLookupByLibrary.simpleMessage("سنوي"),
    "pleaseAcceptTerms": MessageLookupByLibrary.simpleMessage(
      "يرجى الموافقة على الشروط والأحكام",
    ),
    "pleaseConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "يرجى تأكيد كلمة المرور",
    ),
    "pleaseEnterEmailAddress": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال البريد الإلكتروني",
    ),
    "pleaseEnterEmailOrMobile": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال البريد الإلكتروني أو رقم الجوال",
    ),
    "pleaseEnterFullName": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال الاسم الكامل",
    ),
    "pleaseEnterMobileNumber": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال رقم الجوال",
    ),
    "pleaseEnterNewPassword": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال كلمة المرور الجديدة",
    ),
    "pleaseEnterPassword": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال كلمة المرور",
    ),
    "pleaseEnterPlateNumber": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال رقم لوحة المركبة",
    ),
    "pleaseEnterUsernameOrMobile": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال اسم المستخدم أو رقم الجوال",
    ),
    "pleaseProvideVehicleDetails": MessageLookupByLibrary.simpleMessage(
      "يرجى تقديم تفاصيل سيارتك",
    ),
    "pleaseSelectDateTimeFirst": MessageLookupByLibrary.simpleMessage(
      "يرجى اختيار التاريخ والوقت أولاً",
    ),
    "pmLabel": MessageLookupByLibrary.simpleMessage("م"),
    "points": MessageLookupByLibrary.simpleMessage("النقاط"),
    "pointsCount": m19,
    "pointsPerShare": MessageLookupByLibrary.simpleMessage(
      "10 نقاط لكل مشاركة",
    ),
    "premiumParkingSolutions": MessageLookupByLibrary.simpleMessage(
      "حلول مواقف متميزة",
    ),
    "privacyPolicy": MessageLookupByLibrary.simpleMessage("سياسة الخصوصية"),
    "privacyPolicyNotAvailable": MessageLookupByLibrary.simpleMessage(
      "سياسة الخصوصية غير متوفرة.",
    ),
    "privacyPolicySubtitle": MessageLookupByLibrary.simpleMessage(
      "راجع سياسة الخصوصية الخاصة بنا",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
    "profilePicture": MessageLookupByLibrary.simpleMessage("صورة الملف الشخصي"),
    "provideDetailsToRegister": MessageLookupByLibrary.simpleMessage(
      "يرجى تقديم التفاصيل الخاصة بك لإنشاء حساب",
    ),
    "pts": MessageLookupByLibrary.simpleMessage("نقاط"),
    "recentActivity": MessageLookupByLibrary.simpleMessage("النشاط الأخير"),
    "redeem": MessageLookupByLibrary.simpleMessage("استبدال"),
    "redeemPoints": MessageLookupByLibrary.simpleMessage("استبدال النقاط"),
    "redeemYourRewards": MessageLookupByLibrary.simpleMessage("استبدل مكافآتك"),
    "referenceLabel": MessageLookupByLibrary.simpleMessage("المرجع"),
    "register": MessageLookupByLibrary.simpleMessage("تسجيل"),
    "registerLater": MessageLookupByLibrary.simpleMessage("التسجيل لاحقاً"),
    "registerNewVehicle": MessageLookupByLibrary.simpleMessage(
      "تسجيل مركبة جديدة",
    ),
    "registrationFailed": MessageLookupByLibrary.simpleMessage("فشل التسجيل"),
    "registrationSuccessful": MessageLookupByLibrary.simpleMessage(
      "تم التسجيل بنجاح",
    ),
    "rememberMe": MessageLookupByLibrary.simpleMessage("تذكرني"),
    "remove": MessageLookupByLibrary.simpleMessage("إزالة"),
    "renew": MessageLookupByLibrary.simpleMessage("تجديد"),
    "replace": MessageLookupByLibrary.simpleMessage("استبدال"),
    "requestCancelled": MessageLookupByLibrary.simpleMessage("تم إلغاء الطلب."),
    "requestService": MessageLookupByLibrary.simpleMessage("طلب خدمة"),
    "required": MessageLookupByLibrary.simpleMessage("مطلوب"),
    "resetYourPassword": MessageLookupByLibrary.simpleMessage(
      "إعادة تعيين كلمة المرور",
    ),
    "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "rewardFallback": MessageLookupByLibrary.simpleMessage("مكافأة"),
    "rewards": MessageLookupByLibrary.simpleMessage("المكافآت"),
    "saveCardForFuture": MessageLookupByLibrary.simpleMessage(
      "حفظ البطاقة للمدفوعات المستقبلية",
    ),
    "saveChanges": MessageLookupByLibrary.simpleMessage("حفظ التغييرات"),
    "search": MessageLookupByLibrary.simpleMessage("بحث"),
    "searchResults": MessageLookupByLibrary.simpleMessage("نتائج البحث"),
    "securePayment": MessageLookupByLibrary.simpleMessage("دفع آمن"),
    "securedSlots": MessageLookupByLibrary.simpleMessage(
      "أكثر من 300 موقف مؤمن للكرفانات،\nوالقوارب، والجت سكي والمزيد.",
    ),
    "security": MessageLookupByLibrary.simpleMessage("الأمان"),
    "select": MessageLookupByLibrary.simpleMessage("اختر"),
    "selectAvailableSlotType": MessageLookupByLibrary.simpleMessage(
      "يرجى اختيار نوع موقف متاح.",
    ),
    "selectAvailableSlotTypeFirst": MessageLookupByLibrary.simpleMessage(
      "يرجى اختيار نوع موقف متاح أولاً",
    ),
    "selectParkingLocation": MessageLookupByLibrary.simpleMessage(
      "اختر موقع الموقف",
    ),
    "selectRangeServices": MessageLookupByLibrary.simpleMessage(
      "اختر من مجموعتنا من الخدمات الإضافية",
    ),
    "selectSlotFromAvailableTypes": MessageLookupByLibrary.simpleMessage(
      "يرجى اختيار موقف من الأنواع المتاحة.",
    ),
    "selectSlotOnMapFirst": MessageLookupByLibrary.simpleMessage(
      "يرجى اختيار موقف من الخريطة أولاً.",
    ),
    "selectStartAndEndDateTime": MessageLookupByLibrary.simpleMessage(
      "يرجى اختيار تاريخ ووقت البداية والنهاية.",
    ),
    "selectVehicle": MessageLookupByLibrary.simpleMessage("اختر المركبة"),
    "selectVehicleBeforeProceeding": MessageLookupByLibrary.simpleMessage(
      "يرجى اختيار مركبة قبل المتابعة.",
    ),
    "selectVehicleType": MessageLookupByLibrary.simpleMessage(
      "اختر نوع المركبة",
    ),
    "selectYourSlot": MessageLookupByLibrary.simpleMessage("اختر موقفك"),
    "selected": MessageLookupByLibrary.simpleMessage("محدد"),
    "selectedSlot": m20,
    "selectedTypeLabel": m21,
    "selectionFullOrBooked": MessageLookupByLibrary.simpleMessage(
      "هذا الاختيار ممتلئ حاليًا أو محجوز مسبقًا.",
    ),
    "selectionRequired": MessageLookupByLibrary.simpleMessage("مطلوب الاختيار"),
    "send": MessageLookupByLibrary.simpleMessage("إرسال"),
    "sendOtp": MessageLookupByLibrary.simpleMessage("إرسال رمز OTP"),
    "serverErrorOccurred": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ في الخادم.",
    ),
    "service": MessageLookupByLibrary.simpleMessage("خدمة"),
    "serviceName": MessageLookupByLibrary.simpleMessage("اسم الخدمة"),
    "services": MessageLookupByLibrary.simpleMessage("الخدمات"),
    "shaded": MessageLookupByLibrary.simpleMessage("مظلل"),
    "shadedParkingDetail": MessageLookupByLibrary.simpleMessage("مواقف مظللة"),
    "share": MessageLookupByLibrary.simpleMessage("مشاركة"),
    "shareEarn": MessageLookupByLibrary.simpleMessage("شارك واكسب"),
    "shareMessage": MessageLookupByLibrary.simpleMessage(
      "اطلع على تطبيق النورس للمواقف! أنا أستمتع بالمكافآت. قم بالتنزيل الآن وابدأ في كسب النقاط.",
    ),
    "sharing": MessageLookupByLibrary.simpleMessage("مشاركة"),
    "signIn": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "signInToYourAccount": MessageLookupByLibrary.simpleMessage(
      "تسجيل الدخول إلى حسابك",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "signUp": MessageLookupByLibrary.simpleMessage("اشتراك"),
    "silverMember": MessageLookupByLibrary.simpleMessage("عضو فضي"),
    "silverTier": MessageLookupByLibrary.simpleMessage("فضي"),
    "sizeFormat": m22,
    "sizeLabel": MessageLookupByLibrary.simpleMessage("حجم الموقف : "),
    "sizeShortLabel": MessageLookupByLibrary.simpleMessage("الحجم:"),
    "skip": MessageLookupByLibrary.simpleMessage("تخطي"),
    "slotAlreadyBooked": MessageLookupByLibrary.simpleMessage(
      "هذا الموقف محجوز بالفعل ولا يمكن اختياره.",
    ),
    "slotBookedCaps": MessageLookupByLibrary.simpleMessage("محجوز"),
    "slotFreeCaps": MessageLookupByLibrary.simpleMessage("متاح"),
    "slotNotFoundOrConfirmed": MessageLookupByLibrary.simpleMessage(
      "تعذّر العثور على الموقف المحدد أو تأكيده. يرجى اختيار موقف آخر.",
    ),
    "slotNumberLabel": MessageLookupByLibrary.simpleMessage("رقم الموقف : "),
    "slotType": MessageLookupByLibrary.simpleMessage("نوع الموقف"),
    "slotUnavailable": MessageLookupByLibrary.simpleMessage("الموقف غير متاح"),
    "smartParking": MessageLookupByLibrary.simpleMessage("المواقف الذكية"),
    "somethingWentWrong": MessageLookupByLibrary.simpleMessage("حدث خطأ ما"),
    "spotLabel": m23,
    "standard": MessageLookupByLibrary.simpleMessage("قياسي"),
    "standardPlan": MessageLookupByLibrary.simpleMessage("الخطة القياسية"),
    "standardTier": MessageLookupByLibrary.simpleMessage("أساسي"),
    "startDate": MessageLookupByLibrary.simpleMessage("تاريخ البدء"),
    "startDateLabel": MessageLookupByLibrary.simpleMessage("تاريخ البدء"),
    "startTime": MessageLookupByLibrary.simpleMessage("وقت البدء"),
    "stateCancelled": MessageLookupByLibrary.simpleMessage("ملغى"),
    "stateCompleted": MessageLookupByLibrary.simpleMessage("مكتمل"),
    "stateConfirmed": MessageLookupByLibrary.simpleMessage("مؤكد"),
    "stateDraft": MessageLookupByLibrary.simpleMessage("مسودة"),
    "stateExpired": MessageLookupByLibrary.simpleMessage("منتهي"),
    "statePaid": MessageLookupByLibrary.simpleMessage("مدفوع"),
    "statePendingPayment": MessageLookupByLibrary.simpleMessage(
      "بانتظار الدفع",
    ),
    "status": MessageLookupByLibrary.simpleMessage("الحالة"),
    "subtotal": MessageLookupByLibrary.simpleMessage("المجموع الفرعي"),
    "subtotalLabel": MessageLookupByLibrary.simpleMessage("المجموع الفرعي"),
    "success": MessageLookupByLibrary.simpleMessage("تم بنجاح"),
    "supportLabel": MessageLookupByLibrary.simpleMessage("الدعم"),
    "takeAPhoto": MessageLookupByLibrary.simpleMessage("التقاط صورة"),
    "tapToUploadDocument": MessageLookupByLibrary.simpleMessage(
      "اضغط لتحميل وثيقة التسجيل",
    ),
    "tapToUploadPhoto": MessageLookupByLibrary.simpleMessage(
      "اضغط لتحميل صورة المركبة",
    ),
    "termsAndConditions": MessageLookupByLibrary.simpleMessage(
      "الأحكام والشروط",
    ),
    "thankYou": MessageLookupByLibrary.simpleMessage("شكراً لك!"),
    "thirtyDays": MessageLookupByLibrary.simpleMessage("30 يوماً"),
    "titleFallback": MessageLookupByLibrary.simpleMessage("العنوان"),
    "toGoldMember": MessageLookupByLibrary.simpleMessage("إلى العضو الذهبي"),
    "today": MessageLookupByLibrary.simpleMessage("اليوم"),
    "tokenNotFound": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على رمز الدخول",
    ),
    "total": MessageLookupByLibrary.simpleMessage("المجموع"),
    "totalAmount": MessageLookupByLibrary.simpleMessage("المبلغ الإجمالي"),
    "totalLabel": MessageLookupByLibrary.simpleMessage("الإجمالي"),
    "totalPoints": MessageLookupByLibrary.simpleMessage("إجمالي النقاط"),
    "tryAgain": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "twoStepComingSoon": MessageLookupByLibrary.simpleMessage(
      "سيتوفر التحقق بخطوتين في التحديث القادم.",
    ),
    "twoStepVerification": MessageLookupByLibrary.simpleMessage(
      "التحقق بخطوتين",
    ),
    "typeLabel": MessageLookupByLibrary.simpleMessage("النوع"),
    "typeYourMessageHere": MessageLookupByLibrary.simpleMessage(
      "اكتب رسالتك هنا...",
    ),
    "unableToCheckSlotAvailability": MessageLookupByLibrary.simpleMessage(
      "تعذّر التحقق من توفر المواقف",
    ),
    "unableToConnectServer": MessageLookupByLibrary.simpleMessage(
      "تعذّر الاتصال بالخادم. يرجى التحقق من الشبكة.",
    ),
    "unableToCreateBooking": MessageLookupByLibrary.simpleMessage(
      "تعذّر إنشاء الحجز. يرجى المحاولة مرة أخرى.",
    ),
    "unableToFetchAvailability": MessageLookupByLibrary.simpleMessage(
      "تعذّر جلب التوفر",
    ),
    "unableToLoadRewards": MessageLookupByLibrary.simpleMessage(
      "تعذر تحميل المكافآت",
    ),
    "unexpectedError": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ غير متوقع.",
    ),
    "unexpectedNetworkError": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ غير متوقع في الشبكة.",
    ),
    "unshaded": MessageLookupByLibrary.simpleMessage("غير مظلل"),
    "update": MessageLookupByLibrary.simpleMessage("تحديث"),
    "updateFailed": MessageLookupByLibrary.simpleMessage("فشل التحديث"),
    "updatePersonalDetails": MessageLookupByLibrary.simpleMessage(
      "تحديث بياناتك الشخصية",
    ),
    "updateSuccessful": MessageLookupByLibrary.simpleMessage(
      "تم التحديث بنجاح",
    ),
    "userAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "المستخدم موجود مسبقًا. يرجى تسجيل الدخول أو استخدام بريد إلكتروني آخر.",
    ),
    "userFallback": MessageLookupByLibrary.simpleMessage("مستخدم"),
    "usernameOrMobile": MessageLookupByLibrary.simpleMessage(
      "اسم المستخدم أو رقم الهاتف المحمول",
    ),
    "validUntil": m24,
    "validity": MessageLookupByLibrary.simpleMessage("الصلاحية"),
    "vat": MessageLookupByLibrary.simpleMessage("ضريبة القيمة المضافة (5٪)"),
    "vatLabel": MessageLookupByLibrary.simpleMessage(
      "ضريبة القيمة المضافة (5%)",
    ),
    "vehicle": MessageLookupByLibrary.simpleMessage("المركبة"),
    "vehicleCheckIn": MessageLookupByLibrary.simpleMessage(
      "تسجيل دخول المركبة",
    ),
    "vehicleDimensions": MessageLookupByLibrary.simpleMessage("أبعاد المركبة"),
    "vehicleDirection": MessageLookupByLibrary.simpleMessage("اتجاه المركبة"),
    "vehicleLabel": MessageLookupByLibrary.simpleMessage("المركبة"),
    "vehicleLicenseNumber": MessageLookupByLibrary.simpleMessage(
      "رقم لوحة المركبة",
    ),
    "vehiclePhoto": MessageLookupByLibrary.simpleMessage("صورة المركبة"),
    "vehicleRegisteredSuccessfully": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل المركبة بنجاح",
    ),
    "vehicleRegistrationDocument": MessageLookupByLibrary.simpleMessage(
      "وثيقة تسجيل المركبة",
    ),
    "vehicleSavedAsDraft": MessageLookupByLibrary.simpleMessage(
      "تم حفظ بيانات المركبة كمسودة",
    ),
    "vehicleType": MessageLookupByLibrary.simpleMessage("نوع المركبة"),
    "verifyOtp": MessageLookupByLibrary.simpleMessage("تحقق من رمز OTP"),
    "viewAll": MessageLookupByLibrary.simpleMessage("عرض الكل"),
    "viewDetails": MessageLookupByLibrary.simpleMessage("عرض التفاصيل"),
    "viewPastBookings": MessageLookupByLibrary.simpleMessage(
      "عرض الحجوزات السابقة",
    ),
    "viewTerms": MessageLookupByLibrary.simpleMessage("عرض الشروط والأحكام"),
    "washService": MessageLookupByLibrary.simpleMessage("خدمة غسيل"),
    "weWillBeBackSoon": MessageLookupByLibrary.simpleMessage("سنعود قريباً"),
    "welcome": MessageLookupByLibrary.simpleMessage("مرحباً"),
    "welcomeBack": MessageLookupByLibrary.simpleMessage("مرحباً بعودتك!"),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "مواقف آمنة للكرفانات، والجت سكي، \nوشاحنات الطعام والقوارب والمزيد",
    ),
    "widthM": MessageLookupByLibrary.simpleMessage("العرض (م)"),
    "year": MessageLookupByLibrary.simpleMessage("السنة"),
    "yearHint": MessageLookupByLibrary.simpleMessage("مثال: 2020"),
    "yearUnit": MessageLookupByLibrary.simpleMessage("سنة"),
    "yes": MessageLookupByLibrary.simpleMessage("نعم"),
    "yesterday": MessageLookupByLibrary.simpleMessage("أمس"),
  };
}
