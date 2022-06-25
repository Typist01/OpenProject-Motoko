import type { Principal } from '@dfinity/principal';
export interface User { 'name' : string }
export interface _SERVICE {
  'createUser' : (arg_0: Principal, arg_1: string) => Promise<string>,
  'getUserData' : (arg_0: Principal) => Promise<[] | [User]>,
  'vistorId' : () => Promise<Principal>,
}
