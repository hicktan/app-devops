## 🚀 Aplicação Web de Portfólio DevOps (Python/Flask)
Este repositório contém o código-fonte de uma aplicação web simples, focada em demonstrar a implementação de Infraestrutura como Código (IaC) e Entrega Contínua (CI/CD) na AWS.

### 🎯 Arquitetura da Aplicação
A aplicação utiliza um stack de produção encapsulado em um único container Docker para garantir a estabilidade e a performance:

* **Proxy Reverso: Nginx** (expõe a porta 80 para o mundo).

* **Servidor WSGI: Gunicorn** (processa o código Python).

* **Aplicação: Flask** (o backend).

* **Gerenciamento: Supervisor** (mantém o Nginx e o Gunicorn ativos).

### 🛠️ Estrutura e Pré-requisitos
**1. Estrutura do Projeto**
```
/meu-app-devops
├── website/              # Código-fonte da aplicação (app.py, templates, etc.)
│   ├── app.py
│   ├── requirements.txt
│   └── templates/
├── Dockerfile            # Receita para construir a imagem Docker
└── .github/              # Configurações da pipeline
```
**2. Pré-requisitos (Para Rodar Localmente)**

* Docker Desktop (ou Docker Engine)

* Git

### ▶️ Rodando e Testando Localmente
Para construir e executar a imagem na sua máquina:

**1. Construir a Imagem:**

```bash
# Usamos o contexto da pasta './website' e o Dockerfile da raiz
docker build -t meu-app-devops:local -f Dockerfile ./website
```

**2. Executar o Container:**

```bash
# O '-d' roda em background; '--name' para facilitar a parada; '-p 80:80' mapeia a porta
docker run -d --name app-devops-local -p 80:80 meu-app-devops:local

# Verifique o status:
docker ps
```

Acesse a aplicação em http://localhost.

### 🌐 Ciclo de Vida e Deploy
Este projeto demonstra a automação completa do ciclo de vida.

**1. Infraestrutura como Código (IaC)**
A infraestrutura AWS necessária para hospedar esta aplicação é criada e gerenciada via **Terraform**.

| Recurso                 |Função                              |
| ------------------------|:----------------------------------:|
| Repositório de IaC      | `infra-aws-terraform`              |
| Recursos Criados        |EC2, ECR, IAM Roles, Security Group.|

**2. Pipeline de Entrega Contínua (CD)**
A pipeline é totalmente automatizada e acionada por qualquer `git push` na branch `main`.

| Fase                 |Ferramenta                             |Ação                             | Status                 |
| ------------------------|:----------------------------------:|:----------------------------------:|------------------------ |
|CI (Integração)     | GitHub Actions             | Build da imagem com tag imútavel (SHA do commit) e Push para o AWS ECR.                 | Automatizado      |
| CD (Entrega)       |AWS SSM Run Command         |Deploy Seguro: Comando enviado para a EC2 via SSM (eliminando a necessidade da Porta 22).| Automatizado    |

**3. Rastreabilidade (Traceability)**
**Tag da Imagem**: Cada imagem no ECR corresponde exatamente a um commit no GitHub (`ex: seu-repo:b0cf9013...`).

**Deploy Status**: O deploy utiliza SSM para atualizar o container sem intervenção manual, garantindo um processo seguro.
