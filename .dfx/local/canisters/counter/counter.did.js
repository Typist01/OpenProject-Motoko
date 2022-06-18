export const idlFactory = ({ IDL }) => {
  const List = IDL.Rec();
  const List_1 = IDL.Rec();
  const List_2 = IDL.Rec();
  const List_3 = IDL.Rec();
  const List_4 = IDL.Rec();
  List_3.fill(IDL.Opt(IDL.Tuple(IDL.Text, List_3)));
  const Submission = IDL.Record({ 'title' : IDL.Text, 'responses' : List_3 });
  List_4.fill(IDL.Opt(IDL.Tuple(Submission, List_4)));
  const Task = IDL.Record({
    'aim' : IDL.Text,
    'title' : IDL.Text,
    'prerequisites' : List_3,
    'submissions' : List_4,
  });
  List_2.fill(IDL.Opt(IDL.Tuple(Task, List_2)));
  const User = IDL.Record({ 'subscriptions' : List, 'name' : IDL.Text });
  const Project = IDL.Record({
    'tasks' : List_2,
    'name' : IDL.Text,
    'founder' : User,
  });
  List_1.fill(IDL.Opt(IDL.Tuple(Project, List_1)));
  const Community = IDL.Record({
    'projects' : List_1,
    'name' : IDL.Text,
    'subscribers' : List_3,
  });
  List.fill(IDL.Opt(IDL.Tuple(Community, List)));
  return IDL.Service({
    'addCommunity' : IDL.Func([IDL.Text], [], []),
    'createUser' : IDL.Func([IDL.Principal, IDL.Text], [], ['oneway']),
    'getCommunities' : IDL.Func([], [List], ['query']),
    'getProjects' : IDL.Func([IDL.Text], [List], ['query']),
    'getUserData' : IDL.Func([IDL.Principal], [IDL.Opt(User)], ['query']),
    'vistorId' : IDL.Func([], [IDL.Principal], []),
  });
};
export const init = ({ IDL }) => { return []; };
