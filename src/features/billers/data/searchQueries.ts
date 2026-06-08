import { useQuery } from '@tanstack/react-query';
import type { SupportedLanguage } from '@/core/format/localeConfigs';
import { useContainer } from '@/core/containerContext';
import type { Biller } from './biller';

export const searchKey = (language: SupportedLanguage, query: string) => ['search', language, query] as const;

export function useSearchQuery(language: SupportedLanguage, debouncedQuery: string) {
  const { billerRepository } = useContainer();
  return useQuery<Biller[]>({
    queryKey: searchKey(language, debouncedQuery),
    queryFn: () => billerRepository.search(debouncedQuery, language),
    enabled: debouncedQuery.trim().length >= 2,
  });
}
