import { fromQuery } from '@/core/async/async';
import { useLanguage } from '@/core/containerContext';
import { useCatalogQuery } from '../data/catalogQueries';
import { projectCategory } from './categoryProjection';
import type { CategoryScreenData } from './categoryScreenData';

export function useCategoryScreenData(categoryId: string): CategoryScreenData {
  const language = useLanguage();
  const catalogQuery = useCatalogQuery(language);
  return projectCategory(categoryId, fromQuery(catalogQuery));
}
