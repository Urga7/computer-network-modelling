import inet.node.ethernet.EthernetHub;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth10M;
import inet.node.ethernet.EthernetHost;
import inet.node.ethernet.EthernetLink;
import inet.node.ethernet.EthernetSwitch;
import inet.physicallayer.wired.common.WireJunction;
import ned.DatarateChannel;


network ethernetTree
{
    parameters:
        int h;
        @display("bgb=867,612");
    submodules:
        server: EthernetHost {
            @display("p=438,69;i=device/server");
        }

        switch1: EthernetSwitch {
            parameters:
                @display("p=438,138");
            gates:
                ethg[3];

        }
        switch2: EthernetSwitch {
            @display("p=321,254");
            gates:
                ethg[3];
        }
        switch3: EthernetSwitch {
            @display("p=558,254");
            gates:
                ethg[3];
        }

        hub1: EthernetHub {
            @display("p=235,381");
        }
        hub2: EthernetHub {
            @display("p=395,381");
        }
        hub3: EthernetHub {
            @display("p=484,381");
        }
        hub4: EthernetHub {
            @display("p=640,381");
        }

        host1[h]: EthernetHost {
            @display("p=235,474");
        }
        host2[h]: EthernetHost {
            @display("p=395,474");
        }
        host3[h]: EthernetHost {
            @display("p=484,474");
        }
        host4[h]: EthernetHost {
            @display("p=640,474");
        }
    connections:
        server.ethg <--> EthernetLink <--> switch1.ethg[0];

        switch1.ethg[1] <--> EthernetLink <--> switch2.ethg[0];
        switch1.ethg[2] <--> EthernetLink <--> switch3.ethg[0];

        switch2.ethg[1] <--> EthernetLink <--> hub1.ethg++;
        switch2.ethg[2] <--> EthernetLink <--> hub2.ethg++;

        switch3.ethg[1] <--> EthernetLink <--> hub3.ethg++;
        switch3.ethg[2] <--> EthernetLink <--> hub4.ethg++;
        
        for i=0..h-1 {
            host1[i].ethg <--> EthernetLink <--> hub1.ethg++;
            host2[i].ethg <--> EthernetLink <--> hub2.ethg++;
            host3[i].ethg <--> EthernetLink <--> hub3.ethg++;
            host4[i].ethg <--> EthernetLink <--> hub4.ethg++;
        }
}
