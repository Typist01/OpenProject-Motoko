import Debug "mo:base/Debug";
import List "mo:base/List";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap"

actor counter {
    public type User = {
        name: Text;
        subscriptions: List.List<Text>;
    };

    let adminUser : Principal = Principal.fromText("ttmcu-yahsf-crj3n-dbhil-j4z6n-3xhu2-chj7u-rrn5g-5clum-pbqkq-nae");

    // list of users containing user data
    // stable var users: List.List<User> = List.nil<User>();
    stable var users = HashMap.HashMap<Principal, User>(1, Principal.equal, Principal.hash);
 
    func createUser(user: Principal, userName: Text) {
        let newUser = {
            name = userName;
            subscriptions = List.nil<Text>();
        };
        users.put(user, newUser);

        // users := List.push(newUser, users);
        Debug.print(userName #"new user added");
    };
    createUser(adminUser, "user123");
    // createUser("username123", "123456789903u");
    // User1: userName: username123, userId: 123456789903u


// Let's work on adding subscription to a user
// TODO: add a function to add subscrption
    // func addSubscription() {
    //     // Debug.print(users);
    //     let userID : Text = "123456789903u";
    //     let foundUser: User = List.find(users, func returnBool(u:User): Bool {
    //         return true
    //         }); 
    //      Debug.print(debug_show(foundUser));

  
    // };
    // addSubscription();
    // fixed it
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


    var myVar = 5;

    let myConstant: Nat = 5;
    stable var currentValue: Nat = 0;

    func increment(): async () {
        currentValue += 1;
    };
    
    public query func getValue(): async Nat {
        currentValue;
    };

    // Debug.print("running canister counter");

};