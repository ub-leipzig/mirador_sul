## Install on CENTOS VM

## As `root`

```bash
yum update
localectl set-locale LANG=de_DE.utf8
yum install yum-cron
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum makecache fast
yum install docker-ce
usermod -aG docker `username`
usermod -aG wheel `username`
curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
docker-compose -v
systemctl start docker
yum install git
sudo `username`
```

## As `username`
```bash
cd /srv
git clone https://github.com/ub-leipzig/mirador_sul.git
cd mirador_sul
git branch ubl
git pull origin ubl
mkdir /mnt/mirador-data
yum install tmux
tmux
docker-compose up
```
To exit tmux: use `ctl-B shift-D` then `0`

To attach to tmux session: `tmux attach-session -t 0
`





