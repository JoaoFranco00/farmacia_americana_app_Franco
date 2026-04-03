# 📋 Backlog do Produto — Ecossistema Farmácia Americana

> Documento feito com base nos em: Visão do Produto, Requisitos Funcionais (RF), Requisitos Não Funcionais (RNF), Regras de Negócio (RN) e Casos de Uso (UC).

---

## Estrutura do Backlog

| Épico | Nome | Domínio |
|---|---|---|
| EP01 | Acesso e Identidade | Autenticação, perfis e RBAC |
| EP02 | Atendimento via Chat Híbrido | IA + Transbordo Humano |
| EP03 | Catálogo de Produtos | Navegação e consulta |
| EP04 | Receitas Médicas e Compliance Regulatório | Upload, OCR e validação farmacêutica |
| EP05 | Carrinho, Checkout e Pagamento | Compra e confirmação |
| EP06 | Logística e Rastreamento de Pedidos | Entrega e notificações |
| EP07 | Painel Administrativo e Gestão de Unidade | Estoque, catálogo e configurações |
| EP08 | Gestão de Acessos (RBAC) | Permissões e colaboradores |
| EP09 | Relatórios, BI e Auditoria | Indicadores e dashboards |
| EP10 | Configuração e Administração da IA | Parâmetros e base de conhecimento |

---

## EP01 — Acesso e Identidade

> Cobre o registro, autenticação e gestão de conta do cliente e dos colaboradores.
> **RFs:** RF01, RF10 | **RNFs:** RNF05, RNF07 | **UCs:** UC02, UC10, UC11

---

### US01.1 — Cadastro de novo cliente

**Como** cliente,
**quero** criar uma conta usando meu CPF, e-mail e senha,
**para que** eu possa acessar o app e realizar compras de forma segura.

**Critérios de Aceitação:**
- O sistema deve validar o dígito verificador do CPF antes de prosseguir.
- Campos obrigatórios: CPF, nome completo, e-mail, telefone e senha.
- O sistema deve exibir mensagem de erro clara para CPF já cadastrado.
- A senha deve ter no mínimo 8 caracteres.
- Ao finalizar, o cliente é redirecionado para a tela inicial autenticado.

**Regras de Negócio / RNFs:** RF01 | RNF05 (HTTPS/TLS 1.3) | RNF06 (CPF criptografado AES-256)

---

### US01.2 — Login de cliente

**Como** cliente cadastrado,
**quero** entrar no app com meu CPF/e-mail e senha,
**para que** eu acesse minhas informações e histórico de forma segura.

**Critérios de Aceitação:**
- O sistema deve aceitar CPF ou e-mail como identificador de login.
- Em caso de credenciais inválidas, exibir mensagem de erro sem indicar qual campo está errado (segurança).
- Após autenticação, o sistema deve emitir um JWT com expiração de 24 horas (cliente).
- Após expiração do token, o usuário deve ser redirecionado para a tela de login.

**Regras de Negócio / RNFs:** RF01 | RNF07 (JWT 24h para clientes)

---

### US01.3 — Login de colaborador (Atendente, Farmacêutico, Gerente, Dono)

**Como** colaborador da Farmácia Americana,
**quero** acessar o painel administrativo com minhas credenciais,
**para que** eu execute minhas funções operacionais com segurança.

**Critérios de Aceitação:**
- O token JWT de colaboradores deve expirar em 8 horas.
- O sistema deve redirecionar o colaborador para a tela correspondente ao seu perfil de acesso (RBAC).
- Sessões expiradas ou revogadas devem bloquear o acesso imediatamente.

**Regras de Negócio / RNFs:** RNF07 (JWT 8h para colaboradores) | RN11 (hierarquia RBAC)

---

### US01.4 — Edição de perfil e dados cadastrais

**Como** cliente,
**quero** alterar meus dados cadastrais (telefone, endereço, e-mail),
**para que** minhas informações estejam sempre atualizadas.

**Critérios de Aceitação:**
- O cliente pode editar nome, telefone, e-mail e endereço de entrega.
- A alteração de e-mail deve exigir confirmação via código enviado ao novo endereço.
- Dados sensíveis (CPF) não podem ser alterados pelo próprio cliente.

