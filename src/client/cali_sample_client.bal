import ballerina/grpc;
import ballerina/log;
import ballerina/io;
public function main (string... args) {


    caliBlockingClient blockingEp = new("http://localhost:9090");
//Adding A Record
    log:printInfo("---------------Adding A New Record---------------");
    Record newRecord = {date: "01/11/2020", number: "1", recordKey: "12", recordVersion: "1.0", artists: [{name: "Winston Marshall", member:MEMBER_YES},{name: "Ben Lovett", member:MEMBER_YES},{name: "Baaba Maal", member:MEMBER_NO}] , band: "Mumford & Sons", songs: [{title: "There Will Be Time", genre:"Folk Rock", platform: "Deezer"}]};
    var addResponse = blockingEp->addRecord(newRecord);
    if (addResponse is grpc:Error) {
        io:println("[!] ERROR [!] A CONNECTION COULD NOT BE ESTABLISHED");
    } else {
        io:println("[!] Result Of : \n");
        io:println(addResponse, "\n\n\n");
    }

    //Adding A Record That Already Exists
    log:printInfo("---------------Adding A Record That Already Exists---------------");
    Record newExistingRecord = {date: "01/11/2020", number: "1", recordKey: "12", recordVersion: "1.0", artists: [{name: "Winston Marshall", member:MEMBER_YES},{name: "Ben Lovett", member:MEMBER_YES},{name: "Baaba Maal", member:MEMBER_NO}] , band: "Mumford & Sons", songs: [{title: "There Will Be Time", genre:"Folk Rock", platform: "Deezer"}]};
    var newExistingResponse = blockingEp->addRecord(newExistingRecord);
        if (newExistingResponse is grpc:Error) {
        io:println("[!] ERROR [!] A CONNECTION COULD NOT BE ESTABLISHED");
    } else {
        io:println(newExistingResponse, "\n\n\n");
    }

    //Updating A Record
    log:printInfo("---------------Updating A Record---------------");
    Record updatedRecord = {date: "01/11/2020", number: "1", recordKey: "12", recordVersion: "2.0", artists: [{name: "Winston Marshall", member:MEMBER_YES},{name: "Ben Lovett", member:MEMBER_YES},{name: "Baaba Maal", member:MEMBER_NO}] , band: "Mumford & Sons", songs: [{title: "Some Other Song", genre:"Folk Rock", platform: "Apple Music"}]};
    var updateResponse = blockingEp->updateRecord(updatedRecord);
        if (updateResponse is grpc:Error) {
        io:println("[!] ERROR [!] A CONNECTION COULD NOT BE ESTABLISHED");
    } else {
        io:println(updateResponse, "\n\n\n");
    }

     //Attempting To Update A Record That Doesn't Exist
    log:printInfo("---------------Updating A Record That Doesn't Exist---------------");
    Record updateNonExistingRecord = {date: "01/11/2020", number: "1", recordKey: "15", recordVersion: "4.0", artists: [{name: "Winston Marshall", member:MEMBER_YES},{name: "Ben Lovett", member:MEMBER_YES},{name: "Baaba Maal", member:MEMBER_NO}] , band: "Mumford & Sons", songs: [{title: "There Will Be Time", genre:"Folk Rock", platform: "Deezer"}]};
    var updateNonExistingResponse = blockingEp->updateRecord(updateNonExistingRecord);
    if (updateNonExistingResponse is grpc:Error) {
        io:println("[!] ERROR [!] A CONNECTION COULD NOT BE ESTABLISHED");
    } else {
        io:println(updateNonExistingResponse, "\n\n\n");
    }

    //Reading A Record With A Key
    log:printInfo("-----------=----Reading A Record With Key--------------");
    readRecordWithKey newKey = {recordKey: "12"};
    var readWithKeyResponse = blockingEp->readWithKey(newKey);
    if (readWithKeyResponse is grpc:Error) {
        io:println("[!] ERROR [!] A CONNECTION COULD NOT BE ESTABLISHED");
    } else {
        io:println("[!] Result Of Search: \n");
        io:println(readWithKeyResponse, "\n\n\n");
    }

    //Reading A Record With The Wrong Key
    log:printInfo("-----------=----Reading A Record With The Wrong Key--------------");
    readRecordWithKey newWrongKey = {recordKey: "14"};
    var readWithWrongKeyResponse = blockingEp->readWithKey(newWrongKey);
    if (readWithWrongKeyResponse is grpc:Error) {
        io:println("[!] ERROR [!] A CONNECTION COULD NOT BE ESTABLISHED");
    } else {
        io:println("[!] Result Of Search: \n");
        io:println(readWithWrongKeyResponse, "\n\n\n");
    }

    //Reading A Record With A Key And Version
    log:printInfo("-----------=----Reading A Record With Key And Version--------------");
    readRecordWithKeyVer newKeyVer = {recordKey: "12", recordVersion: "1.0"};
    var readWithKeyVerResponse = blockingEp->readWithKeyAndVersion(newKeyVer);
     //Printing The Response From Server Or Error If One Occurred
    if (readWithKeyVerResponse is grpc:Error) {
        io:println("[!] ERROR [!] A CONNECTION COULD NOT BE ESTABLISHED");
    } else {
        io:println("[!] Result Of Search: \n");
        io:println(readWithKeyVerResponse, "\n\n\n");
    }

    //Reading A Record With The Wrong Key Or Version
    log:printInfo("----------------Reading A Record With The Wrong Key Or Version--------------");
    readRecordWithKeyVer newWrongKeyVer = {recordKey: "13", recordVersion: "3.0"};
    var readWithWrongKeyVerResponse = blockingEp->readWithKeyAndVersion(newWrongKeyVer);
     //Printing The Response From Server Or Error If One Occurred
    if (readWithWrongKeyVerResponse is grpc:Error) {
        io:println("[!] ERROR [!] A CONNECTION COULD NOT BE ESTABLISHED");
    } else {
        io:println("[!] Result Of Search: \n");
        io:println(readWithWrongKeyVerResponse, "\n\n\n");
    }



}


