#!/bin/bash

# Start backend
cd /workspace/backend
mvn exec:java -Dexec.mainClass=SMS.Main -Dexec.args="--noui" &

# Start frontend
cd /workspace/frontend
npm run start -- --host 0.0.0.0 &

# Wait for both
wait

