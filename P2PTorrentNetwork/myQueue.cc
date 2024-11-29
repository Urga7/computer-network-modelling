
#include "myQueue.h"

Define_Module(myQueue);

myQueue::myQueue() {
	//endServiceMsg = NULL;
}

myQueue::~myQueue() {
	jobsProcessingList::iterator msg;
	for (msg=jobsProcessing.begin(); msg!=jobsProcessing.end(); msg++)
	{
		cancelAndDelete(*msg);
	}
	jobsProcessing.clear();
}

void myQueue::initialize()
{
    capacity = par("capacity");
    serviceTime = par("serviceTime");
    queue.setName("queue");
    length = 0;
    resources = par("resources");
    processing = 0;
    jobsProcessing.clear();
}

void myQueue::handleMessage(cMessage *msg)
{
	// The message kind member is not used by OMNeT++, it can be used freely by the user.

	// ali je prislo sporocilo o koncu procesiranja
	if (msg->getKind() == 10)
	{
        cMessage *job = check_and_cast<cMessage *>(msg);

        jobsProcessingList::iterator msgIterator;
        for (msgIterator=jobsProcessing.begin(); msgIterator!=jobsProcessing.end(); msgIterator++)
        {
            if ((*msgIterator)->getId()==job->getId())
            {
                jobsProcessing.erase(msgIterator);
                processing--;
                break;
            }

        }

        job->setKind(0);
        send(job, "out");

        if ( ! queue.isEmpty() )
        {
            job = check_and_cast<cMessage *>( queue.pop() );
            job->setKind(10);
            jobsProcessing.push_back(job);

            scheduleAt( simTime()+serviceTime, job );	// v izvajanje damo novo opravilo, ki se bo izvedlo cez serviceTime casa

            EV << "Cakalni cas:" << simTime() - job->getTimestamp() << " s";

            processing++;
            length--;
        }
    }
    // ali je prislo novo opravilo
    else
    {
        cMessage *job = msg;
        job->setKind(1);

        if (processing < resources)
        {
            processing ++;
            job->setKind(10);
            jobsProcessing.push_back(job);
            scheduleAt( simTime()+serviceTime, job );
        }
        else
        {
            if (capacity >=0 && length >= capacity)
            {
                // cakalna vrsta je presegla svojo kapaciteto
                cancelAndDelete( job );
            }
            else
            {
                // vstavi v cakalno vrsto
                job->setTimestamp();
                queue.insert( job );
                length++;
            }
        }
    }
	updateDisplay(length, processing, resources);
}

void myQueue::updateDisplay(int i, int p, int r)
{
    char buf[300];
    sprintf(buf, "Q_length :%ld, Resources: %ld/%ld", (long) i, (long) p, (long) r);
    getDisplayString().setTagArg("t",0,buf);
}
