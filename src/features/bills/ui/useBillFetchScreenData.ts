import { useStore } from 'zustand';
import { fromQuery } from '@/core/async/async';
import { useLanguage } from '@/core/containerContext';
import { useCatalogQuery } from '@/features/billers/data/catalogQueries';
import { projectBillFetch } from './billFetchProjection';
import type { BillFetchFormStore } from './useBillFetchFormStore';
import type { BillFetchScreenData } from './billFetchScreenData';

export function useBillFetchScreenData(billerId: string, formStore: BillFetchFormStore): BillFetchScreenData {
  const language = useLanguage();
  const catalogQuery = useCatalogQuery(language);
  const form = useStore(formStore, (s) => s.form);
  return projectBillFetch(billerId, fromQuery(catalogQuery), form);
}
