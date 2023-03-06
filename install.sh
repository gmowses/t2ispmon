# 1. Atualize a lista de pacotes do sistema
echo Atualizando o sistema
sudo apt-get update -y

# 2. Instale as dependências necessárias
echo instalando as dependencias nescessarias
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common pv mariadb-client wget git fail2ban -y 

# 3. Adicione a chave GPG oficial do Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# 4. Adicione o repositório do Docker às fontes de pacotes do APT
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# 5. Atualize a lista de pacotes do sistema novamente
sudo apt-get update -y

# 6. Instale o Docker Engine
echo instalando Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

#Fail 2 ban e SSH
sudo sed -i 's/findtime  = 1/findtime  = 10m/g; s/maxretry = 1/maxretry = 3/g' /etc/fail2ban/jail.conf
sudo sed -i -e '/^\[DEFAULT\]/,/^\[/ s/^bantime\s*=.*/bantime = 1h/' -e '/^\[DEFAULT\]/,/^\[/ s/^findtime\s*=.*/findtime = 30/' /etc/fail2ban/jail.conf
sudo sed -i 's/#Port 22/Port 65022/; s/#LoginGraceTime 2m/LoginGraceTime 20/' /etc/ssh/sshd_config




# 7. Criar pasta de trabalho
sudo mkdir t2web
cd t2web
#DNS

# 8. Baixar o repositorio
sudo git clone https://github.com/gmowses/t2ispmon.git .
read -p "Digite o bloco IPV4 do Cliente. (Ex: 10.0.0.0/22) " endereco_novo && sudo sed -i "/        181.191.104.0\/22;/a \        $endereco_novo;" assets/named.conf.options
# 9. Executa o stack 
echo executando o Stack de Containers

sudo docker compose up -d

# 10. Configurar o arquivo do DNS recursivo

#11. Padronizar acesso e config base
sleep 120
echo "Aguarde..."
#BIND9
sudo mv -f assets/named.conf.options /opt/docker/data/bind9/data/bind/etc/
#NGINX
sudo mv -f assets/database.sqlite /opt/docker/data/nginxproxymanager/data/
#GRAFANA
sudo mv -f assets/grafana.db /opt/docker/data/grafana/
#ZABBIX
mysql -h 172.20.0.2 -u root -p@mysql@t2web#123 zabbix < assets/zabbix.sql

#12. FINAL
echo ------------------------------------------
echo
echo INSTALAÇÃO FINALIZADA
echo PORFAVOR REALIZE OS TESTE DE LOGIN NAS PLATAFORMAS
echo E ADCIONE O DOCKER AGENT NO DOCKER CENTRAL DA T2WEB.
