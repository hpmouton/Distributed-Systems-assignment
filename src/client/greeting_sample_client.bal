import ballerina/grpc;
import ballerina/io;

public function main (string... args) {

    greetingBlockingClient blockingEp = new("http://localhost:9090");
//    grpc:Headers headers =new;
//    headers.setEntry("client_header_key","Request Header Value");
   HelloRequest h={greet:"Client Connected To CALI"};

    var response = blockingEp->sayHello(h);
 if (response is grpc:Error) {
        io:println("Error from Connector: " + response.reason() + " - "
                + <string>response.detail()["message"]);
 }
 else{
     io:println(response);


 }
}