**Regras de Negócio / RNFs:** RF10 | RNF06 (LGPD)

---

### US01.5 — Visualização de histórico de compras e receitas

**Como** cliente,
**quero** visualizar minhas compras anteriores e receitas enviadas,
**para que** eu acompanhe meu histórico de saúde e repita pedidos recorrentes.

**Critérios de Aceitação:**
- Deve listar pedidos com data, produtos, valor total e status.
- Deve exibir as receitas médicas enviadas com o status de validação (Aprovada / Reprovada).
- O acesso às imagens de receitas deve ser feito via URL temporária assinada.

**Regras de Negócio / RNFs:** RF10 | RNF08 (URLs temporárias para imagens de receitas)

---

## EP02 — Atendimento via Chat Híbrido

> Cobre a interface de chat com IA, transbordo para humano e gestão da fila de atendimento.
> **RFs:** RF03, RF04, RF05, RF11, RF12 | **RNs:** RN01, RN02 | **RNFs:** RNF02, RNF13 | **UCs:** UC04

---

### US02.1 — Iniciar conversa com a IA

**Como** cliente,
**quero** iniciar uma conversa com a IA do app,
**para que** eu tire dúvidas sobre produtos, posologia e realize pedidos sem precisar esperar por um atendente.

**Critérios de Aceitação:**
- A IA deve responder em no máximo 5 segundos (RNF02).
- A IA deve ser capaz de reconhecer intenções como: consultar produto, tirar dúvida de posologia e iniciar pedido.
- As orientações técnicas (posologia, efeitos colaterais) devem ser salvas em log inalterável vinculado ao ID da conversa.

**Regras de Negócio / RNFs:** RF03 | RN02 | RNF02 (5s de resposta)

---

### US02.2 — Adicionar produto ao carrinho via chat

**Como** cliente,
**quero** adicionar produtos ao meu carrinho diretamente pelo chat,
**para que** eu finalize a compra sem precisar sair da conversa.

**Critérios de Aceitação:**
- A IA deve identificar o produto mencionado na mensagem e exibir uma confirmação com nome, preço e disponibilidade.
- O cliente deve confirmar a adição com um clique.
- Itens sem estoque devem ser bloqueados, com mensagem informativa.
- O carrinho deve ser atualizado em tempo real.

**Regras de Negócio / RNFs:** RF05 | RN07 (bloqueio por estoque insuficiente)

---

### US02.3 — Transbordo automático para atendente humano

**Como** cliente,
**quero** ser transferido para um atendente humano quando a IA não conseguir me ajudar,
**para que** minha dúvida ou pedido seja resolvido sem frustração.

**Critérios de Aceitação:**
- Após 2 tentativas consecutivas sem reconhecer a intenção, o sistema deve mover a conversa para a fila de "Atendimento Humano" com prioridade alta automaticamente.
- O cliente deve ser notificado da transferência com uma mensagem clara no chat.
- O atendente recebe o histórico completo da conversa até aquele ponto.

**Regras de Negócio / RNFs:** RF04 | RN01 (transbordo após 2 tentativas)

---

### US02.4 — Solicitar atendente humano manualmente

**Como** cliente,
**quero** poder solicitar um atendente humano a qualquer momento,
**para que** eu tenha a opção de falar com uma pessoa quando preferir.

**Critérios de Aceitação:**
- Deve haver um botão ou comando de fácil acesso para solicitar atendimento humano.
- O sistema deve informar o tempo estimado de espera (se disponível).
- A solicitação manual deve entrar na fila com prioridade padrão.

**Regras de Negócio / RNFs:** RF04

---

### US02.5 — Fila de atendimento no painel do atendente

**Como** atendente,
**quero** visualizar todos os chats ativos em um painel organizado,
**para que** eu gerencie os atendimentos de forma eficiente e sem perder nenhum cliente.

**Critérios de Aceitação:**
- O painel deve listar os chats com: nome do cliente, status (IA ou Humano), data/hora de início e tempo de espera.
- Deve ser possível filtrar por data (dia/mês/ano) e por status do atendimento.
- O atendente deve conseguir assumir um chat da fila com um clique.

