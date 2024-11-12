#!/bin/bash
# Script para criar grupo importando uma planiha em formato .csv

# Função para criar grupo
create_group() {
    read -p "Digite o nome do grupo a ser criado: " GROUP_NAME
    if getent group $GROUP_NAME > /dev/null; then
        echo "O grupo '$GROUP_NAME' já existe."
    else
        groupadd $GROUP_NAME
        echo "Grupo '$GROUP_NAME' criado com sucesso."
    fi
}

# Função para processar arquivo CSV
process_csv() {
    read -p "Digite o caminho completo do arquivo CSV: " CSV_PATH
    
    if [ ! -f "$CSV_PATH" ]; then
        echo "Arquivo não encontrado!"
        return 1
    fi

    FIRST_LINE=true
    
    while IFS=',' read -r FIRST_NAME LAST_NAME USERNAME ROLE GROUP_NAME PASSWORD || [ -n "$FIRST_NAME" ]; do
        if [ "$FIRST_LINE" = true ]; then
            FIRST_LINE=false
            continue
        fi
        
        FIRST_NAME=$(echo "$FIRST_NAME" | tr -d '"' | tr -d ' ')
        LAST_NAME=$(echo "$LAST_NAME" | tr -d '"' | tr -d ' ')
        USERNAME=$(echo "$USERNAME" | tr -d '"' | tr -d ' ')
        ROLE=$(echo "$ROLE" | tr -d '"')
        GROUP_NAME=$(echo "$GROUP_NAME" | tr -d '"' | tr -d ' ')
        PASSWORD=$(echo "$PASSWORD" | tr -d '"' | tr -d ' ')
        
        if id "$USERNAME" &>/dev/null; then
            echo "O usuário '$USERNAME' já existe. Pulando..."
        else
            useradd -m -G "$GROUP_NAME" -c "$FIRST_NAME $LAST_NAME, $ROLE" "$USERNAME"
            echo "$USERNAME:$PASSWORD" | chpasswd
            passwd -e "$USERNAME"
            echo "Usuário '$USERNAME' ($FIRST_NAME $LAST_NAME, $ROLE) adicionado ao grupo '$GROUP_NAME' com sucesso."
        fi
    done < "$CSV_PATH"
}

# Função para adicionar usuário manualmente
add_user() {
    read -p "Digite o nome do usuário: " FIRST_NAME
    read -p "Digite o sobrenome do usuário: " LAST_NAME
    read -p "Digite o ID do usuário (ex: arosalez): " USERNAME
    read -p "Digite o cargo do usuário: " ROLE
    read -p "Digite o nome do grupo: " GROUP_NAME
    read -sp "Digite a senha inicial para o usuário '$USERNAME': " PASSWORD
    echo
    
    if id "$USERNAME" &>/dev/null; then
        echo "O usuário '$USERNAME' já existe."
    else
        useradd -m -G "$GROUP_NAME" -c "$FIRST_NAME $LAST_NAME, $ROLE" "$USERNAME"
        echo "$USERNAME:$PASSWORD" | chpasswd
        passwd -e "$USERNAME"
        echo "Usuário '$USERNAME' ($FIRST_NAME $LAST_NAME, $ROLE) adicionado ao grupo '$GROUP_NAME' com sucesso."
    fi
}

# Função para listar todos os grupos
list_groups() {
    echo "Grupos disponíveis no sistema:"
    cut -d: -f1 /etc/group
}

# Função para listar todos os usuários de um grupo
list_group_users() {
    read -p "Digite o nome do grupo: " GROUP_NAME
    if getent group $GROUP_NAME > /dev/null; then
        echo "Usuários no grupo '$GROUP_NAME':"
        getent group $GROUP_NAME | awk -F: '{print $4}'
    else
        echo "O grupo '$GROUP_NAME' não existe."
    fi
}

# Menu principal
while true; do
    echo "---------------------------------"
    echo "Menu de Administração de Usuários"
    echo "1. Criar um novo grupo"
    echo "2. Adicionar um usuário ao grupo"
    echo "3. Importar usuários de arquivo CSV"
    echo "4. Listar todos os grupos"
    echo "5. Listar usuários de um grupo"
    echo "6. Sair"
    echo "---------------------------------"
    read -p "Escolha uma opção [1-6]: " OPTION
    
    case $OPTION in
        1)
            create_group
            ;;
        2)
            add_user
            ;;
        3)
            process_csv
            ;;
        4)
            list_groups
            ;;
        5)
            list_group_users
            ;;
        6)
            echo "Saindo..."
            exit 0
            ;;
        *)
            echo "Opção inválida. Tente novamente."
            ;;
    esac
done
