# Definição do MVP
**Ecossistema Farmácia Americana — App Flutter/Dart**

---

# 1. Definição do MVP

O MVP do ecossistema Farmácia Americana cobre o ciclo operacional principal de atendimento digital da farmácia: desde o primeiro contato do cliente pelo app até a conclusão da venda com controle financeiro e rastreamento de entrega. O maior foco está no fluxo de atendimento e venda, pois sem ele o app não tem razão de existir. A IA e o chat híbrido são o diferencial competitivo e, portanto, integram o MVP — mas apenas nas funcionalidades essenciais para o atendimento funcionar de forma segura e auditável.

**Dentro do MVP:**
- Cadastro e autenticação de clientes e colaboradores (com perfis e permissões por função)
- Atendimento via chat com IA para consulta de produtos e início de pedido
- Transbordo automático e manual para atendente humano
- Catálogo de produtos com navegação por categoria e busca por texto
- Upload de receita médica no chat e validação manual pelo Farmacêutico
- Checkout com pagamento via PIX remoto (expiração de 10 minutos) e pagamento presencial na entrega
- Controle de estoque com bloqueio automático de checkout por saldo insuficiente
- Rastreamento de status do pedido em tempo real com notificações push
- Persistência de dados de auditoria de vendas com medicamentos controlados
- Painel do atendente com fila de conversas e histórico do cliente
- Relatórios básicos de vendas por período e estoque por unidade
- Gestão de acesso por perfil (Atendente, Farmacêutico, Gerente, Dono e Administrador)

**Fora do MVP:**
- OCR automático de receitas (análise de IA sobre imagens — entra como melhoria futura)
- Configuração avançada de parâmetros e base de conhecimento da IA pelo Administrador
- Dashboards de Business Intelligence com gráficos e indicadores avançados de performance da IA
- Personalização ativa com sugestões baseadas no histórico de compras (IA preditiva)
- Lembretes automáticos de reposição de medicamentos de uso contínuo
- Análise multimodal avançada de documentos médicos
- Módulo de auditoria de logs técnicos da IA com consulta por Farmacêutico

**Justificativa:**

O foco foi garantir que o ciclo básico do negócio funcionasse de forma digital: o cliente é atendido pelo app, consegue comprar, pagar e acompanhar a entrega. O atendente e o farmacêutico têm as ferramentas mínimas para operar com segurança e dentro das obrigações regulatórias. A IA entra no MVP como motor do atendimento inicial, pois sem ela o app vira apenas um catálogo — e esse não é o diferencial do produto. O que ficou de fora não trava a operação e pode entrar em versões seguintes, quando já houver dados reais de uso para embasar as decisões. Essa delimitação permite entregar algo funcional, testável e validável com clientes reais mais rápido.

---

# 2. Regras de Negócio

**RN01 — Transbordo automático para humano após falha da IA**
Se a IA não identificar a intenção do usuário ou o produto desejado após 2 (duas) tentativas consecutivas, a conversa deve ser movida automaticamente para a fila de atendimento humano com prioridade alta. O cliente deve ser informado da transferência diretamente no chat.

**RN02 — Registro obrigatório de orientações técnicas da IA**
Toda orientação técnica fornecida pela IA — posologia, efeitos colaterais ou esclarecimentos sobre bula — deve ser salva em log inalterável, vinculado ao ID da conversa, para fins de auditoria regulatória.

**RN03 — Trava de medicamento controlado no checkout**
Produtos classificados como medicamentos controlados (Tarja Preta/Vermelha) bloqueiam o checkout até que o Farmacêutico realize a validação digital da imagem de receita enviada pelo cliente. A aprovação deve ser registrada junto ao CRM do farmacêutico responsável.

**RN04 — Persistência completa de dados da venda com receita**
Para cada venda que envolva receita médica, o sistema deve obrigatoriamente registrar: identificação do(s) produto(s), CPF do comprador, data e hora exata da venda, imagem da receita médica, CRM do farmacêutico validador, CRM e UF do médico prescritor, e log completo do chat da venda.

**RN05 — Bloqueio de checkout por estoque insuficiente**
O sistema não deve permitir a inclusão de itens no carrinho nem a finalização da compra se a quantidade solicitada for maior que o saldo em estoque físico da unidade responsável pelo atendimento.

