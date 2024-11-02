FROM osrf/ros:foxy-desktop
ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

# dependencies
RUN apt-get update --fix-missing && \
    apt-get install -y git && \
    apt-get install -y build-essential \
                       terminator \
                       nano \
                       vim \
                       python3-pip \
                       libeigen3-dev \ 
                       tree \
                       wget \
                       bash-completion \
                       gedit \
                       ros-foxy-turtlebot3-gazebo \
                       ros-foxy-turtlebot3 \
                       ros-foxy-xacro \
                       ros-foxy-joint-state-publisher \
                       ros-foxy-joint-state-publisher-gui \
                       ros-foxy-gazebo-ros-pkgs \
                       ros-foxy-rviz2 \
                       qtbase5-dev \
                       libqt5svg5-dev \
                       libzmq3-dev \
                       libdw-dev 
    # apt install qtbase5-dev \
    #             libqt5svg5-dev \
    #             libzmq3-dev \
    #             libdw-dev 
                
RUN apt-get -y dist-upgrade
RUN pip3 install transforms3d
# transforms3d = Functions for 3D coordinate transformations
# Conversions between different representations: 3x3 rotation matrices, Euler angles, quaternions

# Create 2 workspaces env_ws 2 ros2_ws containing the turtlebot3 pkgs
RUN mkdir -p /env_ws/src/turtlebot3_pkgs

# Source and Git clone turtlebot3_simulations, turtlebot3_msgs and turtlebot3 pkgs 
RUN source /opt/ros/foxy/setup.bash && \
    apt-get update --fix-missing && \
    cd /env_ws/src/turtlebot3_pkgs  && \
    git clone -b foxy-devel https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git && \
    git clone -b foxy-devel https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git && \
    git clone -b foxy-devel https://github.com/ROBOTIS-GIT/turtlebot3.git && \
    cd /env_ws/src  && \
    git clone https://github.com/BehaviorTree/Groot.git && \
    cd Groot && \
    git submodule update --init --recursive && \
    mkdir build; cd build && \
    cmake .. && \
    make && \
    cd /env_ws && \
    # This installs dpdencies declared in package.xml from all pkgs in the src folder for ROS 2 foxy
    rosdep install -i --from-path src --rosdistro foxy -y && \
    # Build env_ws
    colcon build --symlink-install


COPY /ros2_ws/ /ros2_ws/
RUN source /opt/ros/foxy/setup.bash && \
    apt-get update --fix-missing && \
    cd /ros2_ws  && \
    # This installs dpdencies declared in package.xml from all pkgs in the src folder for ROS 2 foxy
    rosdep install -i --from-path src --rosdistro foxy -y --skip-keys rviz && \
    # Build env_ws
    colcon build --symlink-install 


# Source automatically the underlay (all necessary setup to run ROS2) (add it to .bashrc file)
RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
RUN echo "source /ros2_ws/install/setup.bash" >> ~/.bashrc
# Source automatically the overlay (workspace -> env_ws) (add it to .bashrc file)
RUN echo "source /env_ws/install/setup.bash" >> ~/.bashrc
RUN echo "source /usr/share/gazebo/setup.sh" >> ~/.bashrc


# Setup colcon_cd
RUN echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
RUN echo "export _colcon_cd_root=/opt/ros/foxy/" >> ~/.bashrc

# Setup colcon tab completion
RUN echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc


# Install UR3
ENV COLCON_WS=/workspace/ros_ur_driver 
RUN mkdir -p $COLCON_WS/src && \
    cd $COLCON_WS && \
    git clone -b foxy https://github.com/UniversalRobots/Universal_Robots_ROS2_Driver.git src/Universal_Robots_ROS2_Driver && \
    rosdep install --ignore-src --from-paths src -y -r && \
    source /opt/ros/foxy/setup.bash && \
    colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    source install/setup.bash 

COPY docker/ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x /ros_entrypoint.sh
# Set Working directory
WORKDIR '/'
# Command to run when a container is started 
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]