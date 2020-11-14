import ballerina/grpc;

public type caliBlockingClient client object {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public function __init(string url, grpc:ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "blocking", ROOT_DESCRIPTOR, getDescriptorMap());
    }

    public remote function addRecord(Record req, grpc:Headers? headers = ()) returns ([response, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("cali/addRecord", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<response>result, resHeaders];
        
    }

    public remote function updateRecord(Record req, grpc:Headers? headers = ()) returns ([response, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("cali/updateRecord", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<response>result, resHeaders];
        
    }

    public remote function readWithKey(readRecordWithKey req, grpc:Headers? headers = ()) returns ([Record, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("cali/readWithKey", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<Record>result, resHeaders];
        
    }

    public remote function readWithKeyAndVersion(versionAndKey req, grpc:Headers? headers = ()) returns ([Record, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("cali/readWithKeyAndVersion", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<Record>result, resHeaders];
        
    }

    public remote function readRecordWithCriterion(searchRecord req, grpc:Headers? headers = ()) returns ([Record, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("cali/readRecordWithCriterion", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<Record>result, resHeaders];
        
    }

};

public type caliClient client object {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public function __init(string url, grpc:ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "non-blocking", ROOT_DESCRIPTOR, getDescriptorMap());
    }

    public remote function addRecord(Record req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("cali/addRecord", req, msgListener, headers);
    }

    public remote function updateRecord(Record req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("cali/updateRecord", req, msgListener, headers);
    }

    public remote function readWithKey(readRecordWithKey req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("cali/readWithKey", req, msgListener, headers);
    }

    public remote function readWithKeyAndVersion(versionAndKey req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("cali/readWithKeyAndVersion", req, msgListener, headers);
    }

    public remote function readRecordWithCriterion(searchRecord req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("cali/readRecordWithCriterion", req, msgListener, headers);
    }

};

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
        "cali.proto":"0A0A63616C692E70726F746F2292030A065265636F726412120A046461746518012001280952046461746512160A066E756D62657218022001280952066E756D626572121C0A097265636F72644B657918032001280952097265636F72644B657912240A0D7265636F726456657273696F6E180420012809520D7265636F726456657273696F6E12120A0462616E64180520012809520462616E6412220A05736F6E677318062003280B320C2E5265636F72642E536F6E675205736F6E677312280A076172746973747318072003280B320E2E5265636F72642E4172746973745207617274697374731A660A0641727469737412120A046E616D6518012001280952046E616D65122D0A066D656D62657218022001280E32152E5265636F72642E4172746973742E4D656D62657252066D656D62657222190A064D656D62657212070A03594553100012060A024E4F10011A4E0A04536F6E6712140A057469746C6518012001280952057469746C6512140A0567656E7265180220012809520567656E7265121A0A08706C6174666F726D1803200128095208706C6174666F726D226D0A06757064617465121C0A097265636F72644B657918012001280952097265636F72644B657912240A0D7265636F726456657273696F6E180220012809520D7265636F726456657273696F6E121F0A067265636F726418032001280B32072E5265636F726452067265636F726422530A0D76657273696F6E416E644B6579121C0A097265636F72644B657918012001280952097265636F72644B657912240A0D7265636F726456657273696F6E180220012809520D7265636F726456657273696F6E22310A11726561645265636F7264576974684B6579121C0A097265636F72644B657918012001280952097265636F72644B6579225A0A14726561645265636F7264576974684B6579566572121C0A097265636F72644B657918012001280952097265636F72644B657912240A0D7265636F726456657273696F6E180220012809520D7265636F726456657273696F6E22310A0C7365617263685265636F726412210A077265636F72647318012003280B32072E5265636F726452077265636F72647322220A08726573706F6E736512160A066F757470757418012001280952066F757470757432DC010A0463616C69121F0A096164645265636F726412072E5265636F72641A092E726573706F6E736512220A0C7570646174655265636F726412072E5265636F72641A092E726573706F6E7365122A0A0B72656164576974684B657912122E726561645265636F7264576974684B65791A072E5265636F726412300A1572656164576974684B6579416E6456657273696F6E120E2E76657273696F6E416E644B65791A072E5265636F726412310A17726561645265636F726457697468437269746572696F6E120D2E7365617263685265636F72641A072E5265636F7264620670726F746F33"
        
    };
}

