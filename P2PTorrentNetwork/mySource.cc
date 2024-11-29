#include "mySource.h"

Define_Module(mySource);

mySource::mySource() {
	generateJobMsg = NULL;
}

mySource::~mySource() {

}

void mySource::initialize() {
	generateJobMsg = new cMessage("generate");
	startTime = par("startTime");	// zacetej generiranja
    stopTime = par("stopTime");		// konec generiranja
    numJobs = par("numJobs");		// koliko se jih zgenerira naenkrat
    maxJobs = par("maxJobs");		// maksimalno stevilo zgeneriranih
    jobCounter = 0;
    scheduleAt(startTime, generateJobMsg);
}

void mySource::handleMessage(cMessage* msg) {
    if (msg == generateJobMsg) {
    	if ((maxJobs < 0 || maxJobs > jobCounter) && (stopTime < 0 || stopTime > simTime())) {
    		scheduleAt(simTime() + par("interArrivalTime").doubleValue(), msg);
			for (int i = 0; i < numJobs; ++i) {
			    cPacket* job = new cPacket();
			    job->setKind(0);
				int address = intuniform(1, 4);
				job->setName(std::to_string(address).c_str());
				job->setTimestamp();
				send(job, "out");
				EV << "Created packet " << job->getId() << " at time " << simTime() << "\n";
				jobCounter++;
			}

			updateDisplay(jobCounter);
		} else {
			delete msg;
		}
    }
}

void mySource::updateDisplay(int i)
{
    char buf[100];
    sprintf(buf, "%ld", (long) i);
    getDisplayString().setTagArg("t",0,buf);
}
