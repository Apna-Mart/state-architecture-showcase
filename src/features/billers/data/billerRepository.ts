import type { MockNetwork } from '../../../core/mock/mockNetwork';
import type { Biller, BillerCategory, BillerInputParam } from './biller';
import { makeCatalog, type BillerCatalog } from './billerCatalog';
import { billerName, categoryNames, enterHint, paramHints, paramLabels } from './catalogStrings';

type Lang = 'en' | 'hi' | 'ar';

const SUPPORTED_LANGS: readonly Lang[] = ['en', 'hi', 'ar'];
const OPEN_AMOUNT_CATEGORIES = new Set(['mobile-prepaid', 'dth', 'fastag']);
const PREFIX_IDS = ['national', 'metro', 'city', 'state'] as const;

export interface BillerRepository {
  fetchCatalog(language: string): Promise<BillerCatalog>;
  search(query: string, language: string): Promise<readonly Biller[]>;
}

export class FakeBillerRepository implements BillerRepository {
  private readonly catalogs = new Map<string, BillerCatalog>();

  constructor(private readonly network: MockNetwork) {}

  private catalogFor(language: string): BillerCatalog {
    const lang: Lang = SUPPORTED_LANGS.includes(language as Lang) ? (language as Lang) : 'en';
    const cached = this.catalogs.get(lang);
    if (cached) return cached;
    const built = FakeBillerRepository.build(lang);
    this.catalogs.set(lang, built);
    return built;
  }

  private static build(language: Lang): BillerCatalog {
    const categories: BillerCategory[] = Object.entries(categoryNames).map(([id, names]) => ({
      id,
      name: names[language],
    }));
    const billers: Biller[] = [];
    for (const categoryId of Object.keys(categoryNames)) {
      for (const prefixId of PREFIX_IDS) {
        billers.push({
          id: `${categoryId}-${prefixId}`,
          categoryId,
          name: billerName(prefixId, categoryId, language),
          mode: OPEN_AMOUNT_CATEGORIES.has(categoryId) ? 'openAmount' : 'presentment',
          inputParams: FakeBillerRepository.paramsFor(categoryId, language),
        });
      }
    }
    return makeCatalog(categories, billers);
  }

  private static paramsFor(categoryId: string, language: Lang): BillerInputParam[] {
    if (categoryId === 'credit-card') {
      return [
        { key: 'card', label: paramLabels['Card Number']![language], hint: paramHints['Last 4 digits']![language] },
        { key: 'mobile', label: paramLabels['Registered Mobile']![language], hint: paramHints['10-digit mobile']![language] },
      ];
    }
    const labelKey = FakeBillerRepository.labelKeyFor(categoryId);
    const label = paramLabels[labelKey]![language];
    return [{ key: 'account', label, hint: enterHint(label, language) }];
  }

  private static labelKeyFor(categoryId: string): string {
    switch (categoryId) {
      case 'mobile-postpaid':
      case 'mobile-prepaid':
        return 'Mobile Number';
      case 'dth':
        return 'Subscriber ID';
      case 'fastag':
        return 'Vehicle Number';
      case 'lpg':
        return 'LPG ID';
      case 'insurance':
        return 'Policy Number';
      case 'loan-emi':
        return 'Loan Account Number';
      case 'education':
        return 'Student ID';
      default:
        return 'Consumer Number';
    }
  }

  async fetchCatalog(language: string): Promise<BillerCatalog> {
    await this.network.delay();
    return this.catalogFor(language);
  }

  async search(query: string, language: string): Promise<readonly Biller[]> {
    await this.network.delay();
    const needle = query.trim().toLowerCase();
    return this.catalogFor(language).billers.filter((b) => b.name.toLowerCase().includes(needle));
  }
}
