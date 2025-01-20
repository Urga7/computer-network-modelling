#include "Sink.h"
#include "P2PNetwork.h"

Define_Module(Sink);

void Sink::initialize() {
	sinked = 0;
	network = check_and_cast<P2PNetwork*>(getParentModule());
	if(!network)
	    EV << "Error: No parent module" << endl;

	networkTime = registerSignal("networkTime");
}

void Sink::handleMessage(cMessage* msg) {
    cPacket* job = check_and_cast<cPacket*>(msg);
	++sinked;
    simtime_t creationTime = job->getTimestamp();
    simtime_t lifespan = simTime() - creationTime;
    cModule *parentModule = getParentModule();
    network->emit(networkTime, lifespan.dbl());
	delete job;
	updateDisplay(sinked);
}

void Sink::updateDisplay(int i) {
    char buf[100];
    sprintf(buf, "%ld", (long) i);
    getDisplayString().setTagArg("t", 0, buf);
}
