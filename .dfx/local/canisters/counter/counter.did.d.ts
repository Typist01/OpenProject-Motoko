import type { Principal } from '@dfinity/principal';
export interface Community {
  'projects' : List,
  'name' : string,
  'subscribers' : List,
}
export type List = [] | [[string, List]];
export type List_1 = [] | [[Community, List_1]];
export interface User { 'subscriptions' : List, 'name' : string }
export interface _SERVICE {
  'addProject' : (
      arg_0: string,
      arg_1: string,
      arg_2: [] | [string],
      arg_3: string,
    ) => Promise<string>,
  'createCommunity' : (arg_0: string) => Promise<string>,
  'createUser' : (arg_0: Principal, arg_1: string) => Promise<string>,
  'findCommunity' : (arg_0: string) => Promise<[] | [Community]>,
  'getCommunities' : () => Promise<List_1>,
  'getUserData' : (arg_0: Principal) => Promise<[] | [User]>,
  'vistorId' : () => Promise<Principal>,
}
