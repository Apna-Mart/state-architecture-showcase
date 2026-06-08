export const categoryNames: Readonly<Record<string, Record<'en' | 'hi' | 'ar', string>>> = {
  electricity: { en: 'Electricity', hi: 'बिजली', ar: 'الكهرباء' },
  water: { en: 'Water', hi: 'पानी', ar: 'المياه' },
  'piped-gas': { en: 'Piped Gas', hi: 'पाइप गैस', ar: 'الغاز المنزلي' },
  lpg: { en: 'LPG', hi: 'LPG', ar: 'أسطوانات الغاز' },
  'mobile-postpaid': { en: 'Mobile Postpaid', hi: 'मोबाइल पोस्टपेड', ar: 'الجوال الآجل' },
  'mobile-prepaid': { en: 'Mobile Prepaid', hi: 'मोबाइल प्रीपेड', ar: 'الجوال المسبق' },
  dth: { en: 'DTH', hi: 'DTH', ar: 'DTH' },
  broadband: { en: 'Broadband', hi: 'ब्रॉडबैंड', ar: 'الإنترنت' },
  landline: { en: 'Landline', hi: 'लैंडलाइन', ar: 'الهاتف الثابت' },
  fastag: { en: 'FASTag', hi: 'FASTag', ar: 'FASTag' },
  'credit-card': { en: 'Credit Card', hi: 'क्रेडिट कार्ड', ar: 'البطاقة الائتمانية' },
  insurance: { en: 'Insurance', hi: 'बीमा', ar: 'التأمين' },
  'loan-emi': { en: 'Loan EMI', hi: 'लोन EMI', ar: 'أقساط القرض' },
  education: { en: 'Education', hi: 'शिक्षा', ar: 'التعليم' },
  'municipal-tax': { en: 'Municipal Tax', hi: 'नगरपालिका कर', ar: 'الضريبة البلدية' },
};

export const providerPrefixes: Readonly<Record<string, Record<'en' | 'hi' | 'ar', string>>> = {
  national: { en: 'National', hi: 'राष्ट्रीय', ar: 'الوطنية' },
  metro: { en: 'Metro', hi: 'मेट्रो', ar: 'مترو' },
  city: { en: 'City', hi: 'सिटी', ar: 'المدينة' },
  state: { en: 'State', hi: 'राज्य', ar: 'الحكومية' },
};

export const paramLabels: Readonly<Record<string, Record<'en' | 'hi' | 'ar', string>>> = {
  'Card Number': { en: 'Card Number', hi: 'कार्ड नंबर', ar: 'رقم البطاقة' },
  'Registered Mobile': { en: 'Registered Mobile', hi: 'पंजीकृत मोबाइल', ar: 'الجوال المسجل' },
  'Mobile Number': { en: 'Mobile Number', hi: 'मोबाइल नंबर', ar: 'رقم الجوال' },
  'Subscriber ID': { en: 'Subscriber ID', hi: 'सब्सक्राइबर ID', ar: 'رقم المشترك' },
  'Vehicle Number': { en: 'Vehicle Number', hi: 'वाहन नंबर', ar: 'رقم المركبة' },
  'LPG ID': { en: 'LPG ID', hi: 'LPG ID', ar: 'رقم LPG' },
  'Policy Number': { en: 'Policy Number', hi: 'पॉलिसी नंबर', ar: 'رقم الوثيقة' },
  'Loan Account Number': { en: 'Loan Account Number', hi: 'ऋण खाता संख्या', ar: 'رقم حساب القرض' },
  'Student ID': { en: 'Student ID', hi: 'छात्र ID', ar: 'رقم الطالب' },
  'Consumer Number': { en: 'Consumer Number', hi: 'उपभोक्ता संख्या', ar: 'رقم المستهلك' },
};

export const paramHints: Readonly<Record<string, Record<'en' | 'hi' | 'ar', string>>> = {
  'Last 4 digits': { en: 'Last 4 digits', hi: 'अंतिम 4 अंक', ar: 'آخر 4 أرقام' },
  '10-digit mobile': { en: '10-digit mobile', hi: '10 अंकों का मोबाइल', ar: 'جوال من 10 أرقام' },
};

export const enterHint = (label: string, language: string): string => {
  if (language === 'hi') return `${label} दर्ज करें`;
  if (language === 'ar') return `أدخل ${label}`;
  return `Enter ${label}`;
};

export const billerName = (prefixId: string, categoryId: string, language: 'en' | 'hi' | 'ar'): string => {
  const prefix = providerPrefixes[prefixId]![language];
  const category = categoryNames[categoryId]![language];
  return language === 'ar' ? `${category} ${prefix}` : `${prefix} ${category}`;
};
