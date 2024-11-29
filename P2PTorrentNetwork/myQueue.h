

#ifndef MYQUEUE_H_
#define MYQUEUE_H_

#include <omnetpp.h>
#include <string.h>

using namespace omnetpp;

class myQueue : public cSimpleModule{
private:
	cQueue queue;
	cMessage* currentJob;
	simtime_t serviceTime;
	int capacity;
	int length;
	int address;

public:
	myQueue();
	virtual ~myQueue();

protected:
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
    virtual void updateDisplay(int i);
    virtual std::string addressToGate(const char* jobAddress);
};



#endif /* MYQUEUE_H_ */
