## Dockerfile for Eventstore 

Create an image based on Debian Jessie that runs [Event Store](http://geteventstore.com/).

### What is an Event Store?

The [Event Store](http://geteventstore.com/) is a database for supporting the concept of [Event Sourcing](http://martinfowler.com/eaaDev/EventSourcing.html).

### Build 

```bash
docker build -t eventstore:3.0.5 .
```

### Run

```bash
docker run --name some-eventstore -d -p 2113:2113 -p 1113:1113 eventstore:3.0.5 --ext-ip=0.0.0.0 --http-prefixes="http://*:2113/" --run-projections=all
```

The web console of Eventstore is available at `http://<docker-host-ip>:2113`.

The `EVENTSTORE_DB` and `EVENTSTORE_LOG` (set to `/data/db` and `/data/logs` respectively) are exposed as volumes.