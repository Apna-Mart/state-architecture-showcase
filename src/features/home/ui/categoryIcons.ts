export const categoryIcon = (categoryId: string): string => {
  switch (categoryId) {
    case 'electricity': return 'flash';
    case 'water': return 'water';
    case 'piped-gas': return 'flame';
    case 'lpg': return 'cube';
    case 'mobile-postpaid': return 'phone-portrait';
    case 'mobile-prepaid': return 'card';
    case 'dth': return 'tv';
    case 'broadband': return 'wifi';
    case 'landline': return 'call';
    case 'fastag': return 'car';
    case 'credit-card': return 'card-outline';
    case 'insurance': return 'shield-checkmark';
    case 'loan-emi': return 'business';
    case 'education': return 'school';
    case 'municipal-tax': return 'location';
    default: return 'receipt';
  }
};
