#include "Source.h"

Define_Module(Source);

Source::Source() {
	generateJobMsg = NULL;
}

Source::~Source() {

}

void Source::initialize() {
	generateJobMsg = new cMessage("generate");
    maxJobs = par("maxJobs");		// maksimalno stevilo zgeneriranih
    jobCounter = 0;
    scheduleAt(simTime()+par("interArrivalTime"), generateJobMsg);
}

void Source::handleMessage(cMessage* msg) {
    if ((maxJobs < 0 || maxJobs > jobCounter)) {

        simtime_t nextSendTime = simTime() + par("interArrivalTime");
        scheduleAt(nextSendTime, msg);

        cPacket* job = new cPacket();
        job->setKind(1);
        int address = intuniform(1, 4);
        job->setName(std::to_string(address).c_str());

        job->setTimestamp(simTime());
        send(job, "out");

        EV << "Created packet " << job->getId() << " at time " << simTime() << "\n";
        jobCounter++;

        updateDisplay(jobCounter);
    }
}

void Source::updateDisplay(int i)
{
    char buf[100];
    sprintf(buf, "%ld", (long) i);
    getDisplayString().setTagArg("t",0,buf);
}
