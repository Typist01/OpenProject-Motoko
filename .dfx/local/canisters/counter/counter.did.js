export const idlFactory = ({ IDL }) => {
  const List = IDL.Rec();
  const List_1 = IDL.Rec();
  List.fill(IDL.Opt(IDL.Tuple(IDL.Text, List)));
  const Community = IDL.Record({
    'projects' : List,
    'name' : IDL.Text,
    'subscribers' : List,
  });
  List_1.fill(IDL.Opt(IDL.Tuple(Community, List_1)));
  const User = IDL.Record({ 'subscriptions' : List, 'name' : IDL.Text });
  return IDL.Service({
    'addProject' : IDL.Func(
        [IDL.Text, IDL.Text, IDL.Opt(IDL.Text), IDL.Text],
        [IDL.Text],
        [],
      ),
    'createCommunity' : IDL.Func([IDL.Text], [IDL.Text], []),
    'createUser' : IDL.Func([IDL.Principal, IDL.Text], [IDL.Text], []),
    'findCommunity' : IDL.Func([IDL.Text], [IDL.Opt(Community)], []),
    'getCommunities' : IDL.Func([], [List_1], ['query']),
    'getUserData' : IDL.Func([IDL.Principal], [IDL.Opt(User)], []),
    'vistorId' : IDL.Func([], [IDL.Principal], []),
  });
};
export const init = ({ IDL }) => { return []; };
