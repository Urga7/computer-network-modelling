

#ifndef MYQUEUE_H_
#define MYQUEUE_H_

#include <omnetpp.h>
#include <string.h>

using namespace omnetpp;

class myQueue : public cSimpleModule{
private:
	cQueue queue;
	//cMessage *endServiceMsg;
	int capacity;
	int length;
	int resources;
	int processing;
	simtime_t serviceTime;

	typedef std::list<cMessage *> jobsProcessingList;
	jobsProcessingList jobsProcessing;

public:
	myQueue();
	virtual ~myQueue();

protected:
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
    virtual void updateDisplay(int i, int p, int r);
};



#endif /* MYQUEUE_H_ */
