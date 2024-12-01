#include "P2PNetwork.h"

Define_Module(P2PNetwork);

void P2PNetwork::initialize() {
    networkTime = registerSignal("networkTime");
}

void P2PNetwork::finish() {

}
