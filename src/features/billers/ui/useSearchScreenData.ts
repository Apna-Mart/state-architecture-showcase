import { fromQuery } from '@/core/async/async';
import { useDebouncedValue } from '@/core/useDebouncedValue';
import { useLanguage } from '@/core/containerContext';
import { useCatalogQuery } from '../data/catalogQueries';
import { useSearchQuery } from '../data/searchQueries';
import { projectSearch } from './searchProjection';
import type { SearchScreenData } from './searchScreenData';

export function useSearchScreenData(rawQuery: string): SearchScreenData {
  const language = useLanguage();
  const debounced = useDebouncedValue(rawQuery, 200);
  const searchQuery = useSearchQuery(language, debounced);
  const catalogQuery = useCatalogQuery(language);
  return projectSearch(rawQuery, fromQuery(searchQuery), catalogQuery.data);
}
