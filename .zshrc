ZSH=/HOMEPATH/.oh-my-zsh
ZSH_CUSTOM=$ZSH/custom
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
plugins=(git extract colorize encode64 golang docker docker-compose)
source $ZSH/oh-my-zsh.sh
source ~/.p10k.zsh
# TODO Ascii art

# SSH key check
test -f ~/.ssh/id_rsa
[ "$?" = 0 ] && SSHRSA_OK=yes
[ -z $SSHRSA_OK ] && >&2 echo "[WARNING] No id_rsa SSH private key found, SSH functionalities might not work"

# Docker check
test -S /var/run/docker.sock
[ "$?" = 0 ] && DOCKERSOCK_OK=yes
[ -z $DOCKERSOCK_OK ] && >&2 echo "[WARNING] Docker socket not found, docker will not be available"

# Fixing permission on Docker socket
DOCKERSOCK_USER=`stat -c "%u" /var/run/docker.sock`
[ ! -z $DOCKERSOCK_OK ] && [ `stat -c "%g" /var/run/docker.sock` != `id -g` ] && sudo chown $DOCKERSOCK_USER:`id -g` /var/run/docker.sock

echo
echo "Running as `id`"
echo "Alpine version `cat /etc/alpine-release`"
echo "Go version `go version | cut -d' ' -f3`"
echo "Git version `git version | cut -d' ' -f3`"
echo
[ ! -z $DOCKERSOCK_OK ] && echo "Docker server `docker version --format {{.Server.Version}}`"
[ ! -z $DOCKERSOCK_OK ] && echo "Docker client `docker version --format {{.Client.Version}}`"
[ ! -z $DOCKERSOCK_OK ] && echo "Docker-Compose `docker-compose version --short`"
[ ! -z $DOCKERSOCK_OK ] && alias alpine='docker run -it --rm alpine:3.10'
[ ! -z $DOCKERSOCK_OK ] && alias dive='docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock wagoodman/dive'
[ ! -z $DOCKERSOCK_OK ] && alias citest='/workspace/ci/test setup all; /workspace/ci/test teardown'
if [ "$CGO_ENABLED" != 0 ]; then
  echo "CGO is enabled, installing C/C++ Alpine packages..."
  sudo apk --update add gcc g++
fi
echo "You have several Go tools:"
echo " * Generate testify/mock mocks from interfaces recursively: mockery -all"
echo " * Highlight unpinned variables: scopelint ./..."
echo "You have several Docker tools alias you can use:"
echo " * Inspect a Docker image layers: dive alpine"
echo " * Run lazydocker in a container: ld"