**Regras de Negócio / RNFs:** RF11

---

### US02.6 — Consultar histórico do cliente no painel

**Como** atendente,
**quero** buscar um cliente por CPF, e-mail ou nome,
**para que** eu visualize seu histórico completo antes ou durante o atendimento.

**Critérios de Aceitação:**
- A busca deve retornar: dados cadastrais, histórico de pedidos e logs de conversas anteriores.
- O acesso deve ser restrito ao perfil Atendente ou superior.

**Regras de Negócio / RNFs:** RF12

---

### US02.7 — Persistência de mensagens offline

**Como** cliente,
**quero** que minhas mensagens sejam enviadas mesmo quando minha conexão cair temporariamente,
**para que** eu não perca o andamento do meu atendimento por instabilidade de rede.

**Critérios de Aceitação:**
- As mensagens digitadas sem conexão devem ser enfileiradas localmente no dispositivo.
- Ao restabelecer a conexão, as mensagens devem ser sincronizadas automaticamente sem ação do usuário.
- O cliente deve visualizar indicação visual de "mensagem aguardando envio".

**Regras de Negócio / RNFs:** RNF13

---

## EP03 — Catálogo de Produtos

> Cobre a navegação, busca e visualização de detalhes de produtos pelo cliente.
> **RFs:** RF02 | **RNFs:** RNF01, RNF09 | **UCs:** UC15

---

### US03.1 — Navegar pelo catálogo por categorias

**Como** cliente,
**quero** navegar pelo catálogo de produtos organizado por categorias,
**para que** eu encontre facilmente o que procuro sem precisar digitar uma busca.

**Critérios de Aceitação:**
- A tela inicial deve exibir os produtos com foto, nome e preço.
- Deve haver navegação por categorias (ex: Medicamentos, Higiene, Beleza, Suplementos).
- A navegação deve ser fluida, mantendo 60 FPS (RNF01).

**Regras de Negócio / RNFs:** RF02 | RNF01 (60 FPS) | RNF09 (responsividade 4" a 12.9")

---

### US03.2 — Buscar produto por nome ou fabricante

**Como** cliente,
**quero** pesquisar um produto pelo nome ou fabricante,
**para que** eu encontre rapidamente o item específico que preciso.

**Critérios de Aceitação:**
- A busca deve filtrar resultados em tempo real conforme o usuário digita.
- Deve ser tolerante a erros de digitação simples (ex: "dipirona" → "dipirona").
- Em caso de nenhum resultado, o sistema deve exibir mensagem informativa e sugerir categorias relacionadas.
- Produtos sem estoque devem aparecer com indicação visual de "Indisponível" e sem botão de compra.

**Regras de Negócio / RNFs:** RF02

---

### US03.3 — Visualizar detalhe de um produto

**Como** cliente,
**quero** ver a página completa de um produto com foto, descrição e preço,
**para que** eu tenha informações suficientes para decidir minha compra.

**Critérios de Aceitação:**
- A tela deve exibir: foto ampliada, nome, descrição completa, preço e disponibilidade em estoque.
- Deve haver um botão "Comprar via Chat" que inicia o fluxo de venda (UC01).
- Produto indisponível deve ocultar o botão de compra.

**Regras de Negócio / RNFs:** RF02

---

## EP04 — Receitas Médicas e Compliance Regulatório

> Cobre o upload de receitas pelo cliente, análise via OCR e validação pelo Farmacêutico.
> **RFs:** RF06, RF13, RF15, RF21, RF24 | **RNs:** RN03, RN04, RN05, RN06 | **RNFs:** RNF06, RNF08, RNF15 | **UCs:** UC05, UC06

---

### US04.1 — Enviar foto de receita médica no chat

**Como** cliente,
**quero** enviar a foto da minha receita médica diretamente no chat,
**para que** o farmacêutico valide e libere a compra do meu medicamento controlado.