**RN06 — Expiração automática da chave PIX**
As chaves PIX dinâmicas geradas para pagamento remoto devem expirar em exatamente 10 minutos. Após este prazo, o pedido é cancelado automaticamente e os itens retornam ao saldo de estoque disponível.

**RN07 — Baixa de pagamento presencial pelo entregador**
Pagamentos em espécie ou cartão na entrega dependem obrigatoriamente do registro manual de confirmação pelo entregador via app para que o fluxo do pedido seja concluído.

**RN08 — Imutabilidade do preço de venda**
O sistema deve registrar e manter o preço praticado no momento exato da finalização da venda. Alterações posteriores no cadastro de produtos não afetam pedidos já concluídos.

**RN09 — Notificação automática de status do pedido**
O sistema deve disparar notificações push ao cliente a cada mudança de estado do pedido: Pagamento Aprovado, Em Separação, Saiu para Entrega e Entregue.

**RN10 — Restrição de entrega por raio configurável**
O sistema só deve permitir a finalização de pedidos para endereços dentro do raio de entrega (em quilômetros) configurado para a unidade da farmácia responsável pelo atendimento.

**RN11 — Hierarquia de acesso por perfil (RBAC)**
Cada funcionalidade do sistema é acessível apenas pelo perfil autorizado. O Dono visualiza faturamento e indicadores de todas as unidades; o Gerente acessa apenas sua unidade; os demais perfis têm acesso restrito às suas funções operacionais, sem acesso a dados financeiros globais.

---

# 3. Requisitos Funcionais

**RF01 — Cadastro e autenticação de usuários**
O sistema deve permitir que clientes se cadastrem com CPF, e-mail e senha, e que colaboradores sejam autenticados com credenciais próprias. O token de sessão deve expirar em 24 horas para clientes e 8 horas para colaboradores.

**RF02 — Catálogo de produtos com busca e navegação**
O sistema deve exibir produtos com fotos, descrições e preços, permitindo navegação por categorias e busca por texto (nome do produto ou fabricante). Produtos sem estoque devem ser sinalizados como indisponíveis.

**RF03 — Atendimento via chat com IA**
O sistema deve prover uma interface de chat nativa onde o cliente interage com a IA para tirar dúvidas, consultar posologia e selecionar produtos, com tempo de resposta máximo de 5 segundos.

**RF04 — Transbordo de atendimento para humano**
O sistema deve mover automaticamente a conversa para a fila de atendimento humano após 2 tentativas sem reconhecimento de intenção, e permitir também a solicitação manual pelo cliente a qualquer momento.

**RF05 — Seleção de produtos via chat**
O sistema deve permitir que o cliente adicione produtos ao carrinho diretamente pela interface de conversa, sem necessidade de navegar pelo catálogo de forma independente.

**RF06 — Upload de receita médica no chat**
O sistema deve permitir o envio de fotos de receitas médicas diretamente no chat. As imagens devem ser armazenadas em bucket privado e acessíveis apenas via URLs temporárias assinadas.

**RF07 — Validação de receita pelo Farmacêutico**
O sistema deve fornecer tela para o farmacêutico visualizar a imagem da receita e o contexto da compra, permitindo aprovar (liberar checkout) ou reprovar (com nota obrigatória enviada ao cliente no chat).

**RF08 — Checkout com pagamento via PIX**
O sistema deve gerar chaves PIX dinâmicas com expiração de 10 minutos e confirmar o pagamento automaticamente via webhook bancário.

**RF09 — Checkout com pagamento presencial**
O sistema deve permitir que o cliente opte pelo pagamento em dinheiro ou cartão no ato da entrega, registrando a baixa pelo entregador via app.

**RF10 — Rastreamento de pedido em tempo real**
O sistema deve exibir o status atual do pedido e o histórico de atualizações, com latência máxima de 30 segundos para refletir mudanças de estado.

**RF11 — Notificações push de status**
O sistema deve disparar alertas automáticos ao cliente a cada mudança de estado do pedido, redirecionando para a tela correspondente ao toque na notificação.

**RF12 — Painel de fila de atendimento**
O sistema deve listar os chats ativos no painel do atendente com filtros por data e status (IA ou Humano), permitindo que o atendente assuma conversas da fila.

**RF13 — Consulta de histórico do cliente**
O sistema deve permitir a busca de clientes por CPF, e-mail ou nome para acesso ao histórico completo de compras e logs de conversas anteriores.

