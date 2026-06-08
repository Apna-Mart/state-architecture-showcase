// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'ApnaMart';

  @override
  String get paymentFailedRetry => 'Payment failed. Please retry.';

  @override
  String get invalidOtpMessage => 'Invalid OTP. Enter any 6 digits.';

  @override
  String get somethingWentWrong => 'Something went wrong. Try again.';

  @override
  String get storageFailedMessage =>
      'Could not save your changes on this device.';

  @override
  String get mobileNumber => 'Mobile number';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String get enterOtp => 'Enter OTP';

  @override
  String otpSentTo(String phone) {
    return 'OTP sent to $phone';
  }

  @override
  String get verify => 'Verify';

  @override
  String get changeNumber => 'Change number';

  @override
  String get upcomingBills => 'Upcoming bills';

  @override
  String get savedBillers => 'Saved billers';

  @override
  String get payABill => 'Pay a bill';

  @override
  String get retry => 'Retry';

  @override
  String get billers => 'Billers';

  @override
  String get searchBillers => 'Search billers';

  @override
  String get typeAtLeastTwoCharacters => 'Type at least 2 characters';

  @override
  String noBillersMatch(String query) {
    return 'No billers match \"$query\"';
  }

  @override
  String get searchFailed => 'Search failed';

  @override
  String get billDetails => 'Bill details';

  @override
  String get amountFieldLabel => 'Amount (₹)';

  @override
  String get enterAmount => 'Enter amount';

  @override
  String get continueLabel => 'Continue';

  @override
  String get fetchBill => 'Fetch Bill';

  @override
  String get reviewAndPay => 'Review & Pay';

  @override
  String accountValue(String account) {
    return 'Account: $account';
  }

  @override
  String nameValue(String name) {
    return 'Name: $name';
  }

  @override
  String payAmount(String amount) {
    return 'Pay $amount';
  }

  @override
  String get payment => 'Payment';

  @override
  String get paymentNotFound => 'Payment not found';

  @override
  String payingAmountTo(String amount, String billerName) {
    return 'Paying $amount to $billerName';
  }

  @override
  String paidTo(String billerName) {
    return 'Paid to $billerName';
  }

  @override
  String receiptNumber(String paymentId) {
    return 'Receipt $paymentId';
  }

  @override
  String dateValue(String date) {
    return 'Date: $date';
  }

  @override
  String get saveBiller => 'Save biller';

  @override
  String get done => 'Done';

  @override
  String paymentFailedSummary(String amount, String billerName) {
    return 'Payment of $amount to $billerName failed';
  }

  @override
  String get retryPayment => 'Retry payment';

  @override
  String get backToHome => 'Back to home';

  @override
  String get paymentHistory => 'Payment history';

  @override
  String get noPaymentsYet => 'No payments yet';

  @override
  String get statusProcessing => 'Processing';

  @override
  String get statusSuccess => 'Success';

  @override
  String get statusFailed => 'Failed';

  @override
  String get dueToday => 'Due today';

  @override
  String dueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Due in $days days',
      one: 'Due in 1 day',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Overdue by $days days',
      one: 'Overdue by 1 day',
    );
    return '$_temp0';
  }

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get systemDefault => 'System default';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';
}