**Critérios de Aceitação:**
- O cliente deve poder enviar a imagem pela câmera ou galeria do celular.
- O sistema deve confirmar o recebimento da imagem com uma mensagem no chat.
- A imagem deve ser armazenada em bucket privado, acessível apenas via URL temporária assinada.
- O cliente deve ser notificado quando a receita for analisada (aprovada ou reprovada).

**Regras de Negócio / RNFs:** RF06 | RN04 (trava de medicamento controlado) | RNF06 (AES-256) | RNF08 (bucket privado)

---

### US04.2 — Análise preliminar de receita via OCR (IA)

**Como** sistema,
**quero** extrair automaticamente os dados da receita médica via OCR ao receber a imagem,
**para que** o farmacêutico tenha os dados pré-preenchidos e agilize a validação.

**Critérios de Aceitação:**
- O OCR deve extrair: nome do médico, CRM, UF, nome do medicamento e posologia.
- A acurácia mínima do OCR deve ser de 85% em condições normais de iluminação (RNF15).
- Os dados extraídos devem ser exibidos como sugestão ao farmacêutico, sem serem validados automaticamente.
- A confirmação final obrigatoriamente deve ser feita por um humano (Atendente ou Farmacêutico).

**Regras de Negócio / RNFs:** RF21 | RN03 (OCR apenas auxilia, não valida sozinho) | RNF15 (85% de acurácia)

---

### US04.3 — Validação de receita pelo Farmacêutico

**Como** farmacêutico,
**quero** visualizar a receita enviada pelo cliente e os dados extraídos pelo OCR,
**para que** eu aprove ou reprove a venda do medicamento controlado com segurança.

**Critérios de Aceitação:**
- A tela deve exibir: imagem da receita em boa resolução, dados extraídos pelo OCR e contexto do pedido.
- O farmacêutico deve poder: Aprovar (libera o checkout) ou Não Aprovar (exige inserção de nota explicativa).
- Em caso de reprovação, a nota deve ser enviada automaticamente ao cliente via chat.
- A validação deve ser concluída em no máximo 4 cliques (RNF11).
- O CRM do farmacêutico validador deve ser registrado obrigatoriamente.

**Regras de Negócio / RNFs:** RF13 | RN04, RN05, RN06 | RNF11 (máx. 4 cliques)

---

### US04.4 — Persistência dos dados de auditoria da venda

**Como** sistema,
**quero** salvar todos os dados regulatórios de cada venda de medicamento controlado,
**para que** a farmácia esteja em conformidade com as normas sanitárias e legais.

**Critérios de Aceitação:**
- Para cada venda com receita, o sistema deve persistir: ID do produto, CPF do comprador, data/hora, imagem da receita, CRM do farmacêutico validador, CRM e UF do médico prescritor e log completo do chat.
- Esse registro deve ser imutável e auditável.
- O log de orientações técnicas da IA deve ser salvo com o ID da conversa e não pode ser editado.

**Regras de Negócio / RNFs:** RF15, RF24 | RN02, RN05, RN06 | RNF06 (AES-256) | RNF08

---

## EP05 — Carrinho, Checkout e Pagamento

> Cobre o fluxo de finalização de compra, geração de PIX e registro de pagamento.
> **RFs:** RF07, RF08, RF22 | **RNs:** RN07, RN08, RN09, RN10 | **UCs:** UC08

---

### US05.1 — Finalizar compra com pagamento via PIX remoto

**Como** cliente,
**quero** pagar meu pedido via PIX pelo app,
**para que** eu finalize a compra de forma remota sem precisar ir até a farmácia.

**Critérios de Aceitação:**
- O sistema deve gerar uma chave PIX dinâmica ao confirmar o pedido.
- A chave PIX deve expirar em exatamente 10 minutos.
- O app deve exibir um QR Code e a chave copia-e-cola com contador de tempo regressivo.
- Após confirmação via Webhook bancário, o pedido deve avançar automaticamente para "Pagamento Aprovado".
- Se expirar, o pedido deve ser cancelado automaticamente e os itens devem retornar ao estoque.

**Regras de Negócio / RNFs:** RF07, RF22 | RN08 (expiração de 10 min) | RN09 (confirmação via Webhook) | RN10 (preço imutável após finalização)

