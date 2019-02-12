# Copyright 2018 Nicholas Torres Okita <nicholas.okita@ggaunicamp.com>

import logging
import sys
import json
import boto3
import base64
from datetime import datetime
from datetime import timedelta
import operator

def terminateInstance(instanceid):
    ec2res = boto3.resource('ec2', region_name='us-east-1')
    inst = ec2res.Instance(instanceid)
    print(inst)
    inst.terminate()

def stopInstance(instanceid):
    ec2res = boto3.resource('ec2', region_name='us-east-1')
    inst = ec2res.Instance(instanceid)
    print(inst)
    # inst.stop()

def lambda_handler(event, context):
    cloudwatch = boto3.client('cloudwatch')
    ec2 = boto3.client('ec2',region_name='us-east-1')
    
    # filters = []
    # f1 = {}
    # f1['Name'] = 'instance-state-name'
    # f1['Values'] = ['running']
    # f1['Name'] = 'instance-type'
    # f1['Values'] = ['t2.micro']
    # filters.append(f1)

    filters = [{'Name':'instance-state-name', 'Values':['running']},
                {'Name':'instance-type', 'Values':['t2.micro']} ]

    # Describe all running instances
    instance_reservations = ec2.describe_instances(Filters=filters)
    
    # Get the metrics from cloudwatch for every instance, and with some business logic, determine the one with higher value
    for instance in instance_reservations['Reservations']:
        for _instance in instance['Instances']:
            instance_id = _instance['InstanceId']
            print("Killing: " + instance_id)
            terminateInstance(instance_id)

    return False