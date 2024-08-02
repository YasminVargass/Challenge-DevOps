# Use uma imagem oficial do Node.js como imagem base
FROM node:18

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /usr/src/app

# Copie o arquivo package.json e package-lock.json
COPY package*.json ./

# Instale as dependências do projeto
RUN npm install

# Copie o restante dos arquivos da aplicação
COPY . .

# Exponha a porta que a aplicação irá rodar
EXPOSE 3000

# Defina o comando de inicialização da aplicação
CMD ["node", "src/index.js"]
