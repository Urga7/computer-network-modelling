package ethernet;

import inet.node.ethernet.EthernetHub;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth10M;
import inet.node.ethernet.EthernetHost;
import inet.node.ethernet.EthernetSwitch;
import inet.physicallayer.wired.common.WireJunction;
import ned.DatarateChannel;

network extendedStar
{
    @display("bgb=1255,750");
    types:
        channel C extends Eth10M
        {
            length = 1cm;
        }
    submodules:
        switch1: EthernetSwitch {
          	@display("p=535,367");
          	gates:
                ethg[3];
           	
        }
        switch2: EthernetSwitch {
            @display("p=664,367");
            gates:
                ethg[3];
        }
        
        hub1: EthernetHub {
            @display("p=360,252");
        }
        hub2: EthernetHub {
            @display("p=360,488");
        }
        hub3: EthernetHub {
            @display("p=817,252");
        }
        hub4: EthernetHub {
            @display("p=817,489");
        }
        
        host1A: EthernetHost {
            @display("p=360,98");
        }
        host1B: EthernetHost {
            @display("p=176,252");
        }
        
        host2A: EthernetHost {
            @display("p=176,488");
        }
        host2B: EthernetHost {
            @display("p=360,641");
        }
        
        
        host3A: EthernetHost {
            @display("p=817,98");
        }
        host3B: EthernetHost {
            @display("p=990,252");
        }
        
        host4A: EthernetHost {
            @display("p=990,488");
        }
        host4B: EthernetHost {
            @display("p=817,641");
        }
        
    connections:
        switch1.ethg[0] <--> C <--> switch2.ethg[0];
        
        switch1.ethg[1] <--> C <--> hub1.ethg++;
        switch1.ethg[2] <--> C <--> hub2.ethg++;
        switch2.ethg[1] <--> C <--> hub3.ethg++;
        switch2.ethg[2] <--> C <--> hub4.ethg++;
        
        hub1.ethg++ <--> Eth10M <--> host1A.ethg;
        hub1.ethg++ <--> Eth10M <--> host1B.ethg;
        hub2.ethg++ <--> Eth10M <--> host2A.ethg;
        hub2.ethg++ <--> Eth10M <--> host2B.ethg;
        hub3.ethg++ <--> Eth10M <--> host3A.ethg;
        hub3.ethg++ <--> Eth10M <--> host3B.ethg;
        hub4.ethg++ <--> Eth10M <--> host4A.ethg;
        hub4.ethg++ <--> Eth10M <--> host4B.ethg;
}
