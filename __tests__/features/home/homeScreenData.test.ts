import { projectHomeCategories, projectHomeSavedBillers, projectHomeReminders } from '@/features/home/ui/homeScreenData';
import { asyncData, asyncError, asyncLoading } from '@/core/async/async';
import { makeCatalog } from '@/features/billers/data/billerCatalog';
import { emptySavedBillers, addingSaved } from '@/features/saved_billers/data/savedBiller';

const catalog = makeCatalog(
  Array.from({ length: 15 }, (_, i) => ({ id: `c${i}`, name: `C${i}` })),
  [
    { id: 'electricity-metro', categoryId: 'electricity', name: 'Metro Electricity', mode: 'presentment', inputParams: [] },
    { id: 'dth-metro', categoryId: 'dth', name: 'Metro DTH', mode: 'openAmount', inputParams: [] },
  ],
);
const now = new Date(2026, 5, 5);

describe('home projections', () => {
  it('categories: loading then 15 items', () => {
    expect(projectHomeCategories(asyncLoading())).toEqual({ kind: 'loading' });
    const r = projectHomeCategories(asyncData(catalog));
    expect(r.kind === 'loaded' && r.items.length).toBe(15);
  });
  it('saved billers empty resolves to loaded empty even before catalog', () => {
    expect(projectHomeSavedBillers(asyncLoading(), emptySavedBillers())).toEqual({ kind: 'loaded', items: [] });
  });
  it('saved billers loading until catalog when there are saved entries', () => {
    const saved = addingSaved(emptySavedBillers(), { billerId: 'electricity-metro', account: 'K123', nickname: 'Home' });
    expect(projectHomeSavedBillers(asyncLoading(), saved)).toEqual({ kind: 'loading' });
    const r = projectHomeSavedBillers(asyncData(catalog), saved);
    expect(r.kind === 'loaded' && r.items[0]!.billerName).toBe('Metro Electricity');
    expect(r.kind === 'loaded' && r.items[0]!.openAmount).toBe(false);
  });
  it('reminders exclude openAmount billers and compute dueInDays', () => {
    const saved = addingSaved(emptySavedBillers(), { billerId: 'dth-metro', account: 'D77', nickname: 'TV' });
    const dueBills = asyncData([{ billerId: 'dth-metro', account: 'D77', customerName: 'x', amountPaise: 100, dueDate: new Date(2026, 5, 8), billNumber: 'b' }]);
    const r = projectHomeReminders(asyncData(catalog), dueBills, saved, now);
    expect(r).toEqual({ kind: 'loaded', items: [] });
  });
  it('reminders error resolves to loaded empty', () => {
    const saved = addingSaved(emptySavedBillers(), { billerId: 'electricity-metro', account: 'K123', nickname: 'Home' });
    expect(projectHomeReminders(asyncData(catalog), asyncError(new Error('x')), saved, now)).toEqual({ kind: 'loaded', items: [] });
  });
});
