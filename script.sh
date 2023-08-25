#!/bin/bash
#set -x
if docker ps | grep -q test_task_1
then
	echo "Container 'test_task_1' is Running!"

elif docker images | grep test_task_1
then
	docker run -d --rm --name test_task_1 test_task_1 && \
	echo "Container 'test_task_1' is Running!"

else    docker build -t test_task_1 . && \
	docker run -d --rm --name test_task_1 test_task_1 && \
        echo "Container 'test_task_1' is Running!"
fi
