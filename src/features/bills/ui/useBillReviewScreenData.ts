import { useStore } from 'zustand';
import { fromQuery } from '@/core/async/async';
import { useContainer, useLanguage } from '@/core/containerContext';
import { billerById } from '@/features/billers/data/biller';
import { useCatalogQuery } from '@/features/billers/data/catalogQueries';
import { useBillQuery } from '../data/billQueries';
import { hasProcessing } from '@/features/payments/data/payment';
import { projectBillReview } from './billReviewProjection';
import type { BillReviewScreenData, ReviewParams } from './billReviewScreenData';

export function useBillReviewScreenData(params: ReviewParams): BillReviewScreenData {
  const container = useContainer();
  const language = useLanguage();
  const catalogQuery = useCatalogQuery(language);
  const biller = catalogQuery.data ? billerById(catalogQuery.data, params.billerId) : undefined;
  const presentment = biller?.mode === 'presentment';
  const billQuery = useBillQuery(params.billerId, params.account, presentment);
  const paying = useStore(container.payments, (s) => hasProcessing(s.payments, params.billerId, params.account));
  return projectBillReview(params, fromQuery(catalogQuery), paying, fromQuery(billQuery), container.clock());
}
