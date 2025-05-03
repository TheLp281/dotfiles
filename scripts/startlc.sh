#!/bin/bash

gnome-terminal -- bash -c "cd LiventCord/server/src && dotnet watch run; exec bash" &
gnome-terminal -- bash -c "cd LiventCord/server/go-ws-api && go run .; exec bash" &
gnome-terminal -- bash -c "cd LiventCord/web && pnpm start; exec bash" &

