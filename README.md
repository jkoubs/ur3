# UR3 Project

# Install

Open a new terminal and git clone the following repository:

```bash
git clone https://github.com/jkoubs/ur3.git
```

Then build the **ur3** image:

```bash
cd ur3-foxy/docker
docker build -f Dockerfile -t ur3 ../ 
```

Next we will create the container:

<u><strong><em>Requirement</em></strong></u> : To run GUI applications in Docker on Linux hosts, you have to run <strong>"xhost +local:root"</strong>. To disallow, <strong>"xhost -local:root"</strong>. For Windows and Mac hosts please check : [Running GUI applications in Docker on Windows, Linux and Mac hosts](https://cuneyt.aliustaoglu.biz/en/running-gui-applications-in-docker-on-windows-linux-mac-hosts/). Can also found some more information about [Using GUI's with Docker](http://wiki.ros.org/docker/Tutorials/GUI).

```bash
xhost +local:root
```

We can now run the image as a container named <strong>galactic_env_container</strong> using docker-compose :

```bash
docker-compose up
```
<u><strong><em>Note</em></strong></u>: We are using terminator which is a linux terminal emulator, to split a terminal horizontally press "<strong>Ctrl + Shift + O</strong>" et vertically press "<strong>Ctrl + Shift + E</strong>"

We are now <strong>inside the container</strong>. We can start developing our project.


# Testing UR3

**Note:** Since we are only using simulation and **not a real robot**, we don't need to worry about connecting to a physical robot via an IP address. Instead, we can use **use_fake_hardware:=true**.




The first step is to **start to controllers** (Terminal#1):

```bash
cd /workspace/ros_ur_driver/

colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release;source install/setup.bash

ros2 launch ur_bringup ur_control.launch.py ur_type:=ur3 robot_ip:=yyy.yyy.yyy.yyy use_fake_hardware:=true launch_rviz:=false
```

Then, we can **launch MoveIt** (Terminal#2):

```bash
cd /workspace/ros_ur_driver/

colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release;source install/setup.bash

ros2 launch ur_bringup ur_moveit.launch.py ur_type:=ur3 robot_ip:="xxx.xxx" use_fake_hardware:=true launch_rviz:=true
```# ur3