**RF14 — Gestão de estoque e catálogo por unidade**
O sistema deve permitir a edição de preços, descrições e atualização de saldo de estoque por produto e por unidade, com reflexo no app do cliente em até 30 segundos.

**RF15 — Configuração do raio de entrega por unidade**
O sistema deve permitir a definição do raio máximo de entrega (em quilômetros) por unidade física da farmácia.

**RF16 — Controle de acessos por perfil (RBAC)**
O sistema deve permitir ao Administrador criar, editar, suspender e revogar perfis de colaboradores, com invalidação imediata de sessões ativas após alterações de permissão.

**RF17 — Persistência de dados de auditoria**
O sistema deve registrar de forma imutável, para cada venda com receita: log do chat, imagem da receita, CRM do farmacêutico validador, CRM/UF do médico e CPF do comprador.

**RF18 — Relatórios básicos de indicadores**
O sistema deve permitir a geração de relatórios de faturamento por período e unidade, lista de produtos mais vendidos e saldo de estoque por unidade.

---

# 4. Requisitos Não Funcionais

**RNF01 — Performance de interface**
O aplicativo deve manter 60 FPS estáveis em dispositivos homologados, garantindo transições fluidas e ausência de travamentos nas telas de catálogo, chat e checkout.

**RNF02 — Tempo de resposta da IA**
O processamento e retorno da resposta da IA no chat não devem exceder 5 segundos em condições normais de operação.

**RNF03 — Latência de sincronização**
Atualizações críticas feitas no painel administrativo (preço, estoque) devem ser refletidas no app do cliente em no máximo 30 segundos.

**RNF04 — Segurança de dados em trânsito**
Toda comunicação entre o app Flutter e as APIs deve ser realizada via HTTPS com TLS 1.3. A autenticação deve ser baseada em JWT com expiração diferenciada por perfil.

**RNF05 — Proteção de dados sensíveis (LGPD)**
Dados como CPF, histórico de saúde e imagens de receitas devem ser armazenados com criptografia em repouso (AES-256). Imagens de receitas devem ficar em buckets privados com acesso apenas via URLs temporárias assinadas.

**RNF06 — Responsividade multiplataforma**
A interface deve ser adaptável para telas de 4 a 12,9 polegadas, seguindo os padrões do Material Design 3 com paridade visual entre Android e iOS.

**RNF07 — Disponibilidade**
O ecossistema (App, Web e APIs) deve garantir uptime mínimo de 99,5% ao mês.

**RNF08 — Persistência offline de mensagens**
Em caso de perda temporária de conexão, o app deve enfileirar mensagens localmente e sincronizá-las automaticamente ao restabelecer a conexão, sem ação do usuário.

**RNF09 — Usabilidade do painel administrativo**
O painel deve ser projetado para que o farmacêutico conclua a validação de uma receita em no máximo 4 cliques após o recebimento da imagem.

**RNF10 — Arquitetura de microserviços**
O backend deve ser modularizado para permitir atualizações independentes nos módulos de IA, pagamento, catálogo e autenticação sem impacto entre eles.

**RNF11 — Padrão arquitetural (MVVM)**
O desenvolvimento Flutter deve seguir o padrão MVVM, garantindo separação clara entre lógica de negócio, estados de UI e modelos de dados.

---

# 5. Casos de Uso do MVP

## Cobertura do MVP

| UC | Nome | Domínio | RFs | RNs |
|---|---|---|---|---|
| UC01 | Autenticar Usuário | Acesso | RF01 | RN11 |
| UC02 | Cadastrar e Identificar Cliente | Acesso | RF01 | — |
| UC03 | Navegar no Catálogo e Consultar Produto | Operação | RF02 | — |
| UC04 | Realizar Atendimento via Chat com IA | Atendimento | RF03, RF05 | RN01, RN02 |
| UC05 | Realizar Transbordo de Atendimento | Atendimento | RF04, RF12 | RN01 |
| UC06 | Realizar Venda | Operação | RF05 | RN05 |
| UC07 | Fazer Upload e Validar Receita Médica | Regulatório | RF06, RF07 | RN03, RN04 |
| UC08 | Processar Pagamento | Financeiro | RF08, RF09 | RN06, RN07, RN08 |
| UC09 | Rastrear Pedido e Receber Notificações | Logística | RF10, RF11 | RN09, RN10 |
| UC10 | Gerenciar Estoque e Catálogo | Operação | RF14 | RN05 |
| UC11 | Gerenciar Acessos e Perfis | Acesso | RF16 | RN11 |
| UC12 | Persistir Dados de Auditoria | Regulatório | RF17 | RN02, RN03, RN04 |
| UC13 | Gerar Relatórios de Indicadores | Gestão | RF18 | RN11 |

