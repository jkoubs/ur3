#!/bin/bash
set -e  # This was causing Docker to exit when auto-filling or running into error

. "/opt/ros/foxy/setup.bash"
. "/env_ws/install/setup.bash"
. "/usr/share/gazebo/setup.sh"


exec "$@"