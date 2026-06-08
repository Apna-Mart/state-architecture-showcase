import { useStore } from 'zustand';
import { useShallow } from 'zustand/react/shallow';
import { fromQuery } from '@/core/async/async';
import { useContainer, useLanguage } from '@/core/containerContext';
import { useCatalogQuery } from '@/features/billers/data/catalogQueries';
import { useDueBillsQuery } from '@/features/bills/data/dueBillsQueries';
import { projectCategories, projectReminders, projectSavedBillers } from './homeProjection';
import type { HomeScreenData } from './homeScreenData';

export function useHomeScreenData(): HomeScreenData {
  const container = useContainer();
  const language = useLanguage();
  const catalogQuery = useCatalogQuery(language);
  const dueBillsQuery = useDueBillsQuery();
  const saved = useStore(container.savedBillers, useShallow((s) => s.savedBillers.items));
  const now = container.clock();
  const catalog = fromQuery(catalogQuery);
  return {
    reminders: projectReminders(catalog, fromQuery(dueBillsQuery), saved, now),
    savedBillers: projectSavedBillers(catalog, saved),
    categories: projectCategories(catalog),
  };
}
