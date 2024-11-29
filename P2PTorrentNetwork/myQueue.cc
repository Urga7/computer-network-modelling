
#include "myQueue.h"

Define_Module(myQueue);

myQueue::myQueue() {
    currentJob = NULL;
}

myQueue::~myQueue() {
    delete currentJob;
}

void myQueue::initialize() {
    capacity = par("capacity");
    serviceTime = par("serviceTime");
    address = par("address");
    queue.setName("queue");
    length = 0;
}

std::string myQueue::addressToGate(const char* jobAddress) {
    if(atoi(jobAddress) == address) {
        return "out";
    }

    return "outNet";
}

void myQueue::handleMessage(cMessage* msg) {
    const char* jobAddress = msg->getName();
	if (msg->getKind() == 10) { // sporocilo o koncu procesiranja
        cMessage* job = check_and_cast<cPacket*>(msg);
        job->setKind(1);
        send(job, addressToGate(jobAddress).c_str());
        if (queue.isEmpty()) {
            currentJob = NULL;
        } else {
            job = check_and_cast<cMessage*>(queue.pop());
            job->setKind(10);
            scheduleAt(simTime() + serviceTime, job);   // v izvajanje damo novo opravilo, ki se bo izvedlo cez serviceTime casa
            currentJob = job;
            EV << "Cakalni cas:" << simTime() - job->getTimestamp() << " s";
            --length;
        }

    } else { // novo opravilo
        cMessage* job = check_and_cast<cPacket*>(msg);;
        job->setKind(1);
        if (currentJob == NULL) {
            job->setKind(10);
            currentJob = job;
            scheduleAt(simTime() + serviceTime, job);
        } else {
            if (capacity >= 0 && length >= capacity) // cakalna vrsta je presegla svojo kapaciteto
                cancelAndDelete(job);
            else { // vstavi v cakalno vrsto
                job->setTimestamp();
                queue.insert(job);
                ++length;
            }
        }
    }

	updateDisplay(length);
}

void myQueue::updateDisplay(int l) {
    char buf[100];
    sprintf(buf, "Q_length :%ld", (long) l);
    getDisplayString().setTagArg("t", 0, buf);
}
