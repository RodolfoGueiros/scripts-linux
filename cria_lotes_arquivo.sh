#!/bin/bash
# Cria um 25 arquivos em lote de forma sequencial, numerada e acumulativa.

echo "Cria um lote de 25 arquivos sequenciais, com numeração crescente"

# Nome base dos arquivos (substitua "seuNome" pelo nome desejado)
seu_nome="Rodolfo"

# Verifica o maior número nos arquivos existentes
num_max_arq=$(ls -1 | grep -o -E "${seu_nome}[0-9]+" | sed "s/$seu_nome//" | sort -n | tail -n 1)

# Se não houver arquivos com o padrão, inicializa num_max_arq como 0
num_max_arq=${num_max_arq:-0}

# Cria 25 novos arquivos, começando do próximo número disponível
for num_novo_arq in $(seq $((num_max_arq + 1)) $((num_max_arq + 25))); do
  touch "${seu_nome}${num_novo_arq}"
done

# Exibe uma mensagem com a faixa de arquivos criados
echo "Criados arquivos: ${seu_nome}$((num_max_arq + 1)) até ${seu_nome}$((num_max_arq + 25))"

# Lista todos os arquivos criados com o nome base para confirmação
ls -1 | grep "^Rodolfo" | sort -V
