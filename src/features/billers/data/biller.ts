export type BillerMode = 'presentment' | 'openAmount';

export interface BillerCategory {
  readonly id: string;
  readonly name: string;
}

export interface BillerInputParam {
  readonly key: string;
  readonly label: string;
  readonly hint: string;
}

export interface Biller {
  readonly id: string;
  readonly categoryId: string;
  readonly name: string;
  readonly mode: BillerMode;
  readonly inputParams: readonly BillerInputParam[];
}
