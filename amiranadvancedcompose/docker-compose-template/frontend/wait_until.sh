#!/bin/sh
echo "Waiting for backend to be available..."
until curl --silent --fail http://backend:8000; do
  echo "Backend is not available yet..."
  sleep 5
done
echo "Backend is up, starting frontend..."


exec nginx -g 'daemon off;'
