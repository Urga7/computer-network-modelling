import inet.node.ethernet.Eth10M;
import inet.node.ethernet.EthernetHost;
import inet.node.ethernet.EthernetSwitch;

network ethernetMesh
{
    @display("bgb=685,442");
    submodules:
        ethernetHost1: EthernetHost {
            @display("p=197,52");
        }
        ethernetHost2: EthernetHost {
            @display("p=565,52");
        }
        ethernetHost3: EthernetHost {
            @display("p=633,243");
        }
        ethernetHost4: EthernetHost {
            @display("p=96,243");
        }
        ethernetSwitch1: EthernetSwitch {
            @display("p=275,131");
            gates:
                ethg[5];
        }
        ethernetSwitch2: EthernetSwitch {
            @display("p=442,124");
            gates:
                ethg[5];
        }
        ethernetSwitch3: EthernetSwitch {
            @display("p=467,249");
            gates:
                ethg[5];
        }
        ethernetSwitch4: EthernetSwitch {
            @display("p=251,249");
            gates:
                ethg[5];
        }
        ethernetSwitch: EthernetSwitch {
            @display("p=356,311");
            gates:
                ethg[5];
        }
        ethernetHost: EthernetHost {
            @display("p=362,397");
        }
    connections:

        ethernetHost1.ethg <--> Eth10M <--> ethernetSwitch1.ethg[0];
        ethernetHost2.ethg <--> Eth10M <--> ethernetSwitch2.ethg[0];
        ethernetHost3.ethg <--> Eth10M <--> ethernetSwitch3.ethg[0];
        ethernetHost4.ethg <--> Eth10M <--> ethernetSwitch4.ethg[0];
        ethernetSwitch.ethg[0] <--> Eth10M <--> ethernetHost.ethg;
        ethernetSwitch1.ethg[1] <--> Eth10M <--> ethernetSwitch4.ethg[3];
        ethernetSwitch4.ethg[1] <--> Eth10M <--> ethernetSwitch3.ethg[2];
        ethernetSwitch3.ethg[1] <--> Eth10M <--> ethernetSwitch2.ethg[2];
        ethernetSwitch2.ethg[1] <--> Eth10M <--> ethernetSwitch1.ethg[3];
        ethernetSwitch4.ethg[2] <--> Eth10M <--> ethernetSwitch2.ethg[3];
        ethernetSwitch1.ethg[2] <--> Eth10M <--> ethernetSwitch3.ethg[3];
        ethernetSwitch4.ethg[4] <--> Eth10M <--> ethernetSwitch.ethg[3];
        ethernetSwitch3.ethg[4] <--> Eth10M <--> ethernetSwitch.ethg[4];
        ethernetSwitch.ethg[1] <--> Eth10M <--> ethernetSwitch2.ethg[4];
        ethernetSwitch.ethg[2] <--> Eth10M <--> ethernetSwitch1.ethg[4];
}

