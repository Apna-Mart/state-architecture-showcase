import { emptySavedBillers, contains, addingSaved, removingSaved, type SavedBiller } from '@/features/saved_billers/data/savedBiller';

const s: SavedBiller = { billerId: 'b', account: 'a', nickname: 'Home' };

describe('SavedBillers', () => {
  it('contains matches billerId + account', () => {
    const sb = addingSaved(emptySavedBillers(), s);
    expect(contains(sb, 'b', 'a')).toBe(true);
    expect(contains(sb, 'b', 'z')).toBe(false);
  });
  it('removingSaved deletes by billerId + account', () => {
    const sb = removingSaved(addingSaved(emptySavedBillers(), s), 'b', 'a');
    expect(sb.items.length).toBe(0);
  });
});
