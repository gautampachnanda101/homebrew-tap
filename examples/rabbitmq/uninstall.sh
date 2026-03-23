#!/usr/bin/env bash
set -euo pipefail
kubectl delete namespace rabbitmq --ignore-not-found=true
echo "RabbitMQ removed"
