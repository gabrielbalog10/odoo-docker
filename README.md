# Odoo Docker

Este repositório traz informações referentes em como executar o Odoo e a localização em conjuto. Foi criado um DockerFile novo para o Odoo que traz novas libs e packages. Pode ser usado individualmente e tambem no docker-compose (recomendando).

## Instalação Docker (Ubuntu)

Recomenda-se seguir o tutorial oficial do docker-ce para sua instalação, mas pode-se usar o código abaixo:

### Docker CE

Atualize o sistema:

	sudo apt-get update

Instale os pacotes necessários:

	sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

Adicione a key do docker no sistema:

	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

Adicione o repositório:

	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"

Atualizae os repositórios:

	sudo apt-get update

Instale o docker-ce:

	sudo apt-get install docker-ce

Verifique se o docker foi instalado corretamente:

	sudo docker -v

Adicione o usuario docker:

	sudo groupadd docker

Adicione o usuario no grupo de root:
	
    sudo usermod -aG docker $USER

Deslogue do usuario e logue novamente, execute o comando abaixo:

	 docker -v

Caso o comando tenha sido bem sucedido você não precisará mais usar o sudo para executar comandos docker.

### Docker Compose

Faça o download do binário do docker-compose e adiciona no bin do ubuntu:

	curl -L https://github.com/docker/compose/releases/download/1.19.0-rc3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

Da permissão para execução:

	chmod +x /usr/local/bin/docker-compose

Verifique se funciona corretamente:

	docker-compose -v
