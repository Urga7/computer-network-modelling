#include "mySink.h"
#include "P2PNetwork.h"

Define_Module(mySink);

void mySink::initialize() {
	sinked = 0;
}

void mySink::handleMessage(cMessage* msg) {
    cPacket* job = check_and_cast<cPacket*>(msg);
	++sinked;
    double creationTime = job->getTimestamp().dbl();
    simtime_t lifespan = simTime() - creationTime;
    P2PNetwork* network = check_and_cast<P2PNetwork*>(getParentModule());
    network->addPacketLifespan(lifespan.dbl());
    EV << "Received packet " << job->getId() << " at time " << simTime() << " with lifespan: " << lifespan << "\n";
	delete job;
	updateDisplay(sinked);
}

void mySink::updateDisplay(int i) {
    char buf[100];
    sprintf(buf, "%ld", (long) i);
    getDisplayString().setTagArg("t", 0, buf);
}
