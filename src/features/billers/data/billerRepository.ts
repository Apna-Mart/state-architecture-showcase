import { MockNetwork } from '@/core/mock/mockNetwork';
import type { SupportedLanguage } from '@/core/format/localeConfigs';
import type { Biller, BillerCatalog, BillerInputParam } from './biller';
import { billerName, categoryNames, enterHint, paramHints, paramLabels } from './catalogStrings';

const openAmountCategories = new Set(['mobile-prepaid', 'dth', 'fastag']);
const prefixIds = ['national', 'metro', 'city', 'state'];

export interface BillerRepository {
  fetchCatalog(language: SupportedLanguage): Promise<BillerCatalog>;
  search(query: string, language: SupportedLanguage): Promise<Biller[]>;
}

function paramsFor(categoryId: string, language: SupportedLanguage): BillerInputParam[] {
  if (categoryId === 'credit-card') {
    return [
      { key: 'card', label: paramLabels['Card Number']![language], hint: paramHints['Last 4 digits']![language] },
      { key: 'mobile', label: paramLabels['Registered Mobile']![language], hint: paramHints['10-digit mobile']![language] },
    ];
  }
  const labelKey =
    categoryId === 'mobile-postpaid' || categoryId === 'mobile-prepaid' ? 'Mobile Number'
    : categoryId === 'dth' ? 'Subscriber ID'
    : categoryId === 'fastag' ? 'Vehicle Number'
    : categoryId === 'lpg' ? 'LPG ID'
    : categoryId === 'insurance' ? 'Policy Number'
    : categoryId === 'loan-emi' ? 'Loan Account Number'
    : categoryId === 'education' ? 'Student ID'
    : 'Consumer Number';
  const label = paramLabels[labelKey]![language];
  return [{ key: 'account', label, hint: enterHint(label, language) }];
}

function buildCatalog(language: SupportedLanguage): BillerCatalog {
  const categories = Object.entries(categoryNames).map(([id, names]) => ({ id, name: names[language] }));
  const billers: Biller[] = [];
  for (const categoryId of Object.keys(categoryNames)) {
    for (const prefixId of prefixIds) {
      billers.push({
        id: `${categoryId}-${prefixId}`,
        categoryId,
        name: billerName(prefixId, categoryId, language),
        mode: openAmountCategories.has(categoryId) ? 'openAmount' : 'presentment',
        inputParams: paramsFor(categoryId, language),
      });
    }
  }
  return { categories, billers };
}

export class FakeBillerRepository implements BillerRepository {
  private readonly catalogs = new Map<SupportedLanguage, BillerCatalog>();

  constructor(private readonly network: MockNetwork) {}

  private catalogFor(language: SupportedLanguage): BillerCatalog {
    const cached = this.catalogs.get(language);
    if (cached) return cached;
    const built = buildCatalog(language);
    this.catalogs.set(language, built);
    return built;
  }

  async fetchCatalog(language: SupportedLanguage): Promise<BillerCatalog> {
    await this.network.delay();
    return this.catalogFor(language);
  }

  async search(query: string, language: SupportedLanguage): Promise<Biller[]> {
    await this.network.delay();
    const needle = query.trim().toLowerCase();
    return this.catalogFor(language).billers.filter((b) => b.name.toLowerCase().includes(needle));
  }
}
