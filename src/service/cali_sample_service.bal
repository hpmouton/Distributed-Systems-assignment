import ballerina/grpc;
import ballerina/io;
import ballerina/crypto;

listener grpc:Listener ep = new (9090);

map<Record> recordsMap = {};

service cali on ep {

    resource function addRecord(grpc:Caller caller, Record value) {
        // Implementation Goes Here.
        string payload;
        error? result = ();

        //Hashing Record Key
        byte[] hash = value.recordKey.toBytes();
        byte[] hashedKey = crypto:hashMd5(hash);
        string hashedToBase16 = hashedKey.toBase16();

        if (recordsMap.hasKey(hashedToBase16)) {
            payload = "[!] Error: Record Already Exists [!]";
            //Send Response To Client
            result = caller->send(payload);
            result = caller->complete();
        } else {
            //Store The Values
            recordsMap[hashedToBase16] = <@untainted>value;

            var jsonValue = typedesc<json>.constructFrom(recordsMap[hashedToBase16]);
            if (jsonValue is error) {
                //Send Casting Error As Internal Error
                result = caller->sendError(grpc:INTERNAL, <string>jsonValue.detail()["message"]);
            } else {
                json records = jsonValue;
                payload = records.toString();
                //Send Response To The Client
                result = caller->send(payload);
                result = caller->complete();
            }
        }
    }
    resource function updateRecord(grpc:Caller caller, Record value) {
        // Implementation Goes Here.
        string payload;
        error? result = ();
        string recordVersion = value.recordVersion;

        //Hashing Record Key
        byte[] hash = value.recordKey.toBytes();
        byte[] hashedKey = crypto:hashMd5(hash);
        string hashedToBase16 = hashedKey.toBase16();

        //Find Record That Needs To Be Updated
        if (recordsMap.hasKey(hashedToBase16)) {
            //Update The Existing Order
            recordsMap[hashedToBase16] = <@untainted>value;
            payload = "Record " + value.number + " Has Been Successfully Updated. New Version Number Is " + recordVersion;
            //Send Response To Client
            result = caller->send(payload);
            result = caller->complete();
        }

        //If Record Is Not Found
        if (!recordsMap.hasKey(hashedToBase16)) {
            payload = "[!] Error: This Record Does Not Exist [!]";
            //Send Response To Client
            result = caller->send(payload);
            result = caller->complete();
        }
    }
    resource function readWithKey(grpc:Caller caller, readRecordWithKey value) {
        // Implementation Goes Here.
        string payload = "";
        error? result = ();

        //Hashing Record Key
        byte[] hash = value.recordKey.toBytes();
        byte[] hashedKey = crypto:hashMd5(hash);
        string hashedToBase16 = hashedKey.toBase16();

        if (!recordsMap.hasKey(hashedToBase16)) {
            string? failure = "[!] Error: This Record Does Not Exist [!] \n\n\n";
            //Send Response To Client
            result = caller->send(failure);
            result = caller->complete();
        }

        //Find Requested Record
            if (recordsMap.hasKey(hashedToBase16)) {
                var jsonValue = typedesc<json>.constructFrom(recordsMap[hashedToBase16]);
                if (jsonValue is error) {
                    //Send Casting Error As Internal Error
                    string? failure = "[!] Error: No Results Found [!] \n\n\n";
                    result = caller->send(failure);
                } else {
                    json records = jsonValue;
                    payload = records.toString();
                    //Send Response To The Client
                    result = caller->send(payload);
                    result = caller->complete();
                }
            }
    }
    resource function readWithKeyAndVersion(grpc:Caller caller, versionAndKey value) {
        // Implementation Goes Here.
        string payload = "";
        error? result = ();
        string recordVersion = value.recordVersion;

        //Hashing Record Key
        byte[] hash = value.recordKey.toBytes();
        byte[] hashedKey = crypto:hashMd5(hash);
        string hashedToBase16 = hashedKey.toBase16();

        if (!recordsMap.hasKey(hashedToBase16) && !recordsMap.hasKey(recordVersion)) {
            string? failure = "[!] Error: No Results Found [!] \n\n\n";
            result = caller->send(failure);
            result = caller->complete();
        }

        //If Result Is Found
        if (recordsMap.hasKey(hashedToBase16) || recordsMap.hasKey(recordVersion)) {
            //Find Requested Record
            var jsonValue = typedesc<json>.constructFrom(recordsMap[hashedToBase16]);

            if (jsonValue is error) {
                //Send Casting Error As Internal Error
                string? failure = "[!] Error: No Results Found [!] \n\n\n";
                result = caller->send(failure);
            } else {
                json records = jsonValue;
                payload = records.toString();
                //Send Response To The Client
                result = caller->send(payload);
                result = caller->complete();
            }
        }
    }
    resource function readRecordWithCriterion(grpc:Caller caller, searchRecord value) {
        // Implementation Goes Here.
        string payload = "";
        error? result = ();
        foreach var item in recordsMap {
            foreach var item2 in item {
                io:println(item2);
            }
        }
        result = caller->complete();
    }
}

public type Record record {|
    string date = "";
    string number = "";
    string recordKey = "";
    string recordVersion = "";
    string band = "";
    Song[] songs = [];
    Artist[] artists = [];

|};

public type Artist record {|
    string name = "";
    Member? member = ();

|};

public type Member "YES"|"NO";
public const Member MEMBER_YES = "YES";
const Member MEMBER_NO = "NO";


