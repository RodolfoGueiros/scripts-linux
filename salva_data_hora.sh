#!/bin/bash

# O comando grava a data e hora atuais, juntamente com o nome do arquivo de backup, no arquivo backups.csv.

echo "$(LC_TIME=pt_BR.UTF-8 TZ=America/Sao_Paulo date +"%A, %d de %B de %Y %H:%M:%S"), backup.CompanyA.tar.gz" | sudo tee CompanyA/SharedFolders/backups.csv