---

# 6. Documentação dos Casos de Uso

## UC01 — Autenticar Usuário

**Ator(es):** Cliente, Atendente, Farmacêutico, Gerente, Dono, Administrador

**Descrição:** Autentica o usuário no sistema e o direciona para a interface correspondente ao seu perfil de acesso.

**Pré-condições:**
- Usuário com cadastro ativo no sistema

**Pós-condições:**
- Token JWT emitido e sessão iniciada
- Usuário redirecionado para a tela inicial do seu perfil

### Fluxo Principal
1. Usuário informa CPF (ou e-mail) e senha na tela de login
2. Sistema valida as credenciais
3. Sistema emite token JWT (24h para clientes; 8h para colaboradores)
4. Sistema redireciona o usuário para a tela inicial do seu perfil

### Fluxos Alternativos / Exceções
- FA01 — Credenciais inválidas: sistema exibe mensagem de erro sem indicar qual campo está incorreto e aguarda nova tentativa
- FA02 — Token expirado: sistema redireciona para a tela de login e descarta o estado da sessão anterior

### Relacionamentos
- **Include:** Nenhum
- **Extend:** Nenhum

---

## UC02 — Cadastrar e Identificar Cliente

**Ator(es):** Cliente, Atendente

**Descrição:** Registra um novo cliente no sistema ou localiza um cliente já existente para vinculá-lo a um atendimento ou venda em andamento.

**Pré-condições:**
- Nenhuma (cadastro pode ocorrer de forma independente ou durante uma venda)

**Pós-condições:**
- Cliente registrado no sistema e vinculado ao atendimento

### Fluxo Principal
1. Sistema solicita CPF do cliente
2. Usuário informa o CPF
3. Sistema localiza o cadastro existente e exibe os dados (nome, telefone, endereço)
4. Cliente é vinculado ao atendimento ou venda em andamento

### Fluxos Alternativos / Exceções
- FA01 — CPF inválido: sistema identifica erro no dígito verificador e solicita nova entrada
- FA02 — Cliente não encontrado: sistema abre formulário de cadastro com campos obrigatórios (nome, e-mail, telefone)

### Relacionamentos
- **Include:** É incluído por UC06 — Realizar Venda
- **Extend:** Nenhum

---

## UC03 — Navegar no Catálogo e Consultar Produto

**Ator(es):** Cliente

**Descrição:** Permite ao cliente navegar pelo catálogo de produtos, filtrar por categorias, buscar por texto e consultar os detalhes de um produto de forma independente do fluxo de venda.

**Pré-condições:**
- Usuário autenticado (UC01)
- Catálogo com produtos cadastrados

**Pós-condições:**
- Produto consultado; cliente pode iniciar uma compra a partir do catálogo

### Fluxo Principal
1. Cliente acessa a tela inicial do app com o catálogo
2. Sistema exibe produtos organizados por categorias com foto, nome e preço
3. Cliente navega por categorias ou realiza busca por texto
4. Sistema retorna os resultados filtrando em tempo real (60 FPS)
5. Cliente seleciona um produto para visualizar o detalhe completo
6. Sistema exibe foto ampliada, descrição, preço e disponibilidade em estoque
7. Cliente pode iniciar a compra pelo botão "Comprar via Chat"

### Fluxos Alternativos / Exceções
- FA01 — Nenhum produto encontrado: sistema exibe mensagem informativa e sugere categorias relacionadas
- FA02 — Produto sem estoque: sistema exibe indicação visual de "Indisponível" e oculta o botão de compra

### Relacionamentos
- **Include:** Nenhum
- **Extend:** Pode iniciar UC06 — Realizar Venda (via botão "Comprar via Chat")

---

## UC04 — Realizar Atendimento via Chat com IA

**Ator(es):** Cliente, IA Americana

