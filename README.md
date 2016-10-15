# CloudStack on Docker #

This project aims to bring CloudStack to service providers and cloud enthusiasts in a turnkey solution. It is comprised by:

- `opsforge/cloudstack` [![](https://images.microbadger.com/badges/version/opsforge/cloudstack.svg)](https://hub.docker.com/r/opsforge/cloudstack "Docker Hub link") [![](https://images.microbadger.com/badges/image/opsforge/cloudstack.svg)](https://microbadger.com/images/opsforge/cloudstack "Get your own image badge on microbadger.com")
- `mysql:5.5` public image
- docker-compose for configuring and running the stack in a clustered fashion

This project is currently a work in progress!

Build health: [ ![Codeship Status for opsforgeio/cloudstack-docker](https://codeship.com/projects/6b1a5e20-6f82-0134-fa2f-3a51310aa3ef/status?branch=master)](https://codeship.com/projects/178063) Code health: [![Issue Count](https://codeclimate.com/github/opsforgeio/cloudstack-docker/badges/issue_count.svg)](https://codeclimate.com/github/opsforgeio/cloudstack-docker)

## How to install ##

```
- You'll need a host running Docker Engine `1.12` or newer
- docker-compose `1.8.0` or newer
```
- Clone the project repository to your host
- In the configure-cloud folder, edit the `docker-compose.yml` for each `volumes` line:

```
volumes:
  - /my/home/folder/target:original_value
      
EXAMPLE:
volumes:
  - /Users/yeehaw/export:/export
```

- Execute the following steps to set up the stack:

```
cd ./configure-cloud
docker-compose up -d
```
  
- This will pull the public images from Docker Hub and set the stack up. Volumes will be mounted per the compose file.
- Data will be stored for mysql under the required folder + the NFS shares that CloudStack will be setting up
- Initial run can take up to 20 minutes depending on machine performance
- You can monitor the state of the commands by `docker logs cloudstack_container_name` or running this on a machine with Kinematic or Swarm host with a UI
- Do NOT cancel this or you will have to start over!
- When the process is complete (system vms downloaded and sql setup done), you can reach CloudStack from the host on http://HOST_IP:8080/client
- Stop the stack with:

```
docker-compose down
```

11. Follow up with `run steps` to use the stack.

## Run steps ##

- Once you have installed the stack successfully, run the following commands to maintain the stack (use it):

```
cd ./run-cloud
docker-compose up -d
```

- When it's online, you can reach it from http://HOST_IP:8080/client

## How to build ##

- Nothing fancy here, just cd into the subfolder of the Dockerfiles and run:

```
docker build -t 'opsforge/cloudstack:latest' .

OR

docker build -t 'opsforge/cloudstack-mysql:latest' .
```

- Keep in mind that the cloudstack-mysql is completely useless for the time being (newer than compatible mysql and missing lots of conditional checks on startup). Compose is using the public mysql:5.5 image by default.
