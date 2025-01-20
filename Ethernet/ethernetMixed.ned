import inet.node.ethernet.Eth100M;
import inet.node.ethernet.Eth10M;
import inet.node.ethernet.EthernetHost;
import inet.node.ethernet.EthernetHub;
import inet.node.ethernet.EthernetSwitch;
import inet.physicallayer.wired.common.WireJunction;
import ned.IdealChannel;


network ethernetMixed
{
    @display("bgb=813,524");
    submodules:
        ethernetHost2: EthernetHost {
            @display("p=666,73");
        }
        ethernetHost1: EthernetHost {
            @display("p=705,175");
        }
        ethernetHost3: EthernetHost {
            @display("p=455,166");
        }
        ethernetHost5: EthernetHost {
            @display("p=544,58");
        }
        ethernetHub: EthernetHub {
            @display("p=173,143");
        }
        ethernetSwitch: EthernetSwitch {
            @display("p=286,420");
            gates:
                ethg[4];
        }
        ethernetSwitch1: EthernetSwitch {
            @display("p=358,371");
            gates:
                ethg[4];
        }
        ethernetSwitch2: EthernetSwitch {
            @display("p=211,371");
            gates:
                ethg[4];
        }
        ethernetSwitch3: EthernetSwitch {
            @display("p=280,315");
            gates:
                ethg[4];
        }
        ethernetHost6: EthernetHost {
            @display("p=449,372");
        }
        ethernetHost7: EthernetHost {
            @display("p=286,479");
        }
        ethernetHost8: EthernetHost {
            @display("p=131,357");
        }
        ethernetSwitch4: EthernetSwitch {
            @display("p=583,165");
            gates:
                ethg[5];
        }
        ethernetHost9: EthernetHost {
            @display("p=78,105");
        }
        ethernetHost10: EthernetHost {
            @display("p=174,58");
        }
        ethernetHost4: EthernetHost {
            @display("p=265,105");
        }
        WireJunction1: WireJunction {
            parameters:
                @display("p=280,255");
        }
        WireJunction2: WireJunction {
            parameters:
                @display("p=174,255");
        }
        WireJunction3: WireJunction {
            parameters:
                @display("p=583,249");
        }
    connections:

        ethernetHost6.ethg <--> Eth10M <--> ethernetSwitch1.ethg[0];
        ethernetHost7.ethg <--> Eth10M <--> ethernetSwitch.ethg[0];
        ethernetHost8.ethg <--> Eth10M <--> ethernetSwitch2.ethg[0];
        ethernetSwitch2.ethg[1] <--> Eth10M <--> ethernetSwitch.ethg[2];
        ethernetSwitch.ethg[1] <--> Eth10M <--> ethernetSwitch1.ethg[2];
        ethernetSwitch1.ethg[1] <--> Eth10M <--> ethernetSwitch3.ethg[2];
        ethernetSwitch3.ethg[1] <--> Eth10M <--> ethernetSwitch2.ethg[2];
        ethernetSwitch2.ethg[3] <--> Eth10M <--> ethernetSwitch1.ethg[3];
        ethernetSwitch.ethg[3] <--> Eth10M <--> ethernetSwitch3.ethg[3];
        WireJunction1.port++ <--> Eth10M <--> ethernetSwitch3.ethg[0];

        ethernetHost10.ethg <--> Eth10M <--> ethernetHub.ethg++;
        ethernetHost9.ethg <--> Eth10M <--> ethernetHub.ethg++;
        ethernetHost4.ethg <--> Eth10M <--> ethernetHub.ethg++;
        ethernetHub.ethg++ <--> Eth10M <--> WireJunction2.port++;
        ethernetSwitch4.ethg[0] <--> Eth10M <--> WireJunction3.port++;
        ethernetSwitch4.ethg[1] <--> Eth10M <--> ethernetHost3.ethg;
        ethernetSwitch4.ethg[2] <--> Eth10M <--> ethernetHost5.ethg;
        ethernetSwitch4.ethg[3] <--> Eth10M <--> ethernetHost2.ethg;
        ethernetSwitch4.ethg[4] <--> Eth10M <--> ethernetHost1.ethg;
        WireJunction2.port++ <--> Eth100M <--> WireJunction1.port++;
        WireJunction1.port++ <--> Eth100M <--> WireJunction3.port++;
}