public type Song record {|
    string title = "";
    string genre = "";
    string platform = "";

|};


public type update record {|
    string recordKey = "";
    string recordVersion = "";
    Record? 'record = ();

|};

public type versionAndKey record {|
    string recordKey = "";
    string recordVersion = "";

|};

public type readRecordWithKey record {|
    string recordKey = "";

|};

public type readRecordWithKeyVer record {|
    string recordKey = "";
    string recordVersion = "";

|};

public type searchRecord record {|
    Record[] records = [];

|};

public type response record {|
    string output = "";

|};



const string ROOT_DESCRIPTOR = "0A0A63616C692E70726F746F2292030A065265636F726412120A046461746518012001280952046461746512160A066E756D62657218022001280952066E756D626572121C0A097265636F72644B657918032001280952097265636F72644B657912240A0D7265636F726456657273696F6E180420012809520D7265636F726456657273696F6E12120A0462616E64180520012809520462616E6412220A05736F6E677318062003280B320C2E5265636F72642E536F6E675205736F6E677312280A076172746973747318072003280B320E2E5265636F72642E4172746973745207617274697374731A660A0641727469737412120A046E616D6518012001280952046E616D65122D0A066D656D62657218022001280E32152E5265636F72642E4172746973742E4D656D62657252066D656D62657222190A064D656D62657212070A03594553100012060A024E4F10011A4E0A04536F6E6712140A057469746C6518012001280952057469746C6512140A0567656E7265180220012809520567656E7265121A0A08706C6174666F726D1803200128095208706C6174666F726D226D0A06757064617465121C0A097265636F72644B657918012001280952097265636F72644B657912240A0D7265636F726456657273696F6E180220012809520D7265636F726456657273696F6E121F0A067265636F726418032001280B32072E5265636F726452067265636F726422530A0D76657273696F6E416E644B6579121C0A097265636F72644B657918012001280952097265636F72644B657912240A0D7265636F726456657273696F6E180220012809520D7265636F726456657273696F6E22310A11726561645265636F7264576974684B6579121C0A097265636F72644B657918012001280952097265636F72644B6579225A0A14726561645265636F7264576974684B6579566572121C0A097265636F72644B657918012001280952097265636F72644B657912240A0D7265636F726456657273696F6E180220012809520D7265636F726456657273696F6E22310A0C7365617263685265636F726412210A077265636F72647318012003280B32072E5265636F726452077265636F72647322220A08726573706F6E736512160A066F757470757418012001280952066F757470757432DC010A0463616C69121F0A096164645265636F726412072E5265636F72641A092E726573706F6E736512220A0C7570646174655265636F726412072E5265636F72641A092E726573706F6E7365122A0A0B72656164576974684B657912122E726561645265636F7264576974684B65791A072E5265636F726412300A1572656164576974684B6579416E6456657273696F6E120E2E76657273696F6E416E644B65791A072E5265636F726412310A17726561645265636F726457697468437269746572696F6E120D2E7365617263685265636F72641A072E5265636F7264620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "cali.proto": "0A0A63616C692E70726F746F2292030A065265636F726412120A046461746518012001280952046461746512160A066E756D62657218022001280952066E756D626572121C0A097265636F72644B657918032001280952097265636F72644B657912240A0D7265636F726456657273696F6E180420012809520D7265636F726456657273696F6E12120A0462616E64180520012809520462616E6412220A05736F6E677318062003280B320C2E5265636F72642E536F6E675205736F6E677312280A076172746973747318072003280B320E2E5265636F72642E4172746973745207617274697374731A660A0641727469737412120A046E616D6518012001280952046E616D65122D0A066D656D62657218022001280E32152E5265636F72642E4172746973742E4D656D62657252066D656D62657222190A064D656D62657212070A03594553100012060A024E4F10011A4E0A04536F6E6712140A057469746C6518012001280952057469746C6512140A0567656E7265180220012809520567656E7265121A0A08706C6174666F726D1803200128095208706C6174666F726D226D0A06757064617465121C0A097265636F72644B657918012001280952097265636F72644B657912240A0D7265636F726456657273696F6E180220012809520D7265636F726456657273696F6E121F0A067265636F726418032001280B32072E5265636F726452067265636F726422530A0D76657273696F6E416E644B6579121C0A097265636F72644B657918012001280952097265636F72644B657912240A0D7265636F726456657273696F6E180220012809520D7265636F726456657273696F6E22310A11726561645265636F7264576974684B6579121C0A097265636F72644B657918012001280952097265636F72644B6579225A0A14726561645265636F7264576974684B6579566572121C0A097265636F72644B657918012001280952097265636F72644B657912240A0D7265636F726456657273696F6E180220012809520D7265636F726456657273696F6E22310A0C7365617263685265636F726412210A077265636F72647318012003280B32072E5265636F726452077265636F72647322220A08726573706F6E736512160A066F757470757418012001280952066F757470757432DC010A0463616C69121F0A096164645265636F726412072E5265636F72641A092E726573706F6E736512220A0C7570646174655265636F726412072E5265636F72641A092E726573706F6E7365122A0A0B72656164576974684B657912122E726561645265636F7264576974684B65791A072E5265636F726412300A1572656164576974684B6579416E6456657273696F6E120E2E76657273696F6E416E644B65791A072E5265636F726412310A17726561645265636F726457697468437269746572696F6E120D2E7365617263685265636F72641A072E5265636F7264620670726F746F33"

    };
}

