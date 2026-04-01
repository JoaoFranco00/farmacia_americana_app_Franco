# Regras de Negócio (RN) — Ecossistema Farmácia Americana 

Este documento define as diretrizes lógicas e as restrições operacionais que governam o comportamento do ecossistema Farmácia Americana (App Flutter + Backend).

---

## 1. Atendimento e Inteligência Artificial (IA) 

**RN01 — Transbordo Automático para Humano** Se a IA não identificar a intenção do usuário ou o produto desejado após 2 (duas) tentativas consecutivas, a conversa deve ser movida automaticamente para a fila de "Atendimento Humano" com prioridade alta.

**RN02 — Registro de Orientações Técnicas** Toda orientação técnica (posologia, efeitos colaterais ou dúvidas sobre bula) fornecida pela IA deve ser salva em um log inalterável vinculado ao ID da conversa para fins de auditoria.

**RN03 — Análise de Receita via IA (OCR)** A IA deve realizar a leitura preliminar (OCR) de receitas médicas para agilizar o preenchimento, porém, os dados extraídos só serão validados no sistema após confirmação humana (Atendente ou Farmacêutico).

---

## 2. Gestão de Medicamentos e Saúde 

**RN04 — Trava de Medicamento Controlado** Produtos classificados como "Medicamentos Controlados" (Tarja Preta/Vermelha sob controle) bloqueiam o checkout até que o Farmacêutico realize a validação digital da foto da receita enviada.

**RN05 — Persistência de Dados Críticos (API/BD)** Para cada venda realizada, o sistema deve obrigatoriamente persistir via API no Banco de Dados os seguintes dados:
* Identificação do(s) Produto(s);
* CPF do comprador;
* Data e hora exata da venda;
* Imagem da receita médica (se aplicável);
* CRM do Farmacêutico responsável pela validação;
* UF e CRM do Médico prescritor;
* Log completo do chat contendo toda a conversa da venda.

**RN06 — Registro Obrigatório de Prescritor** Toda venda de medicamento que exige retenção ou validação de receita deve conter o registro obrigatório do número do CRM e a Unidade Federativa (UF) do médico que emitiu a prescrição.

---

## 3. Vendas, Estoque e Checkout 

**RN07 — Disponibilidade em Tempo Real** O sistema não deve permitir a inclusão de itens no carrinho ou a finalização da compra se a quantidade solicitada for maior que o saldo em estoque físico da unidade selecionada.

**RN08 — Expiração de Chave PIX** As chaves PIX dinâmicas geradas para pagamento remoto devem expirar em exatamente **10 minutos**. Após este prazo, o pedido deve ser cancelado automaticamente e os itens devem retornar ao saldo de estoque disponível.

**RN09 — Pagamento Híbrido e Baixa Financeira** Pagamentos via PIX são validados automaticamente via Webhook bancário. Pagamentos em espécie ou cartão na entrega dependem obrigatoriamente da baixa manual do entregador via App para conclusão do fluxo.

**RN10 — Imutabilidade do Preço de Venda** O sistema deve registrar e manter o preço do produto praticado no momento exato da finalização da venda, garantindo que alterações posteriores no cadastro de produtos não afetem pedidos já concluídos.

---

## 4. Gestão de Acessos e Logística 

**RN11 — Hierarquia de Dados Financeiros (RBAC)** * **Dono:** Visualiza faturamento e indicadores de desempenho de todas as unidades.
* **Gerente:** Visualiza dados financeiros e relatórios apenas de sua unidade de lotação.
* **Demais Perfis:** Têm acesso restrito apenas às funcionalidades operacionais de sua alçada, sem acesso a dados de lucro ou faturamento global.

**RN12 — Restrição por Raio de Entrega** O sistema só deve permitir a finalização de pedidos para endereços localizados dentro do raio de entrega (quilometragem) configurado para a unidade da Farmácia Americana responsável pelo atendimento.

**RN13 — Notificação Automática de Status** O sistema deve disparar notificações Push em tempo real ao cliente a cada mudança de estado do pedido (ex: Pagamento Aprovado, Em Separação, Saiu para Entrega).

---

> **Diretriz de Implementação:** Estas regras devem ser validadas tanto na camada de interface (Flutter) para melhor UX, quanto na camada de serviços (Backend) para garantir a integridade dos dados.