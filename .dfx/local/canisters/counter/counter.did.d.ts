import type { Principal } from '@dfinity/principal';
export interface Community {
  'projects' : List_1,
  'name' : string,
  'subscribers' : List_3,
}
export type List = [] | [[Community, List]];
export type List_1 = [] | [[Project, List_1]];
export type List_2 = [] | [[Task, List_2]];
export type List_3 = [] | [[string, List_3]];
export type List_4 = [] | [[Submission, List_4]];
export interface Project { 'tasks' : List_2, 'name' : string, 'founder' : User }
export interface Submission { 'title' : string, 'responses' : List_3 }
export interface Task {
  'aim' : string,
  'title' : string,
  'prerequisites' : List_3,
  'submissions' : List_4,
}
export interface User { 'subscriptions' : List, 'name' : string }
export interface _SERVICE {
  'addCommunity' : (arg_0: string) => Promise<undefined>,
  'createUser' : (arg_0: Principal, arg_1: string) => Promise<undefined>,
  'getCommunities' : () => Promise<List>,
  'getProjects' : (arg_0: string) => Promise<List>,
  'getUserData' : (arg_0: Principal) => Promise<[] | [User]>,
  'vistorId' : () => Promise<Principal>,
}
