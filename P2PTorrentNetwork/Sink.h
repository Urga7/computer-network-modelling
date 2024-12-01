#ifndef SINK_H_
#define SINK_H_

#include <omnetpp.h>
#include <P2PNetwork.h>

using namespace omnetpp;

class Sink : public cSimpleModule{

private:
    simsignal_t networkTime;
    P2PNetwork* network;
public:

protected:
	int sinked;
	virtual void initialize();
    virtual void handleMessage(cMessage *msg);
    virtual void updateDisplay(int i);

};

#endif /* SINK_H_ */
