# Gerenciamento de Ordens de Serviço

Sistema desktop para controle de Ordens de Serviço (OS): cadastro de clientes, OS com itens e foto, controle de situação com prazo (SLA), totalizadores, relatório agrupado por situação com exportação e histórico de alterações de situação.

Desenvolvido como prova técnica para Desenvolvedor Delphi (2026).

---

## Stack

| Item | Versão / detalhe |
|---|---|
| IDE | Delphi 10.3 Rio **Update 3** (26.0.36039.7899), VCL, Win32 |
| Banco | Firebird **2.5** |
| Acesso a dados | FireDAC (driver FB) |
| Relatórios | FastReport VCL Embarcadero Edition |
| Modelagem do banco | IBExpert |

> Para compilar é necessário o Delphi 10.3 **Update 3**: o instalador do FastReport Embarcadero Edition disponível no site da Fast Reports exige essa atualização (no 10.3 original os pacotes não carregam). O executável pronto em `bin\` não depende do Delphi.

---

## Estrutura do repositório

```
ProjetoOS.dpr / .dproj      Projeto
uDM.pas / .dfm              DataModule (conexão, queries de listagem, relatório)
uModel.Classes.pas          Entidades, regras do objeto (validação, total, atraso) e constantes de situação
uLog.pas                    Gravação do arquivo de log
Services\                   Regras de negócio e persistência (OS, Cliente, Imagem)
Views\                      Telas
Reports\RelatorioOS.fr3     Layout do relatório (cópia do que está embutido no uDM)
Database\criacao_banco.sql  Script de criação do banco
Database\dados_teste.sql    Massa de teste (opcional)
Database\ORDENS_DEMO.FDB    Banco pronto com a massa de teste (Firebird 2.5)
bin\ProjetoOS.exe           Executável
```

---

## Configurar o banco e a conexão

### Opção 1 – criar pelo script (recomendado)

1. Abra `Database\criacao_banco.sql` e ajuste o caminho do `CREATE DATABASE` (padrão: `C:\ProjetoOS\Database\ORDENS.FDB`). A pasta precisa existir.
2. Execute o script (IBExpert, FlameRobin ou `isql`). O script já define `SET NAMES UTF8`.
3. (Opcional) Execute `Database\dados_teste.sql` no banco criado para ter dados de exemplo: 18 clientes e 100 OS em todas as situações, várias atrasadas e 7 sem data prevista.

### Opção 2 – banco pronto

Use `Database\ORDENS_DEMO.FDB`, que já tem a estrutura e a massa de teste. Ele foi criado no **Firebird 2.5**; em versões 3.0 ou superiores use a opção 1.

### Conexão

Não há caminho de banco fixo no código. Na **primeira execução** o sistema abre a tela *Configuração do Banco de Dados*:

1. Selecione o arquivo `.FDB`.
2. Informe usuário e senha (padrão do Firebird: `SYSDBA` / `masterkey`).
3. Clique em **Testar Conexão** e depois em **Salvar**.

A configuração é gravada em `config.ini`, ao lado do executável:

```ini
[BANCO]
Caminho=C:\ProjetoOS\Database\ORDENS.FDB
Username=SYSDBA
Senha=masterkey
```

Parâmetros usados pelo FireDAC (equivalente à connection string):

```
DriverID=FB
Database=<caminho do .FDB>
User_Name=SYSDBA
Password=masterkey
CharacterSet=UTF8
```

Para trocar de banco, apague ou edite o `config.ini`. Se o arquivo apontar para um banco que não existe, a tela de configuração abre novamente.

---

## Executar

1. Configure o banco (seção anterior).
2. Execute `bin\ProjetoOS.exe` e informe o banco na primeira abertura.

Para compilar: abra `ProjetoOS.dproj` no Delphi 10.3.3 com o FastReport instalado e faça **Project → Build**.

---

## Funcionalidades

- **Clientes**: incluir, alterar, excluir e listar. CPF com máscara e validação de preenchimento completo. Cliente com OS não pode ser excluído (o banco impede).
- **Ordens de Serviço**: incluir, alterar, excluir e listar, com itens na mesma tela e valor total recalculado automaticamente. Foto da OS opcional.
- **Situações**: Aberta → Em Andamento → Concluída / Cancelada, alteradas em tela própria com regras de transição. Só OS Aberta pode ser excluída; para encerrar uma OS em andamento, cancela-se.
- **Filtros**: período de abertura, situação, parte do nome do cliente, faixa de valor, número da OS e limite de registros (`FIRST n`).
- **SLA / atraso**: OS com data prevista vencida e situação diferente de Concluída/Cancelada recebe o selo **ATRASADA** no cartão. Totalizadores no topo: Abertas, Em Andamento, Concluídas e Em Atraso.
- **Relatório (FastReport)**: filtros de período, cliente, faixa de valor e situação com **multi-seleção**; agrupado por situação com quantidade, soma de valores e quantidade em atraso por grupo; total geral; rodapé com data/hora de geração. Exportação para **PDF** e **CSV**.
- **Log**: erros de banco, erros não tratados e exclusões são gravados em `ProjetoOS.log`, ao lado do executável.

### Funcionalidade extra – (A) Histórico de situações

Toda troca de situação é registrada na tabela `STATUS_LOG` pela trigger `TRG_OS_AUDIT_STATUS`, com data/hora, situação anterior, situação nova e usuário simulado.

**Como testar:** selecione uma OS **Aberta**, altere para *Em Andamento* e depois para *Concluída* (botão Alterar Status). Com a OS selecionada, clique em **Histórico**: as duas alterações aparecem em ordem. As OS da massa de teste não têm histórico, porque foram inseridas já na situação final.

### Outros extras

- Listagem em cartões com cor por situação e rolagem pela roda do mouse.
- Foto da OS com miniatura gerada no cadastro: a listagem carrega só a miniatura, a foto original só é lida ao abrir a OS.
- Tela de configuração da conexão com teste antes de salvar.

---

## Decisões arquiteturais

- **Camadas**: `Views` (telas) · `uDM` (conexão e consultas de tela/relatório) · `uModel.Classes` (entidades e regras do próprio objeto) · `Services` (regras que envolvem o banco, persistência e transações, um serviço por entidade). Os serviços não mostram mensagens: validam e lançam exceção, e a tela decide o que exibir.
- **Transações explícitas** (`StartTransaction` / `Commit` / `Rollback`) em todas as gravações. A OS e seus itens são gravados na mesma transação; na alteração, os itens são apagados e reinseridos dentro dela.
- **Filtros em um único lugar**: `TOrdemServicoService.AplicarFiltro` monta o SQL a partir de um record `TFiltroOS` e é usado tanto pela listagem quanto pelo relatório. Todas as consultas são parametrizadas. A multi-seleção de situação gera `IN (:pStatus0, :pStatus1, ...)`.
- **VIEW `VW_OS_RESUMO`** (sugerida no enunciado): junta OS e cliente e calcula `EM_ATRASO`. Listagem e relatório leem da view. Em relação à sugestão, tem uma coluna a mais: `MINIATURA`, usada pelos cartões.
- **Atraso é condição, não situação**: a regra fica no modelo (`TOrdemServico.CalcularAtraso`), usada para pintar os cartões. Os totalizadores e o relatório calculam a mesma regra no SQL porque precisam contar todas as OS, não só as carregadas na tela.
- **Exclusão**: a aplicação decide *quais* OS podem ser excluídas (só Aberta) e o banco cuida da integridade: `ITEM_ORDEM` e `STATUS_LOG` têm `ON DELETE CASCADE`. Já `FK_OS_CLIENTE` **não** tem cascade, de propósito: o banco recusa excluir um cliente que possui OS e assim protege o histórico.
- **Auditoria por trigger**: qualquer UPDATE que mude a situação é registrado, venha da tela ou de um script, e o registro participa da mesma transação.
- **Exportação CSV gerada em código**: o exportador CSV do FastReport reproduz o layout desenhado, misturando as faixas de grupo e subtotais com os dados. O CSV é gerado a partir da mesma consulta do relatório, com cabeçalho, separador `;` e UTF-8 (abre direto no Excel em português). O PDF usa o exportador do FastReport.
- **Status como constantes** (`STATUS_ABERTA`, etc.) para evitar erro de digitação; o texto gravado é exatamente o do enunciado.
- **Índices**: além dos índices simples do enunciado, um índice composto `(STATUS, DATA_ABERTURA)`, as duas colunas mais combinadas no filtro.
- **IDs** por generator + trigger `BEFORE INSERT` (compatível com Firebird 2.5); os INSERTs usam `RETURNING ID`.

### Alterações em relação ao DDL do enunciado

- `ORDEM_SERVICO`: colunas `FOTO` e `MINIATURA` (BLOB).
- Tabela `STATUS_LOG` + trigger de auditoria (funcionalidade extra A).
- `FK_ITEM_ORDEM` e `FK_STATUSLOG_OS` com `ON DELETE CASCADE`.
- Índice composto `IDX_OS_STATUS_DATA`.
- IDs com generator + trigger em vez de `IDENTITY` (que só existe a partir do Firebird 3.0).

---

## Limitações conhecidas

- Sem paginação real: apenas limite configurável de registros (`FIRST n`).
- Situações fixas no código, não configuráveis.
- O histórico não registra a criação da OS (a trigger é `AFTER UPDATE`) e o usuário é sempre `SISTEMA`, pois não há login.
- A regra "só exclui OS Aberta" existe apenas na aplicação; um `DELETE` feito direto no banco apaga a OS com itens e histórico.
- A regra de atraso existe no Delphi e no SQL (view e totalizadores).
- CPF: valida só o preenchimento completo, não os dígitos verificadores.
- Busca por nome do cliente diferencia acentos ("joao" não encontra "João").
- Senha do banco gravada em texto puro no `config.ini`.
- Log sem rotação de arquivo.
- Grade de cartões com 7 colunas × 3 linhas, pensada para tela cheia em Full HD; em resoluções menores os cartões ficam mais baixos.
- Com a tabela de OS vazia, os totalizadores aparecem em branco em vez de 0.
- As datas da massa de teste são fixas (julho a outubro/2026); a quantidade de OS atrasadas depende da data em que for executada.

---

## Autoavaliação

- **O que levaria mais tempo se tivesse +20 horas?** Situações intermediárias ("Aguardando Peça", "Aguardando Aprovação do Cliente") com o SLA pausado enquanto a OS aguarda terceiros. As situações sairiam das constantes para uma tabela, com uma indicação de quais contam para o prazo.
- **Um gargalo potencial no design atual?** A listagem sem paginação real (apenas `FIRST n`). O carregamento das fotos já foi tratado com a coluna de miniatura.
- **Uma melhoria de testes?** Testes unitários (DUnitX) para as regras que não dependem de banco: `ValidarTrocaStatus`, `ValidarExclusao`, `RecalcularTotal`, `CalcularAtraso` e a validação de CPF.

---

## Declaração de uso de IA

Foi usada IA (Claude) durante o desenvolvimento, nas seguintes partes:

- **Revisão de código e diagnóstico de erros** ao longo de todo o projeto, com sugestões de correção que eu apliquei e testei.
- **Código base fornecido pela IA, revisado e adaptado por mim**: filtros multicritério e limite, destaque de atraso e rolagem dos cartões, totalizadores, filtro de situação com multi-seleção, exportação PDF/CSV, log em arquivo e tela de histórico.
- **Orientação conceitual**, com o código escrito por mim: CRUD de cliente e seu serviço, confirmação padronizada, edição e remoção de itens da OS.
- **Gerado pela IA**: o script de massa de teste (`dados_teste.sql`) e os ajustes finais do `criacao_banco.sql` (caminho genérico e índice composto, este sugerido a partir do enunciado).
- **Decisões minhas**: estrutura do banco e auditoria por trigger, divisão de responsabilidades na exclusão (regra no sistema, integridade no banco), atraso como característica da OS no modelo, layout dos cartões e do relatório, e a tela de configuração da conexão (reaproveitada de um projeto anterior meu).
