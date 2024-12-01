import ned.IdealChannel;

network P2PNetwork
{
    parameters:
        @class(P2PNetwork);
        @display("bgb=717,723");
        
        @signal[networkTime](type=symtime_t);
        @statistic[networkTime](title="Network Time"; source=networkTime; record=vector, mean);
        
    submodules:
        mm1_1: MM1 {
            @display("p=507,356");
            address = 1;
        }
        mm1_2: MM1 {
            @display("p=346,224");
            address = 2;
        }
        mm1_3: MM1 {
            @display("p=185,356");
            address = 3;
        }
        mm1_4: MM1 {
            @display("p=346,488");
            address = 4;
        }
        source1: Source {
            @display("p=644,290");
        }
        source2: Source {
            @display("p=280,71");
        }
        source3: Source {
            @display("p=51,423");
        }
        source4: Source {
            @display("p=412,628");
        }
        sink1: Sink {
            @display("p=644,422");
        }
        sink2: Sink {
            @display("p=412,69");
        }
        sink3: Sink {
            @display("p=51,291");
        }
        sink4: Sink {
            @display("p=280,630");
        }
    connections:
        source1.out --> IdealChannel --> mm1_1.in++;
        source2.out --> IdealChannel --> mm1_2.in++;
        source3.out --> IdealChannel --> mm1_3.in++;
        source4.out --> IdealChannel --> mm1_4.in++;

        mm1_1.out --> IdealChannel --> sink1.in++;
        mm1_2.out --> IdealChannel --> sink2.in++;
        mm1_3.out --> IdealChannel --> sink3.in++;
        mm1_4.out --> IdealChannel --> sink4.in++;

        mm1_1.outNet --> IdealChannel --> mm1_2.in++;
        mm1_2.outNet --> IdealChannel --> mm1_3.in++;
        mm1_3.outNet --> IdealChannel --> mm1_4.in++;
        mm1_4.outNet --> IdealChannel --> mm1_1.in++;
}
