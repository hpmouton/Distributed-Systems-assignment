import ballerina/grpc;

public type greetingBlockingClient client object {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public function __init(string url, grpc:ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "blocking", ROOT_DESCRIPTOR, getDescriptorMap());
    }

    public remote function sayHello(HelloRequest req, grpc:Headers? headers = ()) returns ([HelloResponse, grpc:Headers]|grpc:Error) {
        
        var payload = check self.grpcClient->blockingExecute("greeting/sayHello", req, headers);
        grpc:Headers resHeaders = new;
        anydata result = ();
        [result, resHeaders] = payload;
        
        return [<HelloResponse>result, resHeaders];
        
    }

};

public type greetingClient client object {

    *grpc:AbstractClientEndpoint;

    private grpc:Client grpcClient;

    public function __init(string url, grpc:ClientConfiguration? config = ()) {
        // initialize client endpoint.
        self.grpcClient = new(url, config);
        checkpanic self.grpcClient.initStub(self, "non-blocking", ROOT_DESCRIPTOR, getDescriptorMap());
    }

    public remote function sayHello(HelloRequest req, service msgListener, grpc:Headers? headers = ()) returns (grpc:Error?) {
        
        return self.grpcClient->nonBlockingExecute("greeting/sayHello", req, msgListener, headers);
    }

};

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