---

### US05.2 — Selecionar pagamento presencial na entrega

**Como** cliente,
**quero** optar por pagar em dinheiro ou cartão no momento da entrega,
**para que** eu finalize o pedido mesmo sem ter como pagar digitalmente agora.

**Critérios de Aceitação:**
- O cliente deve visualizar as opções: PIX, Dinheiro na entrega e Cartão na entrega.
- Ao escolher pagamento presencial, o pedido deve ser confirmado sem exigir pagamento antecipado.
- O entregador deve registrar a baixa do pagamento via app após a entrega.

**Regras de Negócio / RNFs:** RF08 | RN09 (baixa manual pelo entregador)

---

### US05.3 — Bloquear checkout por estoque insuficiente

**Como** sistema,
**quero** impedir a finalização de compra quando o item solicitado estiver sem estoque,
**para que** não seja gerado um pedido impossível de ser atendido.

**Critérios de Aceitação:**
- O sistema deve verificar o saldo de estoque em tempo real no momento do checkout.
- Se insuficiente, o item deve ser bloqueado com mensagem informativa ao cliente.
- O bloqueio deve ocorrer tanto no app (UX) quanto no backend (integridade).

**Regras de Negócio / RNFs:** RN07

---

### US05.4 — Imutabilidade do preço de venda

**Como** sistema,
**quero** registrar o preço do produto no momento exato da finalização da venda,
**para que** alterações futuras no cadastro não afetem pedidos já concluídos.

**Critérios de Aceitação:**
- O preço exibido e cobrado deve ser o vigente no momento da confirmação do checkout.
- Qualquer alteração posterior no cadastro do produto não deve impactar pedidos finalizados.
- O preço registrado na venda deve ser imutável no banco de dados.

**Regras de Negócio / RNFs:** RN10

---

## EP06 — Logística e Rastreamento de Pedidos

> Cobre o acompanhamento de status, notificações push e restrição de raio de entrega.
> **RFs:** RF09, RF23 | **RNs:** RN12, RN13 | **RNFs:** RNF04, RNF13 | **UCs:** UC12, UC16

---

### US06.1 — Rastrear status do pedido em tempo real

**Como** cliente,
**quero** acompanhar o status do meu pedido em tempo real pelo app,
**para que** eu saiba exatamente onde está meu produto.

**Critérios de Aceitação:**
- O app deve exibir os estados: Pagamento Aprovado → Em Separação → Saiu para Entrega → Entregue.
- Cada mudança de status deve ser atualizada em no máximo 30 segundos (RNF04).
- O histórico de atualizações deve ser visível na tela do pedido.

**Regras de Negócio / RNFs:** RF09 | RN13 | RNF04 (30s de latência máxima)

---

### US06.2 — Receber notificações push de status do pedido

**Como** cliente,
**quero** receber notificações push a cada atualização do meu pedido,
**para que** eu seja informado sem precisar ficar abrindo o app.

**Critérios de Aceitação:**
- O sistema deve disparar push a cada mudança de estado (pagamento, separação, entrega, receita reprovada).
- Ao tocar na notificação, o app deve abrir e redirecionar diretamente para a tela correspondente ao evento.
- Se o app estiver fechado, deve inicializar e redirecionar após a autenticação.
- Se a permissão de push for negada, as atualizações devem ficar visíveis na central de notificações interna do app.

**Regras de Negócio / RNFs:** RF23 | RN13

---

### US06.3 — Restrição de entrega por raio configurável

**Como** sistema,
**quero** bloquear pedidos para endereços fora do raio de entrega da unidade,
**para que** não sejam aceitos pedidos que a farmácia não consiga atender.

**Critérios de Aceitação:**
- O sistema deve verificar se o endereço de entrega está dentro do raio configurado para a unidade responsável.
- Caso fora do raio, o checkout deve ser bloqueado com mensagem clara ao cliente.
- O raio de entrega deve ser configurável por unidade pelo Gerente ou Dono (ver EP07).

**Regras de Negócio / RNFs:** RN12 | RF19

---

## EP07 — Painel Administrativo e Gestão de Unidade

