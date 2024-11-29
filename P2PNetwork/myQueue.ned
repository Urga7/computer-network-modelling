

simple myQueue
{
   parameters:
        @display("i=block/queue");
        int capacity = default(100);   
        int resources = default(2);
        volatile double serviceTime @unit(s) = default( truncnormal(2s,0.5s) );
        volatile int address;
      
    gates:
        input in[];
        output out;
        output outNet;
}
