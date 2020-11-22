import ballerina/grpc;
import ballerina/io;
import ballerina/lang.'int;
import ballerina/log;
public function main(string... args) {


    caliBlockingClient blockingEp = new ("http://localhost:9090");

    io:println("******** Welcome To CALI *********");
    io:println("1.Add A Record");
    io:println("2.Update A Record");
    io:println("3.Read A Record");
    io:println("4.Read Record with Key");
    io:println("5.Read Record with Criteria");

    io:println("**********************************");

    string input = io:readln("Enter A Number: ");
    if (input == "1") {
        addRecord(blockingEp);
    }
    if (input == "2") {
        updateRecord(blockingEp);

    }
    if (input == "3") {
        readRecord(blockingEp);
    }
    if (input == "4") {
        readRecordWithKV(blockingEp);
    }

}

function addRecord(caliBlockingClient block) {
    //Adding A Record
    Record newRecord = {};
    log:printInfo("*********Adding A New Record *********");
    string date = io:readln("Enter The Date: ");
    string number = io:readln("Enter The number Of Artists: ");
    string recKey = io:readln("Enter Record Key: ");
    string recVer = io:readln("Enter The Record Version: ");

    newRecord.date = date;
    newRecord.number = number;
    newRecord.recordKey = recKey;
    newRecord.recordVersion = recVer;


    int|error counter = 'int:fromString(number);
    if (counter is error) {
        io:print("invalid Entry");
        main();
    } else {
        foreach int i in 1 ... counter {
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




        var res = block->addRecord(newRecord);
        if (res is grpc:Error) {
            io:print("Error!!!");
            main();
        } else {
            io:print("\nRecord Created");
            io:print("\nRecord Detials");
            io:print(res);
            io:print("\n\n");
            main();

        }
    }
}




function updateRecord(caliBlockingClient block) {
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


    int|error counter = 'int:fromString(number);
    if (counter is error) {
        io:print("invalid Entry");
        main();
    } else {
        foreach int i in 1 ... counter {
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




        var res = block->updateRecord(newRecord);
        if (res is grpc:Error) {
            io:print("Error!!!");
            main();
        } else {
            io:print("\nRecord Updated");
            io:print("\nRecord Detials");
            io:print(res);
            io:print("\n\n");
            main();

        }
    }


}

function readRecord(caliBlockingClient block) {
    readRecordWithKey newRecord = {};
    log:printInfo("*********Reading A Record With Key*********");
    string recordK = io:readln("Enter The Key: ");

    newRecord.recordKey = recordK;

    var res = block->readWithKey(newRecord);
    if (res is grpc:Error) {
        io:print("Error!!!");
        main();
    } else {
        //Show The Output
        io:println("[!] Result Of Search: \n");
        io:println(res, "\n\n\n");
        main();

    }
}

function readRecordWithKV(caliBlockingClient block) {
    readRecordWithKeyVer newRecord = {};
    log:printInfo("*********Reading A Record With Key*********");
    string recordK = io:readln("Enter The Key: ");
    string recordV = io:readln("Enter The Version: ");

    newRecord.recordKey = recordK;
    newRecord.recordVersion = recordV;

    var res = block->readWithKeyAndVersion(newRecord);
    if (res is grpc:Error) {
        io:print("Error!!!");
        main();
    } else {
        //Show The Output
        io:println("[!] Result Of Search: \n");
        io:println(res, "\n\n\n");
        main();

    }
}









