#include "P2PNetwork.h"

Define_Module(P2PNetwork);

void P2PNetwork::initialize() {}

void P2PNetwork::finish() {
    EV << "Average packet lifespan: " << getAverageLifespan() << " seconds" << endl;
}

void P2PNetwork::addPacketLifespan(double lifespan) {
    totalLifespan += lifespan;
    packetCount++;
}

double P2PNetwork::getAverageLifespan() const {
    return packetCount > 0 ? totalLifespan / packetCount : 0.0;
}
