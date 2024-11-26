

simple myQueue
{
   parameters:
        @display("i=block/queue");
        
        int capacity = default(100);   
        int resources = default(2);
        volatile double serviceTime @unit(s) = default( truncnormal(8s,2s) );
      
    gates:
        input in[];
        output out;
}
