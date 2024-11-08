import ned.IdealChannel;
import org.omnetpp.queueing.*;
import QueueingNode;

network P2PTorrentNetwork
{
    @display("bgb=668,556");
    submodules:
        mm1_1: QueueingNode {
            serviceTime = normal(0.8s, 0.4s);
            capacity = 10;
            @display("p=224,282;is=vl");
        }
        mm1_2: QueueingNode {
            serviceTime = normal(1.0s, 0.5s);
            capacity = 10;
            @display("p=324,216");
        }
        mm1_3: QueueingNode {
            serviceTime = normal(1.2s, 0.6s);
            capacity = 10;
            @display("p=435,282");
        }
        mm1_4: QueueingNode {
            serviceTime = normal(1.5s, 0.75s);
    		capacity = 10;
            @display("p=324,339");
        }
        source1: Source {
            interArrivalTime = normal(0.6s, 0.3s);
            @display("p=124,243");
        }
        sink1: Sink {
            @display("p=124,320");
        }
        source2: Source {
            interArrivalTime = normal(0.7s, 0.35s);
            @display("p=285,119");
        }
        sink2: Sink {
            @display("p=363,119");
        }
        source3: Source {
            interArrivalTime = normal(0.8s, 0.28s);
            @display("p=529,255");
        }
        sink3: Sink {
            @display("p=529,320");
        }
        source4: Source {
            interArrivalTime = normal(0.65s, 0.34s);
            @display("p=285,433");
        }
        sink4: Sink {
            @display("p=363,433");
        }
    connections allowunconnected:
        mm1_1.out --> mm1_2.in;
        mm1_2.out --> mm1_3.in;
        mm1_3.out --> mm1_4.in;
        mm1_4.out --> mm1_1.in;

        source1.out --> mm1_1.in;
        mm1_1.out --> sink1.in++;

        source2.out --> mm1_2.in;
        mm1_2.out --> sink2.in++;

        source3.out --> mm1_3.in;
        mm1_3.out --> sink3.in++;

        source4.out --> mm1_4.in;
        mm1_4.out --> sink4.in++;
}
