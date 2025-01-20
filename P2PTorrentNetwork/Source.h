#ifndef SOURCE_H_
#define SOURCE_H_

#include <omnetpp.h>

using namespace omnetpp;

class Source : public cSimpleModule{
private:
	cMessage *generateJobMsg;
    int maxJobs, jobCounter;

protected:
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
    virtual void updateDisplay(int i);

public:
    Source();
	virtual ~Source();
};

#endif /* SOURCE_H_ */
