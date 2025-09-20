# 🚀 Como Colocar no GitHub - Guia Completo

## 📋 Passo a Passo para Publicar

### 1️⃣ **Criar Repositório no GitHub**

1. **Acesse** [GitHub.com](https://github.com)
2. **Clique** em "New Repository" (botão verde)
3. **Configure** o repositório:
   - 📝 **Nome:** `World-Zero-Script` ou `WZ-AutoFarm`
   - 📖 **Descrição:** `Scripts seguros de AutoFarm para World Zero`
   - 🌐 **Público:** ✅ (para usar loadstring)
   - 📄 **README:** ✅ (marque a opção)

### 2️⃣ **Upload dos Arquivos**

**Opção A - Interface Web:**
1. **Clique** em "Add file" → "Upload files"
2. **Arraste** todos os arquivos da pasta `GitHub-Ready/`
3. **Commit** com mensagem: `Initial commit - Scripts seguros`

**Opção B - Git Desktop:**
1. **Clone** o repositório
2. **Copie** os arquivos para a pasta
3. **Commit** e **Push**

### 3️⃣ **Estrutura Final do Repositório**

```
seu-usuario/World-Zero-Script/
├── Private-AutoFarm.lua
├── Tower-AutoFarm.lua  
├── Dungeon-AutoFarm.lua
├── loadstrings.md
├── README.md
└── SETUP.md
```

---

## 🔗 Como Gerar os Loadstrings

### 📋 **Template dos Loadstrings:**

Substitua `SEU-USUARIO` pelo seu nome de usuário do GitHub:

#### 🏰 Private AutoFarm:
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU-USUARIO/World-Zero-Script/main/Private-AutoFarm.lua"))()
```

#### 🗼 Tower AutoFarm:
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU-USUARIO/World-Zero-Script/main/Tower-AutoFarm.lua"))()
```

#### ⚔️ Dungeon AutoFarm:
```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU-USUARIO/World-Zero-Script/main/Dungeon-AutoFarm.lua"))()
```

---

## ✏️ **Editar URLs nos Arquivos**

### 📝 **Arquivos que precisam ser editados:**

1. **Private-AutoFarm.lua** (linha 7):
```lua
-- ANTES:
loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU-USUARIO/World-Zero-Script/main/GitHub-Ready/Private-AutoFarm.lua"))()

-- DEPOIS:
loadstring(game:HttpGet("https://raw.githubusercontent.com/MOTTA063/World-Zero-Script/main/Private-AutoFarm.lua"))()
```

2. **Tower-AutoFarm.lua** (linha 7):
```lua
-- ANTES:
loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU-USUARIO/World-Zero-Script/main/GitHub-Ready/Tower-AutoFarm.lua"))()

-- DEPOIS:
loadstring(game:HttpGet("https://raw.githubusercontent.com/MOTTA063/World-Zero-Script/main/Tower-AutoFarm.lua"))()
```

3. **Dungeon-AutoFarm.lua** (linha 7):
```lua
-- ANTES:
loadstring(game:HttpGet("https://raw.githubusercontent.com/SEU-USUARIO/World-Zero-Script/main/GitHub-Ready/Dungeon-AutoFarm.lua"))()

-- DEPOIS:
loadstring(game:HttpGet("https://raw.githubusercontent.com/MOTTA063/World-Zero-Script/main/Dungeon-AutoFarm.lua"))()
```

4. **loadstrings.md** (múltiplas linhas):
- Substitua todas as ocorrências de `SEU-USUARIO` por `MOTTA063`

5. **README.md** (múltiplas linhas):
- Substitua todas as ocorrências de `SEU-USUARIO` por `MOTTA063`

---

## 🧪 **Testar os Loadstrings**

### ✅ **Verificação de Funcionamento:**

1. **Aguarde** alguns minutos após o upload
2. **Teste** cada loadstring em um executor
3. **Verifique** se não há erros 404
4. **Confirme** se os scripts executam corretamente

### 🔧 **Se não funcionar:**

1. **Verifique** se o repositório é público
2. **Confirme** os nomes dos arquivos (sem espaços)
3. **Aguarde** até 10 minutos para atualizar
4. **Teste** a URL diretamente no navegador

---

## 📚 **URLs de Exemplo**

**Se seu usuário for `MOTTA063`:**

### 🌐 **URLs Raw (para loadstring):**
- Private: `https://raw.githubusercontent.com/MOTTA063/World-Zero-Script/main/Private-AutoFarm.lua`
- Tower: `https://raw.githubusercontent.com/MOTTA063/World-Zero-Script/main/Tower-AutoFarm.lua`
- Dungeon: `https://raw.githubusercontent.com/MOTTA063/World-Zero-Script/main/Dungeon-AutoFarm.lua`

### 📖 **URLs do Repositório:**
- Repo: `https://github.com/MOTTA063/World-Zero-Script`
- README: `https://github.com/MOTTA063/World-Zero-Script/blob/main/README.md`

---

## 🎯 **Dicas Importantes**

### ✅ **Para Funcionamento Correto:**

1. **📂 Nomes de arquivo** devem ser exatos (sem espaços)
2. **🌐 Repositório** deve ser público
3. **📝 URLs** devem usar `raw.githubusercontent.com`
4. **⏰ Aguarde** alguns minutos após upload/alterações

### 🔄 **Para Atualizações:**

1. **Edite** o arquivo no GitHub
2. **Commit** as mudanças
3. **Aguarde** atualizar (1-5 minutos)
4. **Teste** o loadstring novamente

### 📈 **Para Melhor Organização:**

1. **📋 Use releases** para versões estáveis
2. **🏷️ Tags** para controle de versão
3. **📝 Changelog** para documentar mudanças
4. **⭐ Star** seu próprio repo para facilitar acesso

---

## 🚀 **Pronto para Usar!**

Depois de seguir todos os passos, seus scripts estarão disponíveis via loadstring e prontos para serem compartilhados!

**🌟 Exemplo final de uso:**
```lua
-- Copie, cole e execute no seu executor:
loadstring(game:HttpGet("https://raw.githubusercontent.com/MOTTA063/World-Zero-Script/main/Private-AutoFarm.lua"))()
```

---

## 📞 **Suporte**

Se tiver problemas com o setup:
1. **🔍 Verifique** todas as URLs
2. **⏰ Aguarde** alguns minutos
3. **🔄 Teste** em navegador privado
4. **📋 Compare** com este guia

**✅ Sucesso: Script carrega e executa normalmente!**
