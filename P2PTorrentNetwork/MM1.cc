
#include "MM1.h"

Define_Module(MM1);

MM1::MM1() {
    currentJob = NULL;
}

MM1::~MM1() {
    if (currentJob != nullptr) {
        cancelEvent(currentJob);
        delete currentJob;
    }
}


void MM1::initialize() {

    droppedPacketsSignal = registerSignal("droppedPackets");
    saturationRatioSignal = registerSignal("saturationRatio");
    queueWaitingTimeSignal = registerSignal("queueWaitingTime");
    utilisationFactorSignal = registerSignal("utilisationFactor");

    capacity = par("capacity");
    address = par("address");
    queue.setName("queue");
    length = 0;

    emit(saturationRatioSignal, 0.0);
}

std::string MM1::addressToGate(const char* jobAddress) {

    if(atoi(jobAddress) == address) {
        return "out";
    }

    return "outNet";
}

void MM1::handleMessage(cMessage* msg) {
    const char* jobAddress = msg->getName();
	if (msg->getKind() == 10) { // sporocilo o koncu procesiranja

	    cMessage* job = check_and_cast<cPacket*>(msg);
        job->setKind(1);
        send(job, addressToGate(jobAddress).c_str());


        if (queue.isEmpty()) {

            currentJob = NULL;
            emit(utilisationFactorSignal, 0);

        } else {

            simtime_t processingTime = simTime() + par("serviceTime");

            job = check_and_cast<cMessage*>(queue.pop());
            job->setKind(10);

            emit(queueWaitingTimeSignal, (simTime() - job->par("arrivalTime").doubleValue()).dbl());
            scheduleAt(processingTime, job);   // v izvajanje damo novo opravilo, ki se bo izvedlo cez serviceTime casa
            emit(utilisationFactorSignal, 1);

            currentJob = job;
            --length;

        }

    } else { // novo opravilo

        cMessage* job = check_and_cast<cPacket*>(msg);;
        job->setKind(1);

        if (currentJob == NULL) {
            job->setKind(10);
            currentJob = job;

            scheduleAt(simTime() + par("serviceTime"), job);
            emit(saturationRatioSignal, 0.0);
            emit(queueWaitingTimeSignal, 0.0);
            emit(utilisationFactorSignal, 1);
        } else {

            if (capacity >= 0 && length >= capacity) { // cakalna vrsta je presegla svojo kapaciteto
                emit(droppedPacketsSignal, 1);
                cancelEvent(job);
                delete job;
                emit(saturationRatioSignal, static_cast<double>(length) / capacity);
            } else { // vstavi v cakalno vrsto

                //job->setTimestamp();
                if (job->hasPar("arrivalTime"))
                    job->par("arrivalTime") = simTime().dbl();
                 else{
                     job->addPar("arrivalTime").setDoubleValue(simTime().dbl());
                 }
                queue.insert(job);
                ++length;
                emit(saturationRatioSignal, static_cast<double>(length) / capacity);
            }
        }
    }

	updateDisplay(length);
}

void MM1::updateDisplay(int l) {
    char buf[100];
    sprintf(buf, "Q_length :%ld", (long) l);
    getDisplayString().setTagArg("t", 0, buf);
}
