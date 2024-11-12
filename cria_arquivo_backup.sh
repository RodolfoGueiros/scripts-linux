#!/bin/bash
# Atividade para:
#  Criar um arquivo de backup de toda a estrutura de pastas usando tar
#  Registrar em log a criação do backup em um arquivo contendo a data, a hora e o nome do arquivo de backup
#  Transferir o arquivo de backup para outra pasta

echo -e "\e[32mOlá vou listar pausadamente os passos da atividade\e[0m\n"
read -n 1 -s -r -p $'\e[32mPressione para criar a estrutura de pastas...\e[0m' && echo ""

# Cria as pastas
mkdir -p CompanyA/{Employees,Finance,HR,IA,Management,SharedFolders} && \
read -n 1 -s -r -p $'\e[32mPressione para criar os arquivos nas pastas...\e[0m' && echo ""

# Cria os arquivos nas pastas
touch CompanyA/Employees/{Schedules}.csv && \
touch CompanyA/Finance/{Salary}.csv && \
touch CompanyA/SharedFolders/{backups}.csv && \
touch CompanyA/HR/{Managers,Assessments}.csv && \
touch CompanyA/Management/{Promotions,Sections}.csv && \
read -n 1 -s -r -p $'\e[32mPressione para gerar um arquivo de backup...\e[0m' && echo ""

# Compacta pasta para criar backup da Company
tar -cvpzf CompanyA/backup.CompanyA.tar.gz CompanyA && \
read -n 1 -s -r -p $'\e[32mPressione para salvar o log do backup...\e[0m' && echo ""

# Salva a data do log no backup no arquivo backups.csv dentro da pasta SharedFolders
echo "$(LC_TIME=pt_BR.UTF-8 TZ=America/Sao_Paulo date +"%A, %d de %B de %Y %H:%M:%S"), backup.CompanyA.tar.gz" | sudo tee CompanyA/SharedFolders/backups.csv && \
read -n 1 -s -r -p $'\e[32mPressione para exibir o conteudo do arquivo...\e[0m' && echo ""

# Exibe o conteúdo do arquivo
cat CompanyA/SharedFolders/backups.csv && \
read -n 1 -s -r -p $'\e[32mPressione para mover o arquivo de backup para pasta IA...\e[0m' && echo ""

# Move o arquivo de backup para a pasta IA
mv /home/ec2-user/CompanyA/backup.CompanyA.tar.gz /home/ec2-user/CompanyA/IA/ && \
read -n 1 -s -r -p $'\e[32mPressione para listar o conteúdo da pasta IA...\e[0m' && echo ""
ls /home/ec2-user/CompanyA/IA/
