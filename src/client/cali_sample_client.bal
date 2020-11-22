import ballerina/grpc;
import ballerina/log;
import ballerina/io;
public function main (string... args) {


    caliBlockingClient blockingEp = new("http://localhost:9090");
    caliBlockingClient nonblockingEp = new("http://localhost:9090");

    io:println("******** Welcome To CALI *********");
    io:println("1.Add A Record");
    io:println("2.Update A Record");
    io:println("3.Read A Record");

    string input = io:readln("Enter A Number: ");
    if(input =="1" ){
        addRecord(blockingEp);
    }
    if(input =="2"){
        updateRecord(blockingEp);

    }
    if(input == "3"){
        readRecord(blockingEp);
    }

}

function addRecord(caliBlockingClient block){
//Adding A Record
Record add={};
    log:printInfo("*********Adding A New Record *********");
    io:print("You want to add a new Record");
   var res = block ->addRecord(add);
if(res is grpc:Error){

}



}
function updateRecord(caliBlockingClient block){
//Updating A Record
    log:printInfo("---------------Updating A Record---------------");


}

function readRecord(caliBlockingClient block){


    //Reading A Record With A Key

}









