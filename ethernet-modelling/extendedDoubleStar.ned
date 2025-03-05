import inet.node.ethernet.EthernetHub;
import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth10M;
import inet.node.ethernet.EthernetHost;
import inet.node.ethernet.EthernetSwitch;
import inet.node.ethernet.EthernetLink;
import inet.physicallayer.wired.common.WireJunction;
import ned.DatarateChannel;

network extendedDoubleStar
{
    parameters:
        @display("bgb=1440,737");
        int h;
    submodules:
        switch1: EthernetSwitch {
            @display("p=535,367");
            gates:
                ethg[3];

        }
        switch2: EthernetSwitch {
            @display("p=711,367");
            gates:
                ethg[4];
        }

        hub1: EthernetHub {
            @display("p=360,252");
        }
        hub2: EthernetHub {
            @display("p=360,488");
        }
        hub3: EthernetHub {
            @display("p=866,252");
        }
        hub4: EthernetHub {
            @display("p=866,488");
        }

        host1[h]: EthernetHost {
            @display("p=175,250");
        }
        host2[h]: EthernetHost {
            @display("p=175,487");
        }
        host3[h]: EthernetHost {
            @display("p=1039,250");
        }
        host4[h]: EthernetHost {
            @display("p=1039,487");
        }

        server: EthernetHost {
            @display("p=1301,368;i=device/server");
        }
    connections:
        switch1.ethg[0] <--> EthernetLink <--> switch2.ethg[0];
        switch2.ethg[3] <--> EthernetLink <--> server.ethg;

        switch1.ethg[1] <--> EthernetLink <--> hub1.ethg++;
        switch1.ethg[2] <--> EthernetLink <--> hub2.ethg++;
        switch2.ethg[1] <--> EthernetLink <--> hub3.ethg++;
        switch2.ethg[2] <--> EthernetLink <--> hub4.ethg++;

        for i=0..h-1 {
            hub1.ethg++ <--> EthernetLink <--> host1[i].ethg;
            hub2.ethg++ <--> EthernetLink <--> host2[i].ethg;
            hub3.ethg++ <--> EthernetLink <--> host3[i].ethg;
            hub4.ethg++ <--> EthernetLink <--> host4[i].ethg;
        }

}
