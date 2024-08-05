# Use uma imagem oficial do Node.js como imagem base
FROM node:18

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /usr/src/app

# Copie o arquivo package.json e package-lock.json
COPY node/package*.json ./

# Instale as dependências do projeto
RUN npm install

# Copie o restante dos arquivos da aplicação
COPY node/ .

# Exponha a porta que a aplicação irá rodar
EXPOSE 8080

# Defina o comando de inicialização da aplicação
CMD ["node", "src/index.js"]
