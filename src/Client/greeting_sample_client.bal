public function main (string... args) {

    greetingBlockingClient blockingEp = new("http://localhost:9090");
    HelloRequest request ={greet: "Hi I am new"};

    var clientUnion =  blockingEp ->sayHello(request);
}


