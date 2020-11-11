import ballerina/grpc;
import ballerina/io;

listener grpc:Listener ep = new (9090);

service greeting on ep {

    resource function sayHello(grpc:Caller caller, HelloRequest value) returns error? {
          io:println("Request from Client: ", value.greet);

        HelloResponse response = {welcome: "********* Welcome to CALI ********* \n Select from The options below:\n 1. Add A Record \n 2. Update A Record \n 3. Read A Record \n 4. Exit \n Enter: \n"};

        check caller ->send(response);
        check caller ->complete();
    }
}

public type HelloRequest record {|
    string greet = "";

|};

public type HelloResponse record {|
    string welcome = "";

|};



const string ROOT_DESCRIPTOR = "0A0A6D61696E2E70726F746F22240A0C48656C6C6F5265717565737412140A0567726565741801200128095205677265657422290A0D48656C6C6F526573706F6E736512180A0777656C636F6D65180120012809520777656C636F6D6532350A086772656574696E6712290A0873617948656C6C6F120D2E48656C6C6F526571756573741A0E2E48656C6C6F526573706F6E7365620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "main.proto":"0A0A6D61696E2E70726F746F22240A0C48656C6C6F5265717565737412140A0567726565741801200128095205677265657422290A0D48656C6C6F526573706F6E736512180A0777656C636F6D65180120012809520777656C636F6D6532350A086772656574696E6712290A0873617948656C6C6F120D2E48656C6C6F526571756573741A0E2E48656C6C6F526573706F6E7365620670726F746F33"

    };
}

