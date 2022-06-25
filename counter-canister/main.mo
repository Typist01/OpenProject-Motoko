// going back to List implementation
import Debug "mo:base/Debug";
import List "mo:base/List";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Option "mo:base/Option";
import Array "mo:base/Array";
import Buffer "mo:base/Buffer";

actor counter {

  public type Submission = {
    title: Text;
    responses: List.List<Text>;
  };
// hi
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
  };


  private var users = HashMap.HashMap<Principal, User>(1, Principal.equal, Principal.hash);
  private stable var userEntries: [(Principal, User)] = [];
  private var communities : List.List<Community> = List.List<Community>(0);

  
// get visitor id
  public shared(msg) func vistorId() : async Principal {
      Debug.print(debug_show(msg.caller));
      return msg.caller;
  };

// get user data from User principal
  public func getUserData(userPrincipal: Principal) : async ?User {
    return users.get(userPrincipal);
  }; 
 
//  create a new user with a principal id and user name
  public func createUser(userPrincipal: Principal, userName: Text) : async Text {
    if (Option.isNull(users.get(userPrincipal))){
      let newUser = {
        name = userName;
        subscriptions = [];
      };
      users.put(userPrincipal, newUser);
      return "success";
    } else {
      return "fail"
    }
  }; 

  let adminPrincipal : Principal = Principal.fromText("ttmcu-yahsf-crj3n-dbhil-j4z6n-3xhu2-chj7u-rrn5g-5clum-pbqkq-nae");

// //   // Debug.print(debug_show(Iter.toList(users.entries())));

//  get list of communities
  // public query func getCommunities () : async List.List<Community> {
  //     return communities;
  // };

// // // add a community to list of communities
//   public func addCommunity (communityName : Text): async Text {
//     // return List.find(communities, (x:Community) : Bool {(x == communityName)});
//     for (community in community.vals()){
//       if (community.name == communityName){
//         return "Community name not available"
//       };
//     };
//     let newCommunity : Community = {
//       name = communityName;
//       subscribers = [];
//       projects = [];
//       };
//       communities.append(newCommunity)
//     // communities := List.push(newCommunity, communities);
//     Debug.print( "new community" #debug_show(communityName) #"added" );
//   };


//     public query func getProjects (communityName : Text) : async List.List<Community> {
      
//     communities;
//   };

//   Debug.print("canister running  ...");


//   // candid frontend:  http://127.0.0.1:8000/?canisterId=r7inp-6aaaa-aaaaa-aaabq-cai&id=ryjl3-tyaaa-aaaaa-aaaba-cai

//   // public shared(msg) func addSubscription(subscription: Text): async ?Community {
//   //     if (Option.isNull(List.find(communities, func(x: Community) : () { x.name == subscription }))){return null};
      
//   //     let foundCommunity = List.find(communities, func(x:Community): Bool {
//   //         x.name == subscription;
//   //     });
//   //     // let foundUser = 
//   //     if (Option.isNull(foundCommunity )){
//   //         return null;
//   //     } 
//   //     else{
//   //         return foundCommunity;
//   //         // add community name to user profile and username to community profile

//   //         // users.put(msg.caller, )

//   //     };
//   //     // let u = getUserData(msg.caller);
//   //     // Debug.print(debug_show(u));
//   //     // u.push(List.find(communities, func(x) = { x.name == subscription }));
//   //     // users.put(msg.caller, u);
//   //     // Debug.print(debug_show(getUserData(msg.caller)));
//   //     // return List.find(communities, func(x) = { x.name == subscription });
//   // };
  
//   // TODO:  a function to return list of subscriptions
//   // TODO:  a function to remove subscriptions


//   // TODO: A function to add a community
//   // TODO: A function to remove a community
//   // TODO: A function to return list of communities

//   // TODO: A function to add a project to a community.
//   // TODO: A function to return projects as a list.
//   // TODO: A function to add tasks in a project
//   // TODO: A function to return tasks in a project

//   // TODO: A function to add prerequisites to a task within a project
//   // TODO: A function to return prerequisites as a list


  system func preupgrade() {
// for keeping user hash map in memory
      userEntries := Iter.toArray(users.entries());

  };

  system func postupgrade() {
    // keep user hashmap in memory
    if (users.size() < 1){
      let adminUser : User = {
        name = "admin";
      };
      users.put(adminPrincipal, adminUser);
    };
    users := HashMap.fromIter<Principal, User>(userEntries.vals(), 1, Principal.equal, Principal.hash);   
  };
  // keep nested data from communities in memory
};

