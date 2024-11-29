import ned.IdealChannel;

network P2PNetwork
{
    @class(P2PNetwork);
    @display("bgb=717,723");
    submodules:
        myQueue1: myQueue {
            @display("p=507,356");
            address = 1;
        }
        myQueue2: myQueue {
            @display("p=346,224");
            address = 2;
        }
        myQueue3: myQueue {
            @display("p=185,356");
            address = 3;
        }
        myQueue4: myQueue {
            @display("p=346,488");
            address = 4;
        }
        mySource1: mySource {
            @display("p=644,290");
        }
        mySource2: mySource {
            @display("p=280,71");
        }
        mySource3: mySource {
            @display("p=51,423");
        }
        mySource4: mySource {
            @display("p=412,628");
        }
        mySink1: mySink {
            @display("p=644,422");
        }
        mySink2: mySink {
            @display("p=412,69");
        }
        mySink3: mySink {
            @display("p=51,291");
        }
        mySink4: mySink {
            @display("p=280,630");
        }
    connections:
        mySource1.out --> IdealChannel --> myQueue1.in++;
        mySource2.out --> IdealChannel --> myQueue2.in++;
        mySource3.out --> IdealChannel --> myQueue3.in++;
        mySource4.out --> IdealChannel --> myQueue4.in++;

        myQueue1.out --> IdealChannel --> mySink1.in++;
        myQueue2.out --> IdealChannel --> mySink2.in++;
        myQueue3.out --> IdealChannel --> mySink3.in++;
        myQueue4.out --> IdealChannel --> mySink4.in++;

        myQueue1.outNet --> IdealChannel --> myQueue2.in++;
        myQueue2.outNet --> IdealChannel --> myQueue3.in++;
        myQueue3.outNet --> IdealChannel --> myQueue4.in++;
        myQueue4.outNet --> IdealChannel --> myQueue1.in++;
}
