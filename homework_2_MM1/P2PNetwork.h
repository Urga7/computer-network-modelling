#ifndef P2PNETWORK_H_
#define P2PNETWORK_H_

#include <omnetpp.h>

using namespace omnetpp;

class P2PNetwork : public cSimpleModule {
private:
    double totalLifespan = 0;
    int packetCount = 0;

public:
    P2PNetwork() {}
    virtual ~P2PNetwork() {}
    virtual void addPacketLifespan(double lifespan);
    virtual double getAverageLifespan() const;

protected:
    virtual void initialize() override;
    virtual void finish() override;
};


#endif /* P2PNETWORK_H_ */