**Descrição:** O cliente interage com a IA pelo chat para tirar dúvidas sobre produtos, consultar posologia e selecionar itens para compra.

**Pré-condições:**
- Usuário autenticado (UC01)

**Pós-condições:**
- Dúvida resolvida ou pedido iniciado; orientações técnicas salvas em log inalterável (RN02)

### Fluxo Principal
1. Cliente abre o chat e digita sua mensagem
2. Sistema processa a intenção via IA (tempo máximo: 5 segundos)
3. IA responde à dúvida ou exibe o produto identificado com confirmação de adição ao carrinho
4. Orientações técnicas fornecidas são salvas automaticamente em log vinculado ao ID da conversa

### Fluxos Alternativos / Exceções
- FA01 — Intenção não reconhecida na 1ª tentativa: IA reformula a pergunta e solicita nova mensagem do cliente
- FA02 — Intenção não reconhecida na 2ª tentativa consecutiva: sistema aciona UC05 — Transbordo de Atendimento

### Relacionamentos
- **Include:** Nenhum
- **Extend:** UC05 — Transbordo de Atendimento (após 2 falhas consecutivas)

---

## UC05 — Realizar Transbordo de Atendimento

**Ator(es):** Cliente, Atendente, Sistema

**Descrição:** Move a conversa da IA para um atendente humano, seja de forma automática por falha de reconhecimento, seja por solicitação explícita do cliente.

**Pré-condições:**
- Conversa em andamento no chat

**Pós-condições:**
- Conversa movida para a fila de atendimento humano com histórico completo preservado

### Fluxo Principal
1. Sistema ou cliente aciona o transbordo
2. Sistema move a conversa para a fila de "Atendimento Humano" com prioridade correspondente (alta para automático; padrão para manual)
3. Cliente recebe mensagem de confirmação no chat
4. Atendente visualiza a conversa no painel com histórico completo e assume o atendimento

### Fluxos Alternativos / Exceções
- FA01 — Nenhum atendente disponível: sistema informa o cliente e mantém a conversa na fila com indicação de espera

### Relacionamentos
- **Include:** Nenhum
- **Extend:** Estende UC04 — Atendimento via Chat com IA

---

## UC06 — Realizar Venda

**Ator(es):** Cliente, Atendente, IA Americana

**Descrição:** Registra a venda de produtos a um cliente, verificando estoque, aplicando as regras de medicamentos controlados, processando pagamento e concluindo o pedido.

**Pré-condições:**
- Usuário autenticado (UC01)
- Produtos com estoque disponível

**Pós-condições:**
- Venda registrada no sistema
- Estoque atualizado
- Fluxo de pagamento iniciado (UC08)

### Fluxo Principal
1. Cliente ou atendente inicia uma nova venda (via chat ou painel)
2. Sistema solicita identificação do cliente *(inclui UC02)*
3. Produto é adicionado ao carrinho (via chat ou catálogo)
4. Sistema verifica saldo em estoque em tempo real
5. Sistema identifica se há medicamento controlado *(estende UC07)*
6. Atendente ou cliente seleciona a forma de pagamento *(inclui UC08)*
7. Sistema finaliza a venda, atualiza o estoque e persiste os dados de auditoria *(inclui UC12)*

### Fluxos Alternativos / Exceções
- FA01 — Estoque insuficiente: sistema bloqueia o item, informa o saldo disponível e aguarda nova quantidade ou remoção (RN05)
- FA02 — Pagamento PIX expirado: pedido cancelado automaticamente e estoque liberado após 10 minutos (RN06)

### Relacionamentos
- **Include:** UC02 — Cadastrar e Identificar Cliente; UC08 — Processar Pagamento; UC12 — Persistir Dados de Auditoria
- **Extend:** UC07 — Fazer Upload e Validar Receita Médica (quando houver medicamento controlado)

---

## UC07 — Fazer Upload e Validar Receita Médica

**Ator(es):** Cliente, Farmacêutico

**Descrição:** Gerencia o envio da receita médica pelo cliente e a validação pelo farmacêutico, bloqueando o checkout de medicamentos controlados até a aprovação.

**Pré-condições:**
- Venda em andamento com produto de controle especial
- Farmacêutico autenticado com perfil correspondente

**Pós-condições:**
- Receita aprovada e venda liberada, ou venda bloqueada com nota de reprovação enviada ao cliente

