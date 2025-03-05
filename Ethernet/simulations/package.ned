package ethernet.simulations;

import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth10G;
import inet.node.ethernet.EthernetHost;
import inet.node.ethernet.EthernetSwitch;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;

@license(LGPL);
@comment("This network simulates a basic Ethernet topology with two routers connecting a client to a server.");
network Network
{
    @display("bgb=1567,852");
    submodules:
        ethernetSwitch1: EthernetSwitch {
            @display("p=390,332");
        }
        client1: StandardHost {
            @display("p=234,256");
        }
        router1: Router {
            @display("p=599,436");
        }
        router2: Router {
            @display("p=884,434");
        }
        ethernetSwitch2: EthernetSwitch {
            @display("p=995,434");
        }
        server: StandardHost {
            @display("p=1145,436");
        }
        client2: StandardHost {
            @display("p=234,385");
        }
        ethernetSwitch3: EthernetSwitch {
            @display("p=390,556");
        }
        client3: StandardHost {
            @display("p=234,498");
        }
        client4: StandardHost {
            @display("p=234,628");
        }
    connections:
        client1.ethg[0] <--> Eth100M <--> ethernetSwitch1.ethg[0];
        ethernetSwitch1.ethg[0] <--> Eth100M <--> router1.ethg[0];
        router2.ethg[0] <--> Eth100M <--> ethernetSwitch2.ethg[0];
        ethernetSwitch2.ethg[0] <--> Eth100M <--> server.ethg[0];
        router1.ethg[0] <--> Eth10G <--> router2.ethg[0];
        client2.ethg[0] <--> Eth100M <--> ethernetSwitch1.ethg[0];
        ethernetSwitch3.ethg[0] <--> Eth100M <--> client3.ethg[0];
        client4.ethg[0] <--> Eth100M <--> ethernetSwitch3.ethg[0];
        ethernetSwitch3.ethg[0] <--> Eth100M <--> router1.ethg[0];
}