> Cobre a edição de catálogo, controle de estoque e configurações de logística da unidade.
> **RFs:** RF14, RF19 | **RNs:** RN10 | **RNFs:** RNF04 | **UCs:** UC03, UC07

---

### US07.1 — Editar preço e descrição de produto

**Como** gerente ou administrador,
**quero** editar o preço, descrição e foto de um produto no catálogo,
**para que** as informações exibidas aos clientes estejam sempre corretas.

**Critérios de Aceitação:**
- O sistema deve permitir alterar: preço, descrição, foto e categoria do produto.
- Alterações de preço não devem afetar pedidos já finalizados (RN10).
- As atualizações devem ser refletidas no app do cliente em no máximo 30 segundos (RNF04).

**Regras de Negócio / RNFs:** RF14 | RN10 | RNF04

---

### US07.2 — Atualizar saldo de estoque por unidade

**Como** atendente ou gerente,
**quero** atualizar o saldo de estoque de um produto na minha unidade,
**para que** as informações de disponibilidade reflitam a realidade do estoque físico.

**Critérios de Aceitação:**
- Deve ser possível ajustar o saldo de estoque por produto e por unidade.
- A atualização deve ser refletida no app do cliente em no máximo 30 segundos (RNF04).
- Movimentações de estoque devem gerar log de rastreabilidade.

**Regras de Negócio / RNFs:** RF14 | RNF04

---

### US07.3 — Configurar raio de entrega da unidade

**Como** gerente ou dono,
**quero** definir o raio máximo de entrega (em km) para minha unidade,
**para que** apenas pedidos de endereços alcançáveis sejam aceitos.

**Critérios de Aceitação:**
- A configuração deve aceitar valores em quilômetros.
- A alteração deve entrar em vigor imediatamente para novos pedidos.
- Somente perfis Gerente e Dono devem ter acesso a essa configuração.

**Regras de Negócio / RNFs:** RF19 | RN12

---

## EP08 — Gestão de Acessos (RBAC)

> Cobre o controle de permissões e gerenciamento de colaboradores pelo Administrador.
> **RFs:** RF18 | **RNs:** RN11 | **RNFs:** RNF07 | **UC:** UC14

---

### US08.1 — Criar e configurar perfil de colaborador

**Como** administrador,
**quero** criar um novo usuário colaborador e definir seu perfil de acesso,
**para que** cada funcionário tenha acesso apenas às funcionalidades da sua alçada.

**Critérios de Aceitação:**
- O administrador deve poder criar usuários com os perfis: Atendente, Farmacêutico, Gerente e Dono.
- Cada perfil deve ter as permissões descritas em RN11.
- O novo colaborador deve receber as credenciais de acesso após o cadastro.

**Regras de Negócio / RNFs:** RF18 | RN11

---

### US08.2 — Alterar ou rebaixar perfil de colaborador

**Como** administrador,
**quero** alterar o perfil de acesso de um colaborador,
**para que** as permissões reflitam a função atual do funcionário.

**Critérios de Aceitação:**
- Após a alteração, a sessão ativa do colaborador deve ser invalidada imediatamente, forçando novo login.
- O sistema deve impedir que o administrador altere seu próprio perfil (evitar bloqueio acidental).

**Regras de Negócio / RNFs:** RF18 | RNF07

---

### US08.3 — Suspender acesso de colaborador

**Como** administrador,
**quero** suspender o acesso de um colaborador imediatamente,
**para que** um funcionário desligado ou suspeito não tenha mais acesso ao sistema.

**Critérios de Aceitação:**
- A suspensão deve invalidar a sessão ativa imediatamente.
- O colaborador suspenso não deve conseguir realizar novo login.
- O administrador deve poder reativar o acesso quando necessário.

**Regras de Negócio / RNFs:** RF18 | RNF07

---

## EP09 — Relatórios, BI e Auditoria

> Cobre dashboards gerenciais, relatórios de vendas e logs de auditoria.
> **RFs:** RF16, RF17, RF24 | **RNs:** RN02, RN11 | **UC:** UC09

---

### US09.1 — Visualizar relatório de faturamento por período

