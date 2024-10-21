import ned.IdealChannel;
import org.omnetpp.queueing.Queue;
import org.omnetpp.queueing.Sink;
import org.omnetpp.queueing.Source;


network Network
{
    @display("bgb=1050,717");
    submodules:
        source: Source {
            @display("p=247,367");
        }
        queue1: Queue {
            @display("p=421,367");
        }
        queue2: Queue {
            @display("p=622,367");
        }
        sink: Sink {
            @display("p=820,367");
        }
    connections:
        source.out --> queue1.in++;
        queue1.out --> queue2.in++;
        queue2.out --> sink.in++;
}

