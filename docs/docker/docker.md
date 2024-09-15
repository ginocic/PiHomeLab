# Install Docker Engine

## Uninstall old versions

Run the following command to uninstall all conflicting packages:

``` sh
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt remove $pkg; done
```

`apt` might report that you have none of these packages installed.

To start with a clean installation, and prefer to clean up any existing data, read the [Uninstall Docker Engine] section.

[uninstall Docker Engine]: #uninstall-docker-engine

## Install using the apt repository

Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker apt repository. Afterward, you can install and update Docker from the repository.

### Add Docker's official GPG key

``` sh
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

### Add the repository to Apt sources

``` sh
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

### Install the Docker packages

``` sh
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### Verify the installation

``` sh
sudo docker run hello-world
sudo docker -v
sudo docker compose version
```

## Upgrade Docker Engine

To upgrade Docker Engine, repeat from the [Install the Docker packages] of the installation instructions

[Install the Docker packages]: #install-the-docker-packages

## Uninstall Docker Engine

Uninstall the Docker Engine, CLI, containerd, and Docker Compose packages:

``` sh
sudo apt purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
```

Images, containers, volumes, or custom configuration files on the host aren't automatically removed. To delete all images, containers, and volumes:

``` sh
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

Delete any edited configuration files manually.
