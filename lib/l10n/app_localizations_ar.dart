// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'أبنا مارت';

  @override
  String get paymentFailedRetry => 'فشل الدفع. يرجى المحاولة مرة أخرى.';

  @override
  String get invalidOtpMessage => 'رمز التحقق غير صالح. أدخل أي 6 أرقام.';

  @override
  String get somethingWentWrong => 'حدث خطأ ما. حاول مرة أخرى.';

  @override
  String get storageFailedMessage => 'تعذر حفظ تغييراتك على هذا الجهاز.';

  @override
  String get mobileNumber => 'رقم الجوال';

  @override
  String get sendOtp => 'إرسال رمز التحقق';

  @override
  String get enterOtp => 'أدخل رمز التحقق';

  @override
  String otpSentTo(String phone) {
    return 'تم إرسال رمز التحقق إلى $phone';
  }

  @override
  String get verify => 'تحقق';

  @override
  String get changeNumber => 'تغيير الرقم';

  @override
  String get upcomingBills => 'الفواتير القادمة';

  @override
  String get savedBillers => 'جهات الفوترة المحفوظة';

  @override
  String get payABill => 'ادفع فاتورة';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get billers => 'جهات الفوترة';

  @override
  String get searchBillers => 'ابحث عن جهات الفوترة';

  @override
  String get typeAtLeastTwoCharacters => 'اكتب حرفين على الأقل';

  @override
  String noBillersMatch(String query) {
    return 'لا توجد جهات فوترة مطابقة لـ \"$query\"';
  }

  @override
  String get searchFailed => 'فشل البحث';

  @override
  String get billDetails => 'تفاصيل الفاتورة';

  @override
  String get amountFieldLabel => 'المبلغ (₹)';

  @override
  String get enterAmount => 'أدخل المبلغ';

  @override
  String get continueLabel => 'متابعة';

  @override
  String get fetchBill => 'جلب الفاتورة';

  @override
  String get reviewAndPay => 'مراجعة ودفع';

  @override
  String accountValue(String account) {
    return 'الحساب: $account';
  }

  @override
  String nameValue(String name) {
    return 'الاسم: $name';
  }

  @override
  String payAmount(String amount) {
    return 'ادفع $amount';
  }

  @override
  String get payment => 'الدفع';

  @override
  String get paymentNotFound => 'لم يتم العثور على الدفعة';

  @override
  String payingAmountTo(String amount, String billerName) {
    return 'جارٍ دفع $amount إلى $billerName';
  }

  @override
  String paidTo(String billerName) {
    return 'تم الدفع إلى $billerName';
  }

  @override
  String receiptNumber(String paymentId) {
    return 'إيصال $paymentId';
  }

  @override
  String dateValue(String date) {
    return 'التاريخ: $date';
  }

  @override
  String get saveBiller => 'حفظ جهة الفوترة';

  @override
  String get done => 'تم';

  @override
  String paymentFailedSummary(String amount, String billerName) {
    return 'فشل دفع $amount إلى $billerName';
  }

  @override
  String get retryPayment => 'إعادة محاولة الدفع';

  @override
  String get backToHome => 'العودة إلى الرئيسية';

  @override
  String get paymentHistory => 'سجل المدفوعات';

  @override
  String get noPaymentsYet => 'لا توجد مدفوعات بعد';

  @override
  String get statusProcessing => 'قيد المعالجة';

  @override
  String get statusSuccess => 'ناجح';

  @override
  String get statusFailed => 'فاشل';

  @override
  String get dueToday => 'مستحق اليوم';

  @override
  String dueInDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'مستحق خلال $days يوم',
      many: 'مستحق خلال $days يومًا',
      few: 'مستحق خلال $days أيام',
      two: 'مستحق خلال يومين',
      one: 'مستحق خلال يوم واحد',
    );
    return '$_temp0';
  }

  @override
  String overdueByDays(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'متأخر بـ $days يوم',
      many: 'متأخر بـ $days يومًا',
      few: 'متأخر بـ $days أيام',
      two: 'متأخر بيومين',
      one: 'متأخر بيوم واحد',
    );
    return '$_temp0';
  }

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'السمة';

  @override
  String get systemDefault => 'افتراضي النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';
}
