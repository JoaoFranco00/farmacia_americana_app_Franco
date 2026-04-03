# Casos de Uso (UC) — Ecossistema Farmácia Americana

> Este documento detalha as interações funcionais entre os atores e o sistema, servindo como guia para o desenvolvimento da lógica de negócio no Flutter e Backend.
>

---

## Índice

### Domínio: Acesso e Identidade
- [UC10 — Autenticar Usuário](#uc10--autenticar-usuário)
- [UC11 — Gerenciar Perfil e Conta](#uc11--gerenciar-perfil-e-conta)
- [UC14 — Gerenciar Acessos e Perfis (RBAC)](#uc14--gerenciar-acessos-e-perfis-rbac)

### Domínio: Atendimento
- [UC04 — Realizar Transbordo de Atendimento](#uc04--realizar-transbordo-de-atendimento)
- [UC13 — Configurar e Gerenciar IA](#uc13--configurar-e-gerenciar-ia)

### Domínio: Operação
- [UC01 — Realizar Venda](#uc01--realizar-venda)
- [UC02 — Identificar ou Cadastrar Cliente](#uc02--identificar-ou-cadastrar-cliente)
- [UC03 — Consultar e Verificar Estoque](#uc03--consultar-e-verificar-estoque)
- [UC15 — Navegar no Catálogo e Consultar Produto](#uc15--navegar-no-catálogo-e-consultar-produto)

### Domínio: Regulatório
- [UC05 — Validar Receita Médica](#uc05--validar-receita-médica)
- [UC06 — Persistir Dados de Auditoria](#uc06--persistir-dados-de-auditoria)

### Domínio: Financeiro e Logística
- [UC08 — Processar Pagamento e Confirmar Recebimento](#uc08--processar-pagamento-e-confirmar-recebimento)
- [UC12 — Rastrear Pedido em Tempo Real](#uc12--rastrear-pedido-em-tempo-real)
- [UC16 — Receber e Processar Notificação Push](#uc16--receber-e-processar-notificação-push)

### Domínio: Gestão
- [UC07 — Gerenciar Unidade](#uc07--gerenciar-unidade)
- [UC09 — Analisar Performance e Auditoria (BI)](#uc09--analisar-performance-e-auditoria-bi)

---

## Cobertura Completa

| UC | Nome | Domínio | RFs | RNs | RNFs |
|---|---|---|---|---|---|
| UC01 | Realizar Venda | Operação | RF03, RF05 | RN05, RN07, RN08 | — |
| UC02 | Identificar ou Cadastrar Cliente | Operação | RF01 | — | — |
| UC03 | Consultar e Verificar Estoque | Operação | RF14 | RN07 | RNF04 |
| UC04 | Realizar Transbordo de Atendimento | Atendimento | RF04, RF11 | RN01 | RNF02 |
| UC05 | Validar Receita Médica | Regulatório | RF06, RF13, RF21 | RN03, RN04, RN06 | RNF15 |
| UC06 | Persistir Dados de Auditoria | Regulatório | RF15, RF24 | RN02, RN05, RN06 | RNF06, RNF08 |
| UC07 | Gerenciar Unidade | Gestão | RF14, RF19 | RN10 | RNF04 |
| UC08 | Processar Pagamento e Confirmar Recebimento | Financeiro | RF07, RF08, RF22 | RN08, RN09, RN10 | — |
| UC09 | Analisar Performance e Auditoria (BI) | Gestão | RF16, RF17 | RN11 | — |
| UC10 | Autenticar Usuário | Acesso | RF01 | — | RNF05, RNF07 |
| UC11 | Gerenciar Perfil e Conta | Acesso | RF10 | — | RNF06 |
| UC12 | Rastrear Pedido em Tempo Real | Logística | RF09, RF23 | RN13 | RNF04 |
| UC13 | Configurar e Gerenciar IA | Atendimento | RF20, RF24 | RN01, RN02 | RNF02, RNF15, RNF16 |
| UC14 | Gerenciar Acessos e Perfis (RBAC) | Acesso | RF18 | RN11 | RNF07 |
| UC15 | Navegar no Catálogo e Consultar Produto | Operação | RF02 | — | RNF01, RNF09 |
| UC16 | Receber e Processar Notificação Push | Logística | RF23 | RN13 | RNF13 |

<img width="1005" height="872" alt="image" src="https://github.com/user-attachments/assets/efa219cf-a260-40c1-a2ae-1c8e8e64a7c5" />

---

## UC01 — Realizar Venda

| Campo | Descrição |
|---|---|
| **Ator(es)** | Atendente, Administrador, IA Americana, Cliente |
| **Descrição** | Registra a venda de produtos, verificando estoque, calculando valores, processando pagamento e emitindo comprovante. |
| **Pré-condições** | Usuário autenticado (UC10); Produtos com estoque disponível. |
| **Pós-condições** | Venda registrada (RN05); Estoque atualizado; Comprovante emitido. |
| **RFs relacionados** | RF03, RF05 |
| **RNs relacionadas** | RN05, RN07, RN08 |

### Fluxo Principal

1. O Ator inicia uma nova venda (via Chat IA ou Painel Manual).
2. Sistema solicita identificação do cliente (inclui **UC02**).
3. Ator pesquisa e adiciona produtos pelo nome.
4. Sistema verifica disponibilidade em estoque (inclui **UC03**).
5. Ator informa as quantidades; Sistema calcula o total.
6. Sistema verifica necessidade de receita (estende **UC05**).
7. Atendente/Cliente seleciona forma de pagamento (inclui **UC08**).
8. Sistema finaliza a venda, atualiza estoque e emite comprovante.
9. Sistema dispara persistência de dados de auditoria (inclui **UC06**).

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Estoque Insuficiente | Sistema bloqueia o item e informa o saldo disponível (RN07). |
| **FA02** | Pagamento PIX Expirado | Se não confirmado em 10 min, o pedido é cancelado e o estoque é liberado (RN08). |
| **FA03** | IA Não Resolve Intenção | Após 2 tentativas, o sistema aciona o transbordo automático (estende UC04). |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Include** | UC02 — Identificar ou Cadastrar Cliente |
| **Include** | UC03 — Consultar e Verificar Estoque |
| **Include** | UC06 — Persistir Dados de Auditoria |
| **Include** | UC08 — Processar Pagamento e Confirmar Recebimento |
| **Extend** | UC05 — Validar Receita Médica (se houver medicamento controlado) |
| **Extend** | UC04 — Realizar Transbordo de Atendimento (se IA falhar) |

### Diagrama de Atividades

<img width="350" height="834" alt="image" src="https://github.com/user-attachments/assets/622da48d-a451-4522-a852-6a47fd799568" />

---

## UC02 — Identificar ou Cadastrar Cliente

| Campo | Descrição |
|---|---|
| **Ator(es)** | Atendente, Administrador, IA Americana |
| **Descrição** | Identifica um cliente existente via CPF ou realiza o registro de um novo usuário para permitir a continuidade da venda. |
| **Pré-condições** | Usuário autenticado (UC10); Fluxo de venda iniciado. |
| **Pós-condições** | Cliente vinculado à transação; Dados persistidos no banco de dados. |
| **RFs relacionados** | RF01 |
| **RNs relacionadas** | — |

### Fluxo Principal

1. O Sistema (ou Atendente) solicita o CPF do cliente.
2. Atendente insere o CPF no sistema.
3. Sistema realiza a busca na base de dados centralizada.
4. Se localizado: Sistema exibe os dados (Nome, Telefone, Endereço) e vincula ao pedido.
5. Se não localizado: Sistema abre formulário de novo cadastro.
6. Atendente preenche dados obrigatórios (Nome, E-mail, Telefone).
7. Sistema valida os dados e confirma o salvamento.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | CPF Inválido | O sistema identifica erro de dígito verificador, exibe alerta e solicita nova inserção. |
| **FA02** | Cliente com Restrição | O sistema identifica bloqueio administrativo no perfil do cliente e notifica o Atendente para autorização superior. |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Include** | Faz parte do UC01 — Realizar Venda |

### Diagrama de Atividades

<img width="358" height="422" alt="image" src="https://github.com/user-attachments/assets/574148f2-d573-4bdc-8f3d-b88cfeb56caa" />

---

## UC03 — Consultar e Verificar Estoque

| Campo | Descrição |
|---|---|
| **Ator(es)** | Atendente, Administrador, Sistema (Automático) |
| **Descrição** | Verifica a disponibilidade física de um item na unidade atual antes de permitir sua adição ao carrinho. |
| **Pré-condições** | Produto identificado por nome ou ID; Unidade física selecionada. |
| **Pós-condições** | Saldo exibido; Reserva temporária do item realizada. |
| **RFs relacionados** | RF14 |
| **RNs relacionadas** | RN07 |
| **RNFs relacionados** | RNF04 |

### Fluxo Principal

1. Atendente pesquisa o produto durante a venda.
2. Sistema consulta a tabela de estoque da unidade em tempo real.
3. Sistema retorna o saldo disponível.
4. Atendente confirma a adição da quantidade desejada.
5. Sistema realiza a reserva lógica do item para evitar venda duplicada.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Estoque Zerado | Sistema exibe o item em vermelho, bloqueia a inclusão e sugere consulta em outras unidades próximas. |
| **FA02** | Quantidade Superior ao Saldo | Sistema limita a inserção ao máximo disponível em estoque (RN07). |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Include** | Faz parte do UC01 — Realizar Venda |

### Diagrama de Atividades

<img width="481" height="431" alt="image" src="https://github.com/user-attachments/assets/509daaca-90d3-4ea5-b679-1a8a4e4a495b" />

---

## UC04 — Realizar Transbordo de Atendimento

| Campo | Descrição |
|---|---|
| **Ator(es)** | IA Americana, Atendente, Cliente |
| **Descrição** | Transfere a conversa da IA para um operador humano quando as regras de transbordo são acionadas por falha de intenção ou solicitação explícita do cliente. |
| **Pré-condições** | Chat ativo; Gatilho de falha da IA (2 tentativas) ou solicitação manual do cliente. |
| **Pós-condições** | Atendente assume o chat; Log completo da IA preservado e visível para o atendente. |
| **RFs relacionados** | RF04, RF11 |
| **RNs relacionadas** | RN01 |
| **RNFs relacionados** | RNF02 |

### Fluxo Principal

1. IA identifica falha na intenção após 2 tentativas consecutivas, ou o cliente solicita atendimento humano (RN01).
2. Sistema marca a conversa como "Prioridade Alta" na fila de espera.
3. Atendente visualiza o chamado no painel e aceita o atendimento.
4. Sistema carrega o histórico completo da conversa para o Atendente.
5. Atendente assume o diálogo e finaliza o pedido manualmente.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Nenhum Atendente Disponível | Sistema informa o cliente sobre a fila de espera e mantém a IA operando funções básicas enquanto aguarda. |
| **FA02** | Atendente Recusa o Chamado | Sistema redistribui para o próximo atendente disponível na fila. |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Extend** | Estende UC01 — Realizar Venda (quando IA falha) |

### Diagrama de Atividades

<img width="594" height="483" alt="image" src="https://github.com/user-attachments/assets/2a0e5a4c-8bef-49cd-8508-48244de571fd" />

---

## UC05 — Validar Receita Médica

| Campo | Descrição |
|---|---|
| **Ator(es)** | Farmacêutico, Cliente, IA Americana |
| **Descrição** | Processo de análise de prescrições para liberar medicamentos de controle especial, com pré-leitura por OCR da IA e validação humana obrigatória. |
| **Pré-condições** | Foto da receita enviada no chat; Item controlado presente no carrinho do UC01. |
| **Pós-condições** | Venda aprovada ou bloqueada; Registro do CRM do validador persistido (RN06). |
| **RFs relacionados** | RF06, RF13, RF21 |
| **RNs relacionadas** | RN03, RN04, RN06 |
| **RNFs relacionados** | RNF15 |

### Fluxo Principal

1. Sistema identifica medicamento controlado no carrinho e solicita a imagem da receita ao cliente.
2. Cliente envia a foto da receita diretamente no chat (RF06).
3. IA realiza OCR inicial e extrai dados do médico (CRM/UF) e do medicamento para pré-preenchimento (RN03).
4. Farmacêutico recebe notificação e abre a tela de validação.
5. Farmacêutico analisa a imagem da receita contra os dados do pedido.
6. Farmacêutico clica em "Aprovar".
7. Sistema registra o CRM do Farmacêutico e libera o checkout (RN04, RN06).

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Reprovação com Nota | Farmacêutico clica em "Não Aprovar", insere nota obrigatória (ex: "Receita fora da validade") e o sistema envia ao cliente via chat (RF13). |
| **FA02** | OCR com Baixa Confiança | IA sinaliza campos não extraídos com confiança abaixo de 85% (RNF15); Farmacêutico preenche manualmente. |
| **FA03** | Imagem Ilegível | Sistema solicita ao cliente o reenvio da foto em melhor qualidade. |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Extend** | Estende UC01 — Realizar Venda (se houver medicamento controlado) |
| **Include** | UC06 — Persistir Dados de Auditoria (CRM e imagem da receita) |

### Diagrama de Atividades

<img width="521" height="761" alt="image" src="https://github.com/user-attachments/assets/a3d712c9-0dee-433f-a21a-6ae72bcaa7ab" />

---

## UC06 — Persistir Dados de Auditoria

| Campo | Descrição |
|---|---|
| **Ator(es)** | Sistema (Automatismo), API de Auditoria |
| **Descrição** | Realiza a coleta, criptografia e gravação inalterável de todos os dados sensíveis da venda, conversas e validações farmacêuticas para fins de conformidade com a ANVISA e segurança jurídica. |
| **Pré-condições** | Finalização de uma venda (UC01) ou conclusão de uma validação de receita (UC05); Conexão ativa com o Barramento de Serviços/API. |
| **Pós-condições** | Registro de auditoria gerado com ID único de protocolo; Logs de chat e imagens de receitas armazenados com criptografia AES-256 (RNF06); Dados de CRM, CPF e metadados vinculados permanentemente à transação. |
| **RFs relacionados** | RF15, RF24 |
| **RNs relacionadas** | RN02, RN05, RN06 |
| **RNFs relacionados** | RNF06, RNF08 |

### Fluxo Principal

1. O Sistema detecta o gatilho de conclusão no UC01 (Venda) ou UC05 (Validação de Receita).
2. O Sistema inicia a varredura e coleta dos dados obrigatórios (RN05):
   - CPF do comprador e lista de SKUs vendidos;
   - Log completo da sessão de chat (interações IA e Humano);
   - Binário da imagem da receita médica (se houver item controlado);
   - Carimbo de tempo (Timestamp) sincronizado com o servidor;
   - CRM/UF do Médico prescritor e CRM do Farmacêutico validador.
3. O Sistema aplica criptografia AES-256 nos campos de dados sensíveis (RNF06).
4. O Sistema realiza uma requisição POST para o endpoint de auditoria da API.
5. A API valida o esquema dos dados (Schema Validation) e a integridade do payload.
6. A API persiste os dados em tabelas de log append-only (somente escrita, sem deleção).
7. O Sistema gera um número de protocolo de auditoria e o vincula ao registro da venda.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Falha de Comunicação com a API | O sistema armazena o pacote localmente (SQLite/Hive no Flutter ou Cache no Backend) e ativa rotina de Retry a cada 5 minutos até obter sucesso. |
| **FA02** | Inconsistência de Dados Obrigatórios | Se detectada ausência de CRM obrigatório para item controlado, a persistência é marcada com "Flag de Erro" e alerta crítico é enviado ao Administrador. |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Include** | Executado obrigatoriamente ao final do UC01 e do UC05 |

### Diagrama de Atividades

<img width="467" height="954" alt="image" src="https://github.com/user-attachments/assets/7f0842f2-6ccb-4c31-9492-19c42a838106" />

---

## UC07 — Gerenciar Unidade

| Campo | Descrição |
|---|---|
| **Ator(es)** | Gerente, Administrador |
| **Descrição** | Permite a manutenção dos dados operacionais da unidade, incluindo preços, estoque e configurações de logística como raio de entrega. |
| **Pré-condições** | Perfil Gerente ou superior autenticado (UC10); Unidade selecionada. |
| **Pós-condições** | Parâmetros atualizados e refletidos no App do cliente em até 30s (RNF04). |
| **RFs relacionados** | RF14, RF19 |
| **RNs relacionadas** | RN10, RN11, RN12 |
| **RNFs relacionados** | RNF04 |

### Fluxo Principal

1. Gerente acessa o menu de Configurações da Unidade.
2. Seleciona o item a alterar: produto, preço ou configuração de logística.
3. Informa o novo valor.
4. Sistema valida a permissão do usuário (RN11).
5. Sistema persiste a alteração no banco de dados.
6. Sistema propaga a atualização para o app do cliente em até 30s (RNF04).

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Permissão Insuficiente | Sistema exibe erro de permissão e bloqueia a alteração. |
| **FA02** | Raio de Entrega Inválido | Sistema valida que o valor informado está dentro dos limites configurados pelo Administrador (RN12). |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Extend** | Pode ser acessado a partir do UC14 — Gerenciar Acessos e Perfis (RBAC) |

### Diagrama de Atividades

<img width="594" height="538" alt="image" src="https://github.com/user-attachments/assets/a05641b8-ae4d-40ca-8916-e6976706c0df" />

---

## UC08 — Processar Pagamento e Confirmar Recebimento

| Campo | Descrição |
|---|---|
| **Ator(es)** | Cliente, Sistema de Pagamento (Gateway), Atendente (Entregador) |
| **Descrição** | Gerencia o fluxo financeiro da venda, desde a geração do PIX até a baixa manual em entregas presenciais, encerrando o ciclo financeiro do pedido. |
| **Pré-condições** | Venda finalizada no UC01; Valor total calculado; Endereço dentro do raio de entrega (RN12). |
| **Pós-condições** | Status do pedido atualizado para "Pago"; Reserva de estoque convertida em baixa definitiva. |
| **RFs relacionados** | RF07, RF08, RF22 |
| **RNs relacionadas** | RN08, RN09, RN10 |

### Fluxo Principal

1. O Sistema solicita a escolha do método de pagamento.
2. Se PIX: Sistema gera QR Code e chave "Copia e Cola" com validade de 10 min (RN08).
3. O Gateway de Pagamento envia notificação de sucesso via Webhook (RF22).
4. Sistema confirma o pagamento no chat do cliente e altera o status para "Em Separação".
5. Se Presencial (Dinheiro/Cartão): Sistema marca o pedido como "Aguardando Entrega".
6. O Atendente realiza a entrega física.
7. O Atendente registra a baixa manual do pagamento no App (RN09).
8. Sistema encerra o ciclo financeiro e emite o recibo.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Pagamento Recusado / Expirado | O sistema notifica o cliente no chat, libera o estoque reservado e oferece nova tentativa ou cancelamento (RN08). |
| **FA02** | Falha de Conexão no Webhook | O Atendente pode realizar a conferência manual do comprovante PIX para liberar o pedido manualmente. |
| **FA03** | Endereço Fora do Raio | Sistema bloqueia o checkout e informa o cliente (RN12). |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Include** | UC06 — Persistir Dados de Auditoria |
| **Extend** | UC12 — Rastrear Pedido em Tempo Real (após confirmação do pagamento) |

### Diagrama de Atividades

<img width="594" height="598" alt="image" src="https://github.com/user-attachments/assets/02d598be-e7d1-43f5-8941-c169b6c4805d" />

---

## UC09 — Analisar Performance e Auditoria (BI)

| Campo | Descrição |
|---|---|
| **Ator(es)** | Dono, Administrador, Gerente |
| **Descrição** | Fornece visão estratégica sobre faturamento, eficiência da IA, produtos mais vendidos e conformidade das receitas validadas, com escopo filtrado pela hierarquia do usuário. |
| **Pré-condições** | Usuário autenticado com perfil Gerente ou superior (UC10); Dados de vendas disponíveis. |
| **Pós-condições** | Relatórios e dashboards gerados na interface Flutter Web/Desktop; Arquivo de conformidade exportado (se solicitado). |
| **RFs relacionados** | RF16, RF17 |
| **RNs relacionadas** | RN11 |

### Fluxo Principal

1. O Usuário acessa o módulo de "Relatórios e Performance".
2. O Sistema filtra o escopo de dados conforme a hierarquia do perfil (RN11):
   - Dono: todas as unidades.
   - Gerente: apenas sua unidade.
3. O Usuário seleciona o período e tipo de relatório desejado.
4. O Sistema consulta a base de dados consolidada (inclui dados do UC06).
5. O Sistema gera as métricas solicitadas:
   - Faturamento por Unidade/Período (RF16);
   - Produtos mais vendidos e clientes mais recorrentes (RF16);
   - Ticket médio e taxa de recorrência (RF17);
   - Taxa de Transbordo IA vs Humano (RF17);
   - Volume de Medicamentos Controlados vendidos.
6. O Usuário exporta os logs de auditoria para fins regulatórios (ANVISA), se necessário.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Sem Dados no Período | Sistema exibe mensagem informativa e sugere ajuste de filtro de datas. |
| **FA02** | Perfil sem Permissão para Exportação | Sistema oculta a opção de exportação de logs de auditoria para perfis abaixo de Gerente (RN11). |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Include** | UC06 — Persistir Dados de Auditoria (fonte dos dados) |

### Diagrama de Atividades

<img width="529" height="640" alt="image" src="https://github.com/user-attachments/assets/29bb7dfd-1adc-4a89-b55f-6592b40efac1" />

---

## UC10 — Autenticar Usuário

| Campo | Descrição |
|---|---|
| **Ator(es)** | Cliente, Atendente, Farmacêutico, Gerente, Administrador, Dono |
| **Descrição** | Controla o acesso ao ecossistema por meio de login com CPF/e-mail e senha, emissão de token JWT e logout seguro, com tempo de sessão diferenciado por perfil. |
| **Pré-condições** | Aplicativo instalado e com conexão ativa; Usuário com cadastro existente no sistema. |
| **Pós-condições** | Sessão autenticada com token JWT ativo; Usuário redirecionado para a tela inicial de seu perfil. |
| **RFs relacionados** | RF01 |
| **RNFs relacionados** | RNF05, RNF07 |

### Fluxo Principal

1. O Usuário abre o aplicativo e é exibida a tela de splash.
2. O Sistema verifica se há token JWT válido em cache local.
3. Se token válido: Sistema redireciona o usuário para a tela inicial do seu perfil (auto-login).
4. Se não há token ou ele está expirado: Sistema exibe a tela de login.
5. Usuário informa CPF (ou e-mail) e senha.
6. Sistema valida as credenciais via API (HTTPS/TLS 1.3 — RNF05).
7. Sistema emite token JWT com expiração conforme perfil:
   - **Clientes:** 24 horas (RNF07);
   - **Colaboradores (Atendente, Farmacêutico, Gerente, Admin, Dono):** 8 horas (RNF07).
8. Sistema armazena o token de forma segura no dispositivo.
9. Usuário é redirecionado para a tela inicial do seu perfil.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Credenciais Inválidas | Sistema exibe mensagem de erro genérica (sem indicar qual campo está errado por segurança) e permite nova tentativa. |
| **FA02** | Token Expirado durante Sessão | Sistema invalida a sessão local, exibe aviso ao usuário e redireciona para a tela de login. |
| **FA03** | Múltiplas Tentativas Falhas | Sistema bloqueia temporariamente o acesso após 5 tentativas consecutivas e notifica o Administrador. |
| **FA04** | Sem Conexão | Sistema informa a indisponibilidade e impede o login até que a conexão seja restabelecida. |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Include** | Pré-condição obrigatória para todos os demais casos de uso do sistema |

### Diagrama de Atividades

<img width="594" height="434" alt="image" src="https://github.com/user-attachments/assets/dd1f694a-602a-467b-913f-e6ad4cfd8922" />

---

## UC11 — Gerenciar Perfil e Conta

| Campo | Descrição |
|---|---|
| **Ator(es)** | Cliente, Atendente, Farmacêutico, Gerente, Administrador, Dono |
| **Descrição** | Permite que cada usuário visualize e atualize seus dados cadastrais, altere sua senha e, no caso do cliente, acesse o histórico completo de compras e receitas enviadas. |
| **Pré-condições** | Usuário autenticado com sessão ativa (UC10). |
| **Pós-condições** | Dados atualizados persistidos no banco de dados; Histórico de compras exibido ao cliente. |
| **RFs relacionados** | RF10 |
| **RNFs relacionados** | RNF06 |

### Fluxo Principal

1. Usuário acessa a tela de "Minha Conta" / "Perfil".
2. Sistema exibe os dados cadastrais atuais do usuário.
3. Usuário seleciona o campo a ser alterado (Nome, Telefone, Endereço ou Senha).
4. Usuário informa o novo valor.
5. Sistema valida os dados (formato, unicidade de e-mail/CPF).
6. Sistema persiste a alteração com criptografia nos campos sensíveis (RNF06).
7. Sistema exibe confirmação de sucesso.

**Fluxo Alternativo — Histórico de Compras (exclusivo para perfil Cliente):**

1. Cliente acessa a aba "Histórico de Compras".
2. Sistema lista os pedidos anteriores com data, itens, valor e status.
3. Cliente seleciona um pedido para ver os detalhes.
4. Sistema exibe o detalhamento completo, incluindo comprovante e receitas vinculadas.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | E-mail já Cadastrado | Sistema identifica duplicidade e solicita outro e-mail. |
| **FA02** | Senha Atual Incorreta | Ao alterar senha, se a senha atual informada for inválida, o sistema bloqueia a operação. |
| **FA03** | Sem Histórico | Sistema exibe mensagem informativa caso o cliente não possua compras anteriores. |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Include** | UC10 — Autenticar Usuário (pré-condição) |

### Diagrama de Atividades

<img width="594" height="514" alt="image" src="https://github.com/user-attachments/assets/9aaea34f-c7ff-4a47-b971-d616032510b4" />

---

## UC12 — Rastrear Pedido em Tempo Real

| Campo | Descrição |
|---|---|
| **Ator(es)** | Cliente, Sistema (Automático), Atendente (Entregador) |
| **Descrição** | Permite ao cliente acompanhar em tempo real o ciclo de vida do seu pedido, desde a confirmação do pagamento até a conclusão da entrega, com notificações automáticas a cada mudança de status. |
| **Pré-condições** | Pagamento do pedido confirmado (UC08); Cliente autenticado (UC10). |
| **Pós-condições** | Status do pedido atualizado e visível ao cliente; Histórico de rastreamento registrado. |
| **RFs relacionados** | RF09, RF23 |
| **RNs relacionadas** | RN13 |
| **RNFs relacionados** | RNF04 |

### Fluxo Principal

1. Após confirmação do pagamento (UC08), o sistema atualiza automaticamente o status para "Pagamento Aprovado".
2. Sistema dispara notificação Push ao cliente (RF23, RN13).
3. Atendente separa os produtos e atualiza o status para "Em Separação".
4. Sistema dispara nova notificação Push ao cliente.
5. Atendente inicia a entrega e atualiza o status para "Saiu para Entrega".
6. Sistema dispara nova notificação Push ao cliente.
7. Atendente confirma a entrega e realiza a baixa final no App.
8. Sistema atualiza o status para "Entregue" e encerra o ciclo do pedido.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Entrega Não Realizada | Atendente registra tentativa de entrega sem sucesso; sistema notifica o cliente e agenda nova tentativa. |
| **FA02** | Pedido Cancelado | Se o pagamento expirar ou o pedido for cancelado, sistema atualiza o status e notifica o cliente imediatamente (RN08). |
| **FA03** | Notificação Push Não Entregue | Sistema registra a falha e tenta reenvio; o status permanece atualizado na tela de rastreamento do app. |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Extend** | Estende UC08 — Processar Pagamento (ativado após confirmação) |
| **Include** | UC16 — Receber e Processar Notificação Push |

### Diagrama de Atividades

<img width="508" height="808" alt="image" src="https://github.com/user-attachments/assets/c724e209-9ac7-4871-899b-de86af00c8f4" />


---

## UC13 — Configurar e Gerenciar IA

| Campo | Descrição |
|---|---|
| **Ator(es)** | Administrador |
| **Descrição** | Permite ao Administrador ajustar os parâmetros de comportamento da IA Americana, incluindo base de conhecimento, gatilhos de transbordo, limites de resposta e configurações de OCR. |
| **Pré-condições** | Usuário autenticado com perfil Administrador (UC10). |
| **Pós-condições** | Novos parâmetros persistidos e aplicados ao comportamento da IA em tempo real. |
| **RFs relacionados** | RF20, RF24 |
| **RNs relacionadas** | RN01, RN02 |
| **RNFs relacionados** | RNF02, RNF15, RNF16 |

### Fluxo Principal

1. Administrador acessa o módulo de "Configurações da IA".
2. Sistema exibe os parâmetros atuais agrupados por categoria:
   - Comportamento de atendimento (tempo máximo de resposta, tom);
   - Gatilhos de transbordo (número de tentativas antes de acionar UC04 — RN01);
   - Base de conhecimento (produtos, posologias, FAQs);
   - Configurações de OCR (limiar de confiança — RNF15).
3. Administrador seleciona o parâmetro a alterar e informa o novo valor.
4. Sistema valida o valor dentro dos limites permitidos.
5. Sistema persiste a configuração e aplica ao módulo de IA (RNF16).
6. Sistema registra o log da alteração para auditoria.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Valor Fora do Limite Permitido | Sistema exibe a faixa de valores aceitos e solicita nova entrada (ex: limiar OCR deve ser entre 50% e 99%). |
| **FA02** | Falha na Aplicação do Parâmetro | Sistema registra o erro, reverte para a configuração anterior e notifica o Administrador. |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Extend** | Impacta diretamente o comportamento do UC04 — Realizar Transbordo |
| **Include** | UC14 — Gerenciar Acessos e Perfis (acesso restrito ao Administrador) |

### Diagrama de Atividades

<img width="427" height="587" alt="image" src="https://github.com/user-attachments/assets/154aa6d2-989c-4003-9cb6-1a356d5a1c00" />

---

## UC14 — Gerenciar Acessos e Perfis (RBAC)

| Campo | Descrição |
|---|---|
| **Ator(es)** | Administrador |
| **Descrição** | Permite ao Administrador criar, editar, suspender e revogar perfis de usuários colaboradores, definindo as permissões de acesso a telas e funcionalidades conforme a hierarquia RBAC do sistema. |
| **Pré-condições** | Usuário autenticado com perfil Administrador (UC10). |
| **Pós-condições** | Permissões do usuário atualizadas e aplicadas imediatamente na próxima sessão do colaborador. |
| **RFs relacionados** | RF18 |
| **RNs relacionadas** | RN11 |
| **RNFs relacionados** | RNF07 |

### Fluxo Principal

1. Administrador acessa o módulo de "Controle de Acessos".
2. Sistema lista todos os usuários colaboradores com nome, perfil e status (ativo/suspenso).
3. Administrador seleciona um usuário ou cria um novo.
4. Administrador define ou altera o perfil de acesso:
   - **Atendente:** acesso ao chat, histórico de clientes e catálogo;
   - **Farmacêutico:** tudo do Atendente + validação de receitas;
   - **Gerente:** tudo do Farmacêutico + relatórios e configurações da unidade;
   - **Dono:** tudo do Gerente + dashboards globais de todas as unidades.
5. Sistema salva a configuração e invalida o token atual do colaborador (se ativo), forçando novo login.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Suspender Usuário | Administrador suspende o acesso de um colaborador; sistema invalida a sessão ativa imediatamente. |
| **FA02** | Rebaixar Perfil | Sistema invalida a sessão ativa do colaborador após o rebaixamento, forçando novo login com as novas permissões. |
| **FA03** | Tentativa de Auto-Edição | Sistema impede que o Administrador altere seu próprio perfil para evitar bloqueio acidental. |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Include** | UC10 — Autenticar Usuário (pré-condição) |
| **Extend** | Controla o acesso ao UC07, UC09 e UC13 |

### Diagrama de Atividades

<img width="594" height="519" alt="image" src="https://github.com/user-attachments/assets/fe6cb68f-303d-4871-88e2-d4affa700f2c" />

---

## UC15 — Navegar no Catálogo e Consultar Produto

| Campo | Descrição |
|---|---|
| **Ator(es)** | Cliente |
| **Descrição** | Permite ao cliente navegar pelo catálogo de produtos, filtrar por categorias, realizar buscas por texto e consultar detalhes individuais de um produto (foto, descrição, preço e disponibilidade), de forma independente do fluxo de venda. |
| **Pré-condições** | Usuário autenticado (UC10); Catálogo com produtos cadastrados. |
| **Pós-condições** | Produto consultado; Cliente pode iniciar uma compra a partir do catálogo ou do chat. |
| **RFs relacionados** | RF02 |
| **RNFs relacionados** | RNF01, RNF09 |

### Fluxo Principal

1. Cliente acessa a tela inicial do app, que exibe o catálogo de produtos.
2. Sistema exibe produtos organizados por categorias com foto, nome e preço.
3. Cliente navega por categorias ou utiliza a busca por texto (nome ou fabricante).
4. Sistema retorna os resultados filtrando em tempo real (60 FPS — RNF01).
5. Cliente seleciona um produto para ver o detalhe.
6. Sistema exibe a tela do produto com foto ampliada, descrição completa, preço e indicação de disponibilidade em estoque.
7. Cliente pode iniciar a compra pelo botão "Comprar via Chat" ou retornar ao catálogo.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Nenhum Produto Encontrado | Sistema exibe mensagem informativa e sugere termos similares ou categorias relacionadas. |
| **FA02** | Produto Sem Estoque | Sistema exibe o produto com indicação visual de "Indisponível" e oculta o botão de compra. |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Extend** | Pode iniciar o UC01 — Realizar Venda (via botão "Comprar via Chat") |

### Diagrama de Atividades

<img width="594" height="569" alt="image" src="https://github.com/user-attachments/assets/61ce0412-d902-49ff-9860-c65b698e8a8a" />

---

## UC16 — Receber e Processar Notificação Push

| Campo | Descrição |
|---|---|
| **Ator(es)** | Cliente, Sistema (Automático) |
| **Descrição** | Gerencia o recebimento de notificações push pelo dispositivo do cliente e o comportamento do app ao interagir com elas, redirecionando o usuário para a tela correta conforme o tipo de notificação. |
| **Pré-condições** | Permissão de notificação push concedida pelo cliente no dispositivo; Usuário com sessão ativa ou em background. |
| **Pós-condições** | Cliente notificado sobre o evento; App redirecionado para a tela correspondente ao toque na notificação. |
| **RFs relacionados** | RF23 |
| **RNs relacionadas** | RN13 |
| **RNFs relacionados** | RNF13 |

### Fluxo Principal

1. O Sistema detecta um evento de mudança de status (pagamento, separação, entrega, receita reprovada).
2. O Sistema dispara uma notificação push para o dispositivo do cliente via serviço de push (FCM/APNs).
3. O dispositivo do cliente exibe a notificação na barra de status.
4. Cliente toca na notificação.
5. App abre (ou sai do background) e redireciona para a tela correspondente:
   - **Status de pedido** → Tela de Rastreamento (UC12);
   - **Mensagem no chat** → Tela de Chat;
   - **Receita reprovada** → Tela de Chat com a nota do Farmacêutico;
   - **Erro / Expiração de PIX** → Tela de Pagamento.

### Fluxos Alternativos / Exceções

| ID | Nome | Descrição |
|---|---|---|
| **FA01** | Permissão de Push Negada | Sistema registra a preferência e as atualizações ficam visíveis apenas na tela de notificações interna do app. |
| **FA02** | App Fechado ao Tocar na Notificação | App inicializa normalmente (UC10) e, após autenticação, redireciona para a tela correspondente ao evento. |
| **FA03** | Notificação Expirada | Se o evento já foi resolvido, o app exibe a tela correspondente com o status atualizado. |
| **FA04** | Sem Conexão (RNF13) | App enfileira a sincronização de mensagens localmente e exibe o último estado conhecido até restabelecer conexão. |

### Relacionamentos

| Tipo | Casos de Uso |
|---|---|
| **Include** | Faz parte do UC12 — Rastrear Pedido em Tempo Real |

### Diagrama de Atividades

<img width="594" height="330" alt="image" src="https://github.com/user-attachments/assets/dc539536-8fbf-4bba-b8b0-fa6ca8fe39be" />

---

> **Diretriz de Implementação:** Todas as regras de negócio devem ser validadas tanto na camada de interface (Flutter) para melhor UX quanto na camada de serviços (Backend) para garantir a integridade dos dados. Referência: RNs e RNFs deste documento.
