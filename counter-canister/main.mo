import Debug "mo:base/Debug";
import List "mo:base/List";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Option "mo:base/Option";

actor counter {
  private stable var userEntries: [(Principal, User)] = [];

  public type Submission = {
    title: Text;
    responses: List.List<Text>;
  };

  public type Task = {
      title: Text;
      aim: Text;
      prerequisites: List.List<Text>;
      submissions: List.List<Submission>;
  };

  public type Project = {
      name: Text;
      founder: User;
      tasks: List.List<Task>;
  };

  public type Community = {
      name: Text;
      subscribers: List.List<Text>;
      projects: List.List<Project>;
  };

  public type User = {
      name: Text;
      subscriptions: List.List<Community>;
  };

  private var users = HashMap.HashMap<Principal, User>(1, Principal.equal, Principal.hash);
  private stable var communities : List.List<Community>  = List.nil<Community>();

  let adminPrincipal : Principal = Principal.fromText("ttmcu-yahsf-crj3n-dbhil-j4z6n-3xhu2-chj7u-rrn5g-5clum-pbqkq-nae");

  public func createUser(userPrincipal: Principal, userName: Text)  {
    let newUser = {
          name = userName;
          subscriptions = List.nil<Community>();
      };
      users.put(userPrincipal, newUser);

      Debug.print(userName #"new user added");
  }; 

  public query func getUserData(userPrincipal: Principal) : async ?User {
      let user: ?User = users.get(userPrincipal);
      return user;
  };

  // Debug.print(debug_show(Iter.toList(users.entries())));

// get visitor id
  public shared(msg) func vistorId() : async Principal {
      Debug.print(debug_show(msg.caller));
      return msg.caller;

  };

//  get list of communities
  public query func getCommunities () : async List.List<Community> {
      return communities;
  };



  public func addCommunity (communityName : Text): async () {
    let newCommunity : Community = {
      name = communityName;
      subscribers = List.nil<Text>();
      projects = List.nil<Project>();
      };
    communities := List.push(newCommunity, communities);
    Debug.print( "new community" #debug_show(communityName) #"added" );
  };

  public query func getCommunities () : async List.List<Community> {
    // if (Option.isNull(communities)){
    //     return null;
    // } else {
    //     return communities.projects
    communities;
  };

    public query func getProjects (communityName : Text) : async List.List<Community> {
    // if (Option.isNull(communities)){
    //     return null;
    // } else {
    //     return communities.projects
    Debug.print("hello");
    communities;
  };

  Debug.print("canister running  ...");


  // candid frontend:  http://127.0.0.1:8000/?canisterId=r7inp-6aaaa-aaaaa-aaabq-cai&id=ryjl3-tyaaa-aaaaa-aaaba-cai

  // public shared(msg) func addSubscription(subscription: Text): async ?Community {
  //     if (Option.isNull(List.find(communities, func(x: Community) : () { x.name == subscription }))){return null};
      
  //     let foundCommunity = List.find(communities, func(x:Community): Bool {
  //         x.name == subscription;
  //     });
  //     // let foundUser = 
  //     if (Option.isNull(foundCommunity )){
  //         return null;
  //     } 
  //     else{
  //         return foundCommunity;
  //         // add community name to user profile and username to community profile

  //         // users.put(msg.caller, )

  //     };
  //     // let u = getUserData(msg.caller);
  //     // Debug.print(debug_show(u));
  //     // u.push(List.find(communities, func(x) = { x.name == subscription }));
  //     // users.put(msg.caller, u);
  //     // Debug.print(debug_show(getUserData(msg.caller)));
  //     // return List.find(communities, func(x) = { x.name == subscription });
  // };
  
  // TODO:  a function to return list of subscriptions
  // TODO:  a function to remove subscriptions


  // TODO: A function to add a community
  // TODO: A function to remove a community
  // TODO: A function to return list of communities

  // TODO: A function to add a project to a community.
  // TODO: A function to return projects as a list.
  // TODO: A function to add tasks in a project
  // TODO: A function to return tasks in a project

  // TODO: A function to add prerequisites to a task within a project
  // TODO: A function to return prerequisites as a list


  // system func preupgrade() {
  //     userEntries := Iter.toArray(users.entries());
  // };

  // system func postupgrade() {
  //     users := HashMap.fromIter<Principal, User>(userEntries.val(), Principal.equal, Principal.hash);   

  // };
  // hi, it seems to work, we can now see hashmap data, let's test the getUser func
  // this part saves the hashmap into a stable array variable
  // ok
  // the hashmap itself cannot be stable, it's a non-stable variable
  // these two functions can do soemthign when redeploying the canister
  // so it saves and retreives data from an array, userEntries,  to get the hashmap data when the canister starts 



};