# Requisitos Funcionais (RF) — Ecossistema Farmácia Americana

Este documento detalha as funcionalidades que o sistema deve oferecer para atender aos usuários e às regras de negócio estabelecidas.

---

## 1. Módulo do Cliente (Interface Mobile Flutter)

**RF01 — Cadastro e Autenticação de Usuário**
O sistema deve permitir que o cliente realize o registro e login utilizando CPF, e-mail e senha.

**RF02 — Catálogo de Produtos e Busca**
O sistema deve exibir produtos com fotos, descrições e preços, permitindo a navegação por categorias e a busca por texto (nome do produto ou fabricante).

**RF03 — Chat Híbrido Automático**
O sistema deve prover uma interface de chat nativa onde o cliente interage com a IA para tirar dúvidas, consultar posologia e selecionar itens.

**RF04 — Transbordo de Atendimento**
O sistema deve permitir que o cliente solicite ou seja transferido automaticamente para um atendente humano caso a IA não consiga resolver a demanda.

**RF05 — Seleção de Produtos via Chat**
O sistema deve permitir que o cliente adicione produtos ao carrinho de compras diretamente pela interface de conversa, sem necessidade de navegar pelo catálogo manual.

**RF06 — Upload de Receita Médica**
O sistema deve permitir o envio de fotos de receitas médicas diretamente no chat para a validação de medicamentos controlados.

**RF07 — Checkout e Pagamento Remoto (PIX)**
O sistema deve gerar chaves PIX dinâmicas com tempo de expiração de 10 minutos para finalização da compra de forma remota.

**RF08 — Seleção de Pagamento Presencial**
O sistema deve permitir que o cliente opte pelo pagamento em dinheiro ou cartão no momento da entrega física dos produtos.

**RF09 — Rastreamento de Pedido**
O sistema deve exibir em tempo real o status do pedido (Aprovado, Em Separação, Saiu para Entrega) e o histórico de atualizações.

**RF10 — Gestão de Perfil e Histórico**
O sistema deve permitir que o cliente visualize suas compras anteriores, receitas enviadas e realize a alteração de seus dados cadastrais.

---

## 2. Módulo de Atendimento (Atendente e Farmacêutico)

**RF11 — Gestão de Fila de Conversas**
O sistema deve listar os chats ativos em um painel administrativo, permitindo filtros por data (dia/mês/ano) e status do atendimento (IA ou Humano).

**RF12 — Visualização de Histórico do Cliente**
O sistema deve permitir a busca de perfis de clientes por CPF, e-mail ou nome para acessar o histórico completo de compras e logs de conversas anteriores.

**RF13 — Validação Técnica de Receita**
O sistema deve fornecer uma tela para o farmacêutico visualizar o contexto da compra e a imagem da receita enviada. O sistema deve permitir:
* Aprovar o item para continuidade da venda;
* Não aprovar o item, tornando obrigatória a inserção de uma nota de explicação que será enviada automaticamente ao cliente através do chat.

**RF14 — Edição de Catálogo e Estoque**
O sistema deve permitir que usuários autorizados realizem a alteração de preços, descrições e a atualização do saldo de estoque dos produtos por unidade.

**RF15 — Registro de Dados de Venda (API/BD)**
O sistema deve persistir obrigatoriamente no banco de dados o log do chat, imagem da receita, CRM do validador, CRM/UF do médico e CPF do comprador.

---

## 3. Módulo de Gestão (Gerente, Dono e Administrador)

**RF16 — Geração de Relatórios de Vendas**
O sistema deve emitir relatórios detalhados de faturamento e lista de produtos mais vendidos por unidade e período.

**RF17 — Dashboards de Indicadores (BI)**
O sistema deve exibir gráficos de ticket médio, taxa de recorrência de clientes e métricas de performance da IA.

**RF18 — Controle de Acessos (RBAC)**
O sistema deve permitir ao administrador configurar e gerenciar as permissões de acesso para cada perfil de usuário (Atendente, Farmacêutico, Gerente e Dono).

**RF19 — Configuração de Logística**
O sistema deve permitir a definição do raio de entrega (em quilômetros) permitido para cada unidade física da farmácia.

**RF20 — Gestão de Configurações da IA**
O sistema deve permitir o ajuste de parâmetros de resposta, base de conhecimento e gatilhos de transbordo da inteligência artificial.

---

## 4. Funcionalidades de Sistema (Automatismos e Integrações)

**RF21 — Extração de Dados via OCR**
O sistema deve processar imagens de receitas médicas para extrair automaticamente dados do médico (CRM/UF) e do medicamento para auxílio na conferência técnica.

**RF22 — Confirmação Automática de PIX**
O sistema deve integrar-se via Webhook com o gateway de pagamento para confirmar transações PIX de forma automática.

**RF23 — Notificações Push**
O sistema deve disparar alertas automáticos ao cliente sobre mudanças de status de pedidos, novas mensagens no chat e notificações de erro/reprovação de receitas.

**RF24 — Auditoria de Logs Técnicos**
O sistema deve gerar logs persistentes de todas as orientações técnicas e farmacêuticas fornecidas pela IA aos clientes.