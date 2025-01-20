#ifndef MM1_H_
#define MM1_H_

#include <omnetpp.h>
#include <string.h>

using namespace omnetpp;

class MM1 : public cSimpleModule{
private:
	cQueue queue;
	cMessage* currentJob;
	simsignal_t droppedPacketsSignal, saturationRatioSignal, queueWaitingTimeSignal, utilisationFactorSignal;
	int capacity;
	int length;
	int address;

public:
	MM1();
	virtual ~MM1();

protected:
    virtual void initialize();
    virtual void handleMessage(cMessage *msg);
    virtual void updateDisplay(int i);
    virtual std::string addressToGate(const char* jobAddress);
};



#endif /* MM1_H_ */