**Como** gerente ou dono,
**quero** gerar relatórios de faturamento por unidade e período,
**para que** eu acompanhe a performance financeira da farmácia.

**Critérios de Aceitação:**
- O relatório deve ser filtrável por unidade, período (dia/semana/mês) e categoria de produto.
- O Gerente visualiza apenas dados da sua unidade; o Dono visualiza todas as unidades (RN11).
- Deve exibir: faturamento total, ticket médio e lista dos produtos mais vendidos.

**Regras de Negócio / RNFs:** RF16 | RN11

---

### US09.2 — Acessar dashboard de indicadores de performance (BI)

**Como** gerente ou dono,
**quero** visualizar dashboards com indicadores de performance do app e da IA,
**para que** eu tome decisões estratégicas baseadas em dados.

**Critérios de Aceitação:**
- O dashboard deve exibir: ticket médio, taxa de recorrência de clientes, volume de atendimentos IA vs. Humano e taxa de transbordo.
- Os gráficos devem ser filtráveis por período.
- O acesso deve respeitar a hierarquia RBAC (RN11).

**Regras de Negócio / RNFs:** RF17 | RN11

---

### US09.3 — Consultar logs de auditoria de orientações técnicas da IA

**Como** farmacêutico ou administrador,
**quero** consultar o log de todas as orientações técnicas fornecidas pela IA,
**para que** eu audite o que foi comunicado aos clientes por questões regulatórias.

**Critérios de Aceitação:**
- O log deve ser inalterável e vinculado ao ID da conversa.
- Deve conter: data/hora, ID do cliente, ID da conversa e conteúdo da orientação.
- Somente perfis Farmacêutico, Gerente e Dono devem ter acesso.

**Regras de Negócio / RNFs:** RF24 | RN02

---

## EP10 — Configuração e Administração da IA

> Cobre o ajuste de parâmetros, base de conhecimento e gatilhos de comportamento da IA.
> **RFs:** RF20, RF24 | **RNs:** RN01, RN02 | **RNFs:** RNF02, RNF15, RNF16 | **UC:** UC13

---

### US10.1 — Configurar gatilho de transbordo da IA

**Como** administrador,
**quero** definir o número de tentativas da IA antes do transbordo automático para humano,
**para que** o comportamento da IA esteja alinhado com a política de atendimento da farmácia.

**Critérios de Aceitação:**
- O administrador deve poder configurar o número de tentativas (padrão: 2, conforme RN01).
- A alteração deve ser aplicada em tempo real sem reinicialização do sistema (RNF16).
- O log da alteração deve ser registrado para auditoria.

**Regras de Negócio / RNFs:** RF20 | RN01 | RNF16

---

### US10.2 — Atualizar base de conhecimento da IA

**Como** administrador,
**quero** editar a base de conhecimento da IA (produtos, posologias, FAQs),
**para que** as respostas da IA estejam sempre atualizadas e precisas.

**Critérios de Aceitação:**
- O administrador deve poder adicionar, editar e remover entradas da base de conhecimento.
- As atualizações devem ser refletidas no comportamento da IA em tempo real (RNF16).
- Deve haver versioning das alterações para possibilitar rollback.

**Regras de Negócio / RNFs:** RF20 | RNF16

---

### US10.3 — Configurar limiar de confiança do OCR

**Como** administrador,
**quero** ajustar o limiar de confiança mínima do OCR para análise de receitas,
**para que** eu equilibre a automação com a precisão exigida pelo ambiente regulatório.

**Critérios de Aceitação:**
- O administrador deve poder definir o limiar de confiança entre 50% e 99% (RNF15).
- Valores fora dessa faixa devem ser bloqueados com mensagem de erro.
- Em caso de falha na aplicação, o sistema deve reverter para a configuração anterior e notificar o administrador.

**Regras de Negócio / RNFs:** RF20 | RNF15

---

> **Nota:** Este backlog deve ser refinado a cada Sprint Planning, com estimativas de esforço (Story Points) e critérios de priorização (MoSCoW ou WSJF) definidos em conjunto com o time de desenvolvimento e os stakeholders da Farmácia Americana.
