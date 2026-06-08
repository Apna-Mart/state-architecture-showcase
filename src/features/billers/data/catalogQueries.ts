import { useQuery } from '@tanstack/react-query';
import type { SupportedLanguage } from '@/core/format/localeConfigs';
import { useContainer } from '@/core/containerContext';
import type { BillerCatalog } from './biller';

export const catalogKey = (language: SupportedLanguage) => ['catalog', language] as const;

export function useCatalogQuery(language: SupportedLanguage) {
  const { billerRepository } = useContainer();
  return useQuery<BillerCatalog>({
    queryKey: catalogKey(language),
    queryFn: () => billerRepository.fetchCatalog(language),
    staleTime: 30 * 60_000,
    gcTime: 30 * 60_000,
  });
}
