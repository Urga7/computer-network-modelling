#ifndef P2PNETWORK_H_
#define P2PNETWORK_H_

#include <omnetpp.h>

using namespace omnetpp;

class P2PNetwork : public cSimpleModule {
private:
    simsignal_t networkTime;

public:
    P2PNetwork() {}
    virtual ~P2PNetwork() {}

protected:
    virtual void initialize() override;
    virtual void finish() override;
};


#endif /* P2PNETWORK_H_ */
