package com.billpayments.features.billers.data

val categoryNames = mapOf(
    "electricity" to mapOf("en" to "Electricity", "hi" to "बिजली", "ar" to "الكهرباء"),
    "water" to mapOf("en" to "Water", "hi" to "पानी", "ar" to "المياه"),
    "piped-gas" to mapOf("en" to "Piped Gas", "hi" to "पाइप गैस", "ar" to "الغاز المنزلي"),
    "lpg" to mapOf("en" to "LPG", "hi" to "LPG", "ar" to "أسطوانات الغاز"),
    "mobile-postpaid" to mapOf("en" to "Mobile Postpaid", "hi" to "मोबाइल पोस्टपेड", "ar" to "الجوال الآجل"),
    "mobile-prepaid" to mapOf("en" to "Mobile Prepaid", "hi" to "मोबाइल प्रीपेड", "ar" to "الجوال المسبق"),
    "dth" to mapOf("en" to "DTH", "hi" to "DTH", "ar" to "DTH"),
    "broadband" to mapOf("en" to "Broadband", "hi" to "ब्रॉडबैंड", "ar" to "الإنترنت"),
    "landline" to mapOf("en" to "Landline", "hi" to "लैंडलाइन", "ar" to "الهاتف الثابت"),
    "fastag" to mapOf("en" to "FASTag", "hi" to "FASTag", "ar" to "FASTag"),
    "credit-card" to mapOf("en" to "Credit Card", "hi" to "क्रेडिट कार्ड", "ar" to "البطاقة الائتمانية"),
    "insurance" to mapOf("en" to "Insurance", "hi" to "बीमा", "ar" to "التأمين"),
    "loan-emi" to mapOf("en" to "Loan EMI", "hi" to "लोन EMI", "ar" to "أقساط القرض"),
    "education" to mapOf("en" to "Education", "hi" to "शिक्षा", "ar" to "التعليم"),
    "municipal-tax" to mapOf("en" to "Municipal Tax", "hi" to "नगरपालिका कर", "ar" to "الضريبة البلدية"),
)

val providerPrefixes = mapOf(
    "national" to mapOf("en" to "National", "hi" to "राष्ट्रीय", "ar" to "الوطنية"),
    "metro" to mapOf("en" to "Metro", "hi" to "मेट्रो", "ar" to "مترو"),
    "city" to mapOf("en" to "City", "hi" to "सिटी", "ar" to "المدينة"),
    "state" to mapOf("en" to "State", "hi" to "राज्य", "ar" to "الحكومية"),
)

val paramLabels = mapOf(
    "Card Number" to mapOf("en" to "Card Number", "hi" to "कार्ड नंबर", "ar" to "رقم البطاقة"),
    "Registered Mobile" to mapOf("en" to "Registered Mobile", "hi" to "पंजीकृत मोबाइल", "ar" to "الجوال المسجل"),
    "Mobile Number" to mapOf("en" to "Mobile Number", "hi" to "मोबाइल नंबर", "ar" to "رقم الجوال"),
    "Subscriber ID" to mapOf("en" to "Subscriber ID", "hi" to "सब्सक्राइबर ID", "ar" to "رقم المشترك"),
    "Vehicle Number" to mapOf("en" to "Vehicle Number", "hi" to "वाहन नंबर", "ar" to "رقم المركبة"),
    "LPG ID" to mapOf("en" to "LPG ID", "hi" to "LPG ID", "ar" to "رقم LPG"),
    "Policy Number" to mapOf("en" to "Policy Number", "hi" to "पॉलिसी नंबर", "ar" to "رقم الوثيقة"),
    "Loan Account Number" to mapOf("en" to "Loan Account Number", "hi" to "ऋण खाता संख्या", "ar" to "رقم حساب القرض"),
    "Student ID" to mapOf("en" to "Student ID", "hi" to "छात्र ID", "ar" to "رقم الطالب"),
    "Consumer Number" to mapOf("en" to "Consumer Number", "hi" to "उपभोक्ता संख्या", "ar" to "رقم المستهلك"),
)

val paramHints = mapOf(
    "Last 4 digits" to mapOf("en" to "Last 4 digits", "hi" to "अंतिम 4 अंक", "ar" to "آخر 4 أرقام"),
    "10-digit mobile" to mapOf("en" to "10-digit mobile", "hi" to "10 अंकों का मोबाइल", "ar" to "جوال من 10 أرقام"),
)

fun enterHint(label: String, language: String): String = when (language) {
    "hi" -> "$label दर्ज करें"
    "ar" -> "أدخل $label"
    else -> "Enter $label"
}

fun billerName(prefixId: String, categoryId: String, language: String): String {
    val prefix = providerPrefixes.getValue(prefixId).getValue(language)
    val category = categoryNames.getValue(categoryId).getValue(language)
    return if (language == "ar") "$category $prefix" else "$prefix $category"
}
