#!/bin/bash
# Created by Rodolfo Gueiros
# Fonte: https://github.com/RodolfoGueiros/scripts-linux
# Função para criar uma pasta
cria_pasta() {
    read -p "Digite o nome da pasta que deseja criar: " folder_name
    mkdir -p "$folder_name" && echo "Pasta '$folder_name' criada com sucesso!" || echo "Erro ao criar a pasta."
}

# Função para criar um arquivo
cria_arquivo() {
    read -p "Digite o nome do arquivo que deseja criar: " file_name
    touch "$file_name" && echo "Arquivo '$file_name' criado com sucesso!" || echo "Erro ao criar o arquivo."
}

# Função para compactar um arquivo
compacta_arquivo() {
    read -p "Digite o nome do arquivo que deseja compactar (com extensão): " file_name
    tar -czvf "${file_name}.tar.gz" "$file_name" && echo "Arquivo '$file_name' compactado como '${file_name}.tar.gz'!" || echo "Erro ao compactar o arquivo."
}

# Função para descompactar um arquivo
descompacta_arquivo() {
    read -p "Digite o nome do arquivo que deseja descompactar (ex: arquivo.tar.gz): " archive_name
    tar -xzvf "$archive_name" && echo "Arquivo '$archive_name' descompactado com sucesso!" || echo "Erro ao descompactar o arquivo."
}

# Limpa a tela e exibe o menu
tput clear
tput cup 3 15
tput setaf 3
echo "Rodolfo Inovations"
tput sgr0

tput cup 5 17
tput rev
echo "M A I N - M E N U"
tput sgr0

tput cup 7 15
echo "1. Cria Pasta"

tput cup 8 15
echo "2. Cria Arquivo"

tput cup 9 15
echo "3. Compacta Arquivo"

tput cup 10 15
echo "4. Descompacta Arquivo"

tput bold
tput cup 12 15
read -p "Enter your choice [1-4] " choice

# Limpa a tela para cada execução
tput clear
tput sgr0
tput rc

# Executa a função correspondente com base na escolha do usuário
case $choice in
    1) cria_pasta ;;
    2) cria_arquivo ;;
    3) compacta_arquivo ;;
    4) descompacta_arquivo ;;
    *) echo "Opção inválida! Por favor, escolha uma opção entre 1 e 4." ;;
esac
