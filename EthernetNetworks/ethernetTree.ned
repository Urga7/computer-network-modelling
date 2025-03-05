package ethernet;

import inet.node.ethernet.EthernetHub;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth10M;
import inet.node.ethernet.EthernetHost;
import inet.node.ethernet.EthernetSwitch;
import inet.physicallayer.wired.common.WireJunction;
import ned.DatarateChannel;


network ethernetTree
{
    @display("bgb=957,604");
    types:
        channel C extends Eth10M
        {
            length = 1cm;
        }
    submodules:
        
        tap1: WireJunction {
            parameters:
                @display("p=154,307");
        }
        tap2: WireJunction {
            parameters:
                @display("p=344,307");
        }
        tap3: WireJunction {
            parameters:
                @display("p=550,307");
        }
        tap4: WireJunction {
            parameters:
                @display("p=744,307");
        }
        
        host1A: EthernetHost {
            @display("p=67,100");
        }
        host1B: EthernetHost {
            @display("p=154,100");
        }
        host1C: EthernetHost {
            @display("p=264,100");
        }
        
        
        host2A: EthernetHost {
            parameters:
                @display("p=221,500");
        }
        host2B: EthernetHost {
            parameters:
                @display("p=344,500");
        }
        host2C: EthernetHost {
            parameters:
                @display("p=458,500");
        }
        
        host3A: EthernetHost {
            parameters:
                @display("p=400,100");
        }
        host3B: EthernetHost {
            parameters:
                @display("p=550,100");
        }
        host3C: EthernetHost {
            parameters:
                @display("p=700,100");
        }
        
        host4A: EthernetHost {
            @display("p=610,500");
        }
        host4B: EthernetHost {
            @display("p=744,500");
        }
        host4C: EthernetHost {
            @display("p=867,500");
        }
        
        switch1: EthernetSwitch {
            @display("p=154,212");
            gates:
                ethg[4];
        }
        switch2: EthernetSwitch {
            parameters:
                @display("p=344,399");
            gates:
                ethg[4];
        }
        switch3: EthernetSwitch {
            @display("p=550,212");
            gates:
                ethg[4];
        }
        switch4: EthernetSwitch {
            @display("p=744,399");
            gates:
                ethg[4];
        }
        
        
    connections:
        tap1.port++ <--> Eth10M <--> tap2.port++;
        tap2.port++ <--> Eth10M <--> tap3.port++;
        tap3.port++ <--> Eth10M <--> tap4.port++;
        
        tap1.port++ <--> C <--> switch1.ethg[0];
        tap2.port++ <--> C <--> switch2.ethg[3];
        switch3.ethg[3] <--> C <--> tap3.port++;
        
        switch2.ethg[0] <--> Eth100M {  length = 3m; } <--> host2A.ethg;
        switch2.ethg[1] <--> Eth100M {  length = 2m; } <--> host2B.ethg;
        switch2.ethg[2] <--> Eth10M {  length = 4m; } <--> host2C.ethg;
        switch3.ethg[0] <--> Eth100M <--> host3B.ethg;
        switch3.ethg[1] <--> Eth100M <--> host3C.ethg;
        switch3.ethg[2] <--> Eth100M <--> host3A.ethg;
        host1A.ethg <--> Eth10M <--> switch1.ethg[1];
        host1B.ethg <--> Eth10M <--> switch1.ethg[2];
        host1C.ethg <--> Eth10M <--> switch1.ethg[3];
        tap4.port++ <--> C <--> switch4.ethg[0];
        host4A.ethg <--> Eth10M <--> switch4.ethg[1];
        host4B.ethg <--> Eth10M <--> switch4.ethg[2];
        host4C.ethg <--> Eth10M <--> switch4.ethg[3];
}