### Fluxo Principal
1. Sistema identifica medicamento controlado na venda e solicita receita ao cliente
2. Cliente envia a foto da receita pelo chat
3. Sistema armazena a imagem em bucket privado (URL temporária assinada)
4. Farmacêutico visualiza a imagem e o contexto da compra no painel
5. Farmacêutico aprova a receita — sistema libera o checkout e registra o CRM do validador
6. Sistema conclui a persistência dos dados regulatórios da venda (RN04)

### Fluxos Alternativos / Exceções
- FA01 — Receita reprovada: farmacêutico insere nota obrigatória; sistema envia a nota ao cliente via chat e bloqueia o item
- FA02 — Receita ilegível: farmacêutico solicita novo envio ao cliente via chat

### Relacionamentos
- **Include:** UC12 — Persistir Dados de Auditoria
- **Extend:** Estende UC06 — Realizar Venda

---

## UC08 — Processar Pagamento

**Ator(es):** Cliente, Entregador, Sistema

**Descrição:** Gerencia o processo de pagamento da venda, suportando PIX remoto com confirmação automática e pagamento presencial com baixa manual pelo entregador.

**Pré-condições:**
- Venda finalizada (UC06)
- Forma de pagamento selecionada pelo cliente

**Pós-condições:**
- Pagamento confirmado e pedido avançado para "Em Separação"

### Fluxo Principal — PIX
1. Sistema gera chave PIX dinâmica e exibe QR Code com contador de 10 minutos
2. Cliente realiza o pagamento pelo app do banco
3. Sistema recebe confirmação via Webhook bancário
4. Pedido avança automaticamente para o próximo estado (RN09)

### Fluxo Principal — Presencial
1. Cliente seleciona pagamento em dinheiro ou cartão na entrega
2. Pedido é confirmado sem pagamento antecipado
3. Entregador registra a baixa do pagamento via app após a entrega (RN07)

### Fluxos Alternativos / Exceções
- FA01 — PIX expirado: sistema cancela o pedido automaticamente e retorna os itens ao estoque (RN06)
- FA02 — Falha no Webhook: sistema aguarda reprocessamento automático e notifica o administrador em caso de falha persistente

### Relacionamentos
- **Include:** É incluído por UC06 — Realizar Venda
- **Extend:** Nenhum

---

## UC09 — Rastrear Pedido e Receber Notificações

**Ator(es):** Cliente, Sistema

**Descrição:** Permite ao cliente acompanhar o status do pedido em tempo real e receber notificações push a cada mudança de estado.

**Pré-condições:**
- Pedido criado com pagamento confirmado
- Permissão de notificação push concedida pelo dispositivo do cliente

**Pós-condições:**
- Cliente informado sobre o estado atual do pedido

### Fluxo Principal
1. Sistema detecta mudança de estado do pedido (aprovado, separação, entrega, entregue)
2. Sistema atualiza o status na tela do pedido (latência máxima de 30 segundos)
3. Sistema dispara notificação push para o dispositivo do cliente
4. Cliente toca na notificação e o app redireciona para a tela de rastreamento

### Fluxos Alternativos / Exceções
- FA01 — Permissão de push negada: atualizações ficam visíveis apenas na central interna de notificações do app
- FA02 — App fechado: app inicializa, realiza autenticação e redireciona para a tela correspondente ao evento

### Relacionamentos
- **Include:** Nenhum
- **Extend:** Nenhum

---

## UC10 — Gerenciar Estoque e Catálogo

**Ator(es):** Atendente, Gerente, Administrador

**Descrição:** Permite que usuários autorizados editem informações de produtos (preço, descrição, foto) e atualizem o saldo de estoque por unidade, com reflexo imediato no app do cliente.

**Pré-condições:**
- Usuário autenticado com perfil Atendente ou superior
- Produto cadastrado no sistema

**Pós-condições:**
- Produto atualizado; saldo de estoque refletido no app do cliente em até 30 segundos

### Fluxo Principal
1. Usuário acessa o módulo de catálogo/estoque no painel administrativo
2. Pesquisa o produto por nome ou código
3. Edita os campos desejados (preço, descrição, foto ou saldo de estoque)
4. Sistema salva as alterações e sincroniza com o app do cliente

