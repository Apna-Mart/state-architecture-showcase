export const categoryIcon = (categoryId: string): string => {
  switch (categoryId) {
    case 'electricity': return 'bolt';
    case 'water': return 'water';
    case 'piped-gas': return 'fire';
    case 'lpg': return 'tank';
    case 'mobile-postpaid': return 'phone';
    case 'mobile-prepaid': return 'sim';
    case 'dth': return 'satellite';
    case 'broadband': return 'wifi';
    case 'landline': return 'call';
    case 'fastag': return 'toll';
    case 'credit-card': return 'card';
    case 'insurance': return 'shield';
    case 'loan-emi': return 'bank';
    case 'education': return 'school';
    case 'municipal-tax': return 'city';
    default: return 'receipt';
  }
};
