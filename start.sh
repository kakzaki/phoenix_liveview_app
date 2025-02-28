#!/bin/bash
mix phx.server &
sleep 5
ngrok http 4000 --domain=immortal-monkey-fairly.ngrok-free.app