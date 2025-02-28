@echo off
start /b mix phx.server
timeout /t 5
ngrok http 4000 --domain=immortal-monkey-fairly.ngrok-free.app