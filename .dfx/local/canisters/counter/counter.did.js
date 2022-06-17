export const idlFactory = ({ IDL }) => {
  return IDL.Service({ 'getValue' : IDL.Func([], [IDL.Nat], ['query']) });
};
export const init = ({ IDL }) => { return []; };
