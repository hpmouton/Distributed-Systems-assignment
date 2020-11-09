import ballerina/grpc;
import ballerina/io;

listener grpc:Listener ep = new (9090);

service greeting on ep {

    resource function sayHello(grpc:Caller caller, HelloRequest value)returns error? {
        // Implementation goes here.
       io:println("recieved from client",value.greet);
        HelloResponse response = {firstName:"Hubert", lastName:"Mouton", ccode: "219079", age: 20};

        check caller ->send(response);
        check caller ->complete();
        // You should return a HelloResponse
    }
}

public type HelloRequest record {|
    string greet = "";
    
|};

public type HelloResponse record {|
    string firstName = "";
    string lastName = "";
    string ccode = "";
    int age = 0;
    
|};



const string ROOT_DESCRIPTOR = "0A0B68656C6C6F2E70726F746F22240A0C48656C6C6F5265717565737412140A0567726565741801200128095205677265657422710A0D48656C6C6F526573706F6E7365121C0A0966697273744E616D65180120012809520966697273744E616D65121A0A086C6173744E616D6518022001280952086C6173744E616D6512140A0563636F6465180320012809520563636F646512100A03616765180420012805520361676532350A086772656574696E6712290A0873617948656C6C6F120D2E48656C6C6F526571756573741A0E2E48656C6C6F526573706F6E7365620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "hello.proto":"0A0B68656C6C6F2E70726F746F22240A0C48656C6C6F5265717565737412140A0567726565741801200128095205677265657422710A0D48656C6C6F526573706F6E7365121C0A0966697273744E616D65180120012809520966697273744E616D65121A0A086C6173744E616D6518022001280952086C6173744E616D6512140A0563636F6465180320012809520563636F646512100A03616765180420012805520361676532350A086772656574696E6712290A0873617948656C6C6F120D2E48656C6C6F526571756573741A0E2E48656C6C6F526573706F6E7365620670726F746F33"
        
    };
}

