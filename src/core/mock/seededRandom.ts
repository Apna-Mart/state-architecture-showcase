export class SeededRandom {
  private state: number;

  constructor(seed: number) {
    this.state = (seed ^ 0x5deece66d) & 0xffffffff;
  }

  nextInt(maxExclusive: number): number {
    this.state = (Math.imul(this.state, 1103515245) + 12345) & 0x7fffffff;
    return this.state % maxExclusive;
  }
}
