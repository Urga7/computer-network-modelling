import org.omnetpp.queueing.*;

module QueueingNode
{
    parameters:
        double serviceTime @unit(s);    // Mean service time for the server
        int capacity = default(10);              // Queue capacity (L)
    gates:
        input in;
        output out;            
    submodules:
        queue: Queue {
            @display("p=100,100");
            capacity = default(capacity);
        }
        server: Server {
            @display("p=200,100");
            serviceTime = default(serviceTime);
        }
    connections:
        in --> queue.in++;
        queue.out --> server.in++;
        server.out --> out;
}
