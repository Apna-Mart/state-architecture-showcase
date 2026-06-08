// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'अपना मार्ट';

  @override
  String get paymentFailedRetry => 'भुगतान विफल रहा। कृपया पुनः प्रयास करें।';

  @override
  String get invalidOtpMessage => 'अमान्य OTP। कोई भी 6 अंक दर्ज करें।';

  @override
  String get somethingWentWrong => 'कुछ गलत हो गया। फिर से प्रयास करें।';

  @override
  String get storageFailedMessage =>
      'इस डिवाइस पर आपके बदलाव सहेजे नहीं जा सके।';

  @override
  String get mobileNumber => 'मोबाइल नंबर';

  @override
  String get sendOtp => 'OTP भेजें';

  @override
  String get enterOtp => 'OTP दर्ज करें';

  @override
  String otpSentTo(String phone) {
    return '$phone पर OTP भेजा गया';
  }

  @override
  String get verify => 'सत्यापित करें';

  @override
  String get changeNumber => 'नंबर बदलें';

  @override
  String get upcomingBills => 'आगामी बिल';

  @override
  String get savedBillers => 'सहेजे गए बिलर';

  @override
  String get payABill => 'बिल भुगतान करें';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get billers => 'बिलर';

  @override
  String get searchBillers => 'बिलर खोजें';

  @override
  String get typeAtLeastTwoCharacters => 'कम से कम 2 अक्षर लिखें';

  @override
  String noBillersMatch(String query) {
    return '\"$query\" से मेल खाता कोई बिलर नहीं';
  }

  @override
  String get searchFailed => 'खोज विफल रही';

  @override
  String get billDetails => 'बिल विवरण';

  @override
  String get amountFieldLabel => 'राशि (₹)';

  @override
  String get enterAmount => 'राशि दर्ज करें';

  @override
  String get continueLabel => 'जारी रखें';

  @override
  String get fetchBill => 'बिल प्राप्त करें';

  @override
  String get reviewAndPay => 'समीक्षा करें और भुगतान करें';

  @override
  String accountValue(String account) {
    return 'खाता: $account';
  }

  @override
  String nameValue(String name) {
    return 'नाम: $name';
  }

  @override
  String payAmount(String amount) {
    return '$amount का भुगतान करें';
  }

  @override
  String get payment => 'भुगतान';

  @override
  String get paymentNotFound => 'भुगतान नहीं मिला';

  @override
  String payingAmountTo(String amount, String billerName) {
    return '$billerName को $amount का भुगतान हो रहा है';
  }

  @override
  String paidTo(String billerName) {
    return '$billerName को भुगतान किया गया';
  }

  @override
  String receiptNumber(String paymentId) {
    return 'रसीद $paymentId';
  }

  @override
  String dateValue(String date) {
    return 'दिनांक: $date';
  }

  @override
  String get saveBiller => 'बिलर सहेजें';

  @override
  String get done => 'हो गया';

  @override
  String paymentFailedSummary(String amount, String billerName) {
    return '$billerName को $amount का भुगतान विफल रहा';
  }

  @override
  String get retryPayment => 'भुगतान पुनः प्रयास करें';

  @override
  String get backToHome => 'होम पर वापस जाएँ';

  @override
  String get paymentHistory => 'भुगतान इतिहास';

  @override
  String get noPaymentsYet => 'अभी तक कोई भुगतान नहीं';

  @override
  String get statusProcessing => 'प्रक्रिया में';

  @override
  String get statusSuccess => 'सफल';

  @override
  String get statusFailed => 'विफल';

  @override
  String get dueToday => 'आज देय';

  @override
  String dueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days दिनों में देय',
      one: '1 दिन में देय',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days दिनों से अतिदेय',
      one: '1 दिन से अतिदेय',
    );
    return '$_temp0';
  }

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get language => 'भाषा';

  @override
  String get theme => 'थीम';

  @override
  String get systemDefault => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get themeLight => 'लाइट';

  @override
  String get themeDark => 'डार्क';
}
