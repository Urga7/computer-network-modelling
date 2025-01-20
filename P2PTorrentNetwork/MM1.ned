simple MM1
{
   parameters:
        
        @display("i=block/queue");
        
        @signal[utilisationFactor](type=long);
        @statistic[utilisationFactor]("Utilisation Factor"; source=utilisationFactor; record= timeavg);
        
        @signal[queueWaitingTime](type=double);
        @statistic[queueWaitingTime](title="Queue Waiting Time"; source=queueWaitingTime; record=vector, mean);
        
        @signal[droppedPackets](type=long);
        @statistic[droppedPackets](title="Dropped Packets"; source=droppedPackets; record=vector, count);
        
        @signal[saturationRatio](type=double);
        @statistic[saturationRatio](title="Saturation Ratio"; source=saturationRatio; record=vector, timeavg, max);
        
        int capacity = default(100);   
        volatile double serviceTime @unit(s) = default( truncnormal(2s,0.5s) );
        volatile int address;
      
    gates:
        input in[];
        output out;
        output outNet;
}
