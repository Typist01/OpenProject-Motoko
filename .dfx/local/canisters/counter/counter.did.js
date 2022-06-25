export const idlFactory = ({ IDL }) => {
  const User = IDL.Record({ 'name' : IDL.Text });
  return IDL.Service({
    'createUser' : IDL.Func([IDL.Principal, IDL.Text], [IDL.Text], []),
    'getUserData' : IDL.Func([IDL.Principal], [IDL.Opt(User)], []),
    'vistorId' : IDL.Func([], [IDL.Principal], []),
  });
};
export const init = ({ IDL }) => { return []; };