### Fluxos Alternativos / Exceções
- FA01 — Alteração de preço: sistema aplica o novo preço apenas para vendas futuras, preservando o valor registrado em pedidos já concluídos (RN08)
- FA02 — Saldo zerado: sistema sinaliza o produto como indisponível no catálogo automaticamente

### Relacionamentos
- **Include:** Nenhum
- **Extend:** Nenhum

---

## UC11 — Gerenciar Acessos e Perfis (RBAC)

**Ator(es):** Administrador

**Descrição:** Permite ao Administrador criar, editar, suspender e revogar perfis de colaboradores, controlando as permissões de acesso conforme a hierarquia RBAC do sistema.

**Pré-condições:**
- Usuário autenticado com perfil Administrador

**Pós-condições:**
- Permissões do colaborador atualizadas e aplicadas na próxima sessão (ou imediatamente, em caso de suspensão)

### Fluxo Principal
1. Administrador acessa o módulo de controle de acessos
2. Sistema lista colaboradores com nome, perfil e status (ativo/suspenso)
3. Administrador cria um novo usuário ou edita um existente
4. Define ou altera o perfil: Atendente, Farmacêutico, Gerente ou Dono
5. Sistema salva a configuração e invalida o token ativo do colaborador, forçando novo login

### Fluxos Alternativos / Exceções
- FA01 — Suspender colaborador: sistema invalida a sessão ativa imediatamente
- FA02 — Tentativa de auto-edição: sistema bloqueia a operação para evitar bloqueio acidental do próprio Administrador

### Relacionamentos
- **Include:** UC01 — Autenticar Usuário (pré-condição)
- **Extend:** Controla o acesso a UC10, UC12 e UC13

---

## UC12 — Persistir Dados de Auditoria

**Ator(es):** Sistema (automático)

**Descrição:** Registra de forma imutável todos os dados regulatórios e operacionais de cada venda que envolva receita médica ou orientação técnica da IA.

**Pré-condições:**
- Venda concluída com medicamento controlado ou orientação técnica fornecida pela IA

**Pós-condições:**
- Registro imutável criado no banco de dados com todos os dados exigidos por RN04

### Fluxo Principal
1. Sistema detecta o encerramento de uma venda com receita ou orientação técnica
2. Consolida os dados: ID do produto, CPF do comprador, data/hora, imagem da receita, CRM do farmacêutico, CRM/UF do médico e log completo do chat
3. Persiste o registro com flag de imutabilidade
4. Registro disponível para consulta por perfis autorizados (Farmacêutico, Gerente, Dono)

### Fluxos Alternativos / Exceções
- FA01 — Falha na persistência: sistema registra o erro, notifica o Administrador e mantém os dados em fila para nova tentativa

### Relacionamentos
- **Include:** É incluído por UC06 — Realizar Venda e UC07 — Validar Receita Médica
- **Extend:** Nenhum

---

## UC13 — Gerar Relatórios de Indicadores

**Ator(es):** Gerente, Dono, Administrador

**Descrição:** Permite que gestores consultem relatórios básicos de performance operacional da unidade, como faturamento por período e produtos mais vendidos.

**Pré-condições:**
- Usuário autenticado com perfil Gerente, Dono ou Administrador
- Dados de vendas e estoque registrados no sistema

**Pós-condições:**
- Relatório gerado e exibido conforme os filtros aplicados e as permissões do perfil

### Fluxo Principal
1. Usuário acessa o módulo de relatórios
2. Seleciona o tipo: faturamento por período, produtos mais vendidos ou saldo de estoque por unidade
3. Define os filtros (período e unidade)
4. Sistema processa e exibe o relatório respeitando a hierarquia RBAC (Gerente vê apenas sua unidade; Dono vê todas)

### Fluxos Alternativos / Exceções
- FA01 — Sem dados no período informado: sistema exibe mensagem informativa e sugere ajuste nos filtros
- FA02 — Período inválido (data final anterior à inicial): sistema bloqueia a geração e solicita correção

### Relacionamentos
- **Include:** Nenhum
- **Extend:** Nenhum

---

> **Diretriz de Implementação:** Todas as regras de negócio devem ser validadas na camada de interface (Flutter) para melhor experiência do usuário e na camada de serviços (Backend) para garantir a integridade dos dados, conforme orientação dos documentos de RN e RNF do projeto.
