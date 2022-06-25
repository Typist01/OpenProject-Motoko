// going back to List implementation
import Debug "mo:base/Debug";
import List "mo:base/List";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Option "mo:base/Option";
import Array "mo:base/Array";
import Buffer "mo:base/Buffer";
import Text "mo:base/Text"

actor counter {

  public type Submission = {
    title: Text;
    responses: List.List<Text>;
  };
  
  public type Task = {
      title: Text;
      aim: Text;
      prerequisites: List.List<Text>;
      submissions: List.List<Text>;
  };

  public type Project = {
      name: Text;
      founder: Text;
      community: ?Text;
      tasks: List.List<Text>;
      projectAim: Text;
  };

  public type Community = {
      name: Text;
      subscribers: List.List<Text>;
      projects: List.List<Text>;
  };

  public type User = {
      name: Text;
      subscriptions: List.List<Text>;
  };


  private var users = HashMap.HashMap<Principal, User>(1, Principal.equal, Principal.hash);
  private stable var communities : List.List<Community> = List.nil<Community>();
  private  var projects = HashMap.HashMap<Text, Project>(1, Text.equal, Text.hash);
  // um not sure why it's doing this, shall we try a different way of saving this data?
  // Trie is like key-value pairs works now ig
  private var submissions = HashMap.HashMap<Text, Submission>(1, Text.equal, Text.hash);

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
      var newUser = {
        name = userName;
        subscriptions = List.nil();
      };
      users.put(userPrincipal, newUser);
      return "success";
    } else {
      return "fail"
    }
  }; 

  let adminPrincipal : Principal = Principal.fromText("ttmcu-yahsf-crj3n-dbhil-j4z6n-3xhu2-chj7u-rrn5g-5clum-pbqkq-nae");

  // Debug.print(debug_show(Iter.toList(users.entries())));

//  get list of communities
  public query func getCommunities () : async List.List<Community> {
      return communities;
  };  

  public func findCommunity(communityName: Text): async ?Community {
    func nameMatch(community: Community) : Bool{
      community.name == communityName;
    };
    let foundCommunity = List.find(communities, nameMatch);
    return foundCommunity;
  };
// works yeah
  public func createCommunity (communityName: Text) : async Text {
    if (List.some(communities, func(community: Community) : Bool = community.name == communityName)) {
      return "community already exists";
    };
    Debug.print(debug_show(communities));
    let newCommunity : Community = {
      name = communityName;
      subscribers = List.nil();
      projects = List.nil();
    };
    communities := List.push(newCommunity, communities);
    Debug.print( "new community" #debug_show(communityName) #"added" );
    return "success";
  };
 
// public func getProject(projectName){
//   func nameMatch(project){
//     project.name == projectName
//   };
//   let foundProject: Project = List.find(projects, nameMatch)
//   return foundProject
//   }

//TODO create task:
public func createTask(taskName: Text, taskAim: Text, prerequisites: [Text], projectName: Text) : async Text {
  let task: Task = {
    title = taskName;
    aim = taskAim;
    prerequisites = prerequisites;
    submissions = List.nil<Text>();
  };
  if(Option.isNull(projects.get(projectName))){
    return "fail"
  } else{
    let project = projects.get(projectName);
    project.tasks := List.push(task, project.tasks);
    
    projects.replace(projectName, project);
    return "success";
  }

  // imma eat okay
};

// TODO Add project to a community

  public func addProject(projectName: Text, projectAim: Text, communityName: ?Text, userName: Text): async Text {
    // oh wait. useers isn't a list that's why. wait
    // if (not List.some(Iter.toList(users.vals()), func(x: User) : Bool = x.name == userName)) return "User '" + userName + "' doesn't exist.";

    // if (List.some(List.get(communities, communityName).projects, func(p: Text) : Bool = List.get(projects, p).name = projectName)) return "Project '" + projectName + "' already exists.";
      if (Option.isNull(projects.get(projectName))){
        // create project
        let newProject: Project = {
          name = projectName;
          founder = userName;
          community = communityName;
          projectAim = projectAim;
          tasks = List.nil();
        };

        projects.put(projectName, newProject);
        return "success";
      };
      return "project already exists";
  };



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
  
//   // TODO:  a function to return list of subscriptions
//   // TODO:  a function to remove subscriptions


//   // TODO: A function to remove a community

//   // TODO: A function to add a project to a community.
  // public func addProject(communityName: Text, projectName: Text, projectAim: Text){


  // };

//   // TODO: A function to return projects as a list.
//   // TODO: A function to add tasks in a project
//   // TODO: A function to return tasks in a project

//   // TODO: A function to add prerequisites to a task within a project
//   // TODO: A function to return prerequisites as a list

  private stable var userEntries: [(Principal, User)] = [];
  // private stable var communityEntries: [Community] = [];

  // Debug.print(debug_show(communities));

  system func preupgrade() {
// for keeping user hash map in memory
  userEntries := Iter.toArray(users.entries());
    // communityEntries := List.toArray(communities);


  };

  system func postupgrade() {
    // keep user hashmap in memory
    if (users.size() < 1){
      let adminUser : User = {
        name = "admin";
        subscriptions = List.nil();
      };
      users.put(adminPrincipal, adminUser);
    };

    users := HashMap.fromIter<Principal, User>(userEntries.vals(), 1, Principal.equal, Principal.hash); 
    // communities := List.fromArray(communityEntries);
  };
  // keep nested data from communities in memory
};

