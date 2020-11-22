import ballerina/grpc;
import ballerina/log;
import ballerina/io;
import ballerina/lang.'int;
public function main (string... args) {


    caliBlockingClient blockingEp = new("http://localhost:9090");
    caliBlockingClient nonblockingEp = new("http://localhost:9090");

    io:println("******** Welcome To CALI *********");
    io:println("1.Add A Record");
    io:println("2.Update A Record");
    io:println("3.Read A Record");
    io:println("4.Read Record with Key");
    io:println("5.Read Record with Criteria");

    io:println("**********************************");

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
Record newRecord={};
    log:printInfo("*********Adding A New Record *********");
    string date = io:readln("Enter The Date: ");
    string number = io:readln("Enter The number Of Artists: ");
    string recKey = io:readln("Enter Record Key: ");
    string recVer = io:readln("Enter The Record Version: ");

    newRecord.date = date;
    newRecord.number = number;
    newRecord.recordKey = recKey;
    newRecord.recordVersion = recVer;


    int|error count = 'int:fromString(number);
    if (count is error) {
    io:print("invalid Entry");
    main();
    } else {
        foreach int i in 1 ... count {
            io:println("Artist: ", i);
            string name = io:readln("Enter Name of Artist: ");
            string member = io:readln("Is the Artist a member?: ");
            if (member.toLowerAscii() === "yes") {
                newRecord.artists.push({name: name, member: MEMBER_YES});
            } else {
                newRecord.artists.push({name: name, member: MEMBER_NO});
            }

        }
        io:println("********* Song Details ********");
            string title = io:readln("Enter Title: ");
            string genre = io:readln("Enter Genre: ");
            string plat = io:readln("Enter Platform: ");

            newRecord.songs.push({title: title, genre: genre, platform: plat});




   var res = block ->addRecord(newRecord);
if(res is grpc:Error){
io:print("Error!!!");
main();
}else{
    io:print("\nRecord Created");
    io:print("\nRecord Detials");
    io:print(res);
    io:print("\n\n");
    main();

}
    }
}




function updateRecord(caliBlockingClient block){
    Record newRecord = {};
    io:print("\n ********* Update Record *********");

string date = io:readln("Enter The Date: ");
    string number = io:readln("Enter The number Of Artists: ");
    string recKey = io:readln("Enter Record Key: ");
    string recVer = io:readln("Enter The Record Version: ");

    newRecord.date = date;
    newRecord.number = number;
    newRecord.recordKey = recKey;
    newRecord.recordVersion = recVer;


    int|error count = 'int:fromString(number);
    if (count is error) {
    io:print("invalid Entry");
    main();
    } else {
        foreach int i in 1 ... count {
            io:println("Artist: ", i);
            string name = io:readln("Enter Name of Artist: ");
            string member = io:readln("Is the Artist a member?: ");
            if (member.toLowerAscii() === "yes") {
                newRecord.artists.push({name: name, member: MEMBER_YES});
            } else {
                newRecord.artists.push({name: name, member: MEMBER_NO});
            }

        }
        io:println("********* Song Details ********");
            string title = io:readln("Enter Title: ");
            string genre = io:readln("Enter Genre: ");
            string plat = io:readln("Enter Platform: ");

            newRecord.songs.push({title: title, genre: genre, platform: plat});




   var res = block ->addRecord(newRecord);
if(res is grpc:Error){
io:print("Error!!!");
main();
}else{
    io:print("\nRecord Updated");
    io:print("\nRecord Detials");
    io:print(res);
    io:print("\n\n");
    main();

}
    }


}

function readRecord(caliBlockingClient block){
readRecordWithKey newKey = {recordKey: "12"};
    var readWithKeyResponse = block->readWithKey(newKey);
    if (readWithKeyResponse is grpc:Error) {
        io:println("[!] ERROR [!] A CONNECTION COULD NOT BE ESTABLISHED");
    } else {
        io:println("[!] Result Of Search: \n");
        io:println(readWithKeyResponse, "\n\n\n");

    }


}









