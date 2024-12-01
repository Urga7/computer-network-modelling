simple Source
{
    parameters:
        @display("i=block/source");
        int maxJobs = default(-1);            // number of jobs to be generated (-1 means no limit)
        volatile double interArrivalTime @unit(s) = default(truncnormal(0s,3s)); // time between generated jobs
 
        
    gates:
        output out;
}
