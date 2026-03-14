# Regras de Negócio (RN)
> **Restrições e políticas que o sistema deve respeitar independentemente de quem o usa.**
> Documento vivo — versão alinhada à Proposta de Solução do Ecossistema Digital da Farmácia Americana.

---

## Atendimento e IA

### RN01 - Limite de Atuação da IA
A IA (Lumi) não deve realizar diagnósticos médicos nem indicar medicamentos ao usuário. Sua atuação se limita a: reconhecer dúvidas frequentes, fornecer orientações básicas de posologia e modo de uso de medicamentos já adquiridos, e encaminhar casos que ultrapassem esse escopo para um atendente humano.

### RN02 - Proibição de Indicação de Remédios pela IA
O Lumi não deve, em nenhuma circunstância, sugerir, recomendar ou indicar medicamentos ao usuário — seja por nome comercial, princípio ativo ou categoria. Qualquer pergunta do tipo "o que posso tomar para X?" deve ser encaminhada obrigatoriamente para um atendente humano.

### RN03 - Encaminhamento Obrigatório de Casos Complexos
Quando o Lumi identificar que a dúvida envolve: sintomas, interações medicamentosas, indicação de remédios, receitas médicas, reclamações ou qualquer situação que exija julgamento clínico ou comercial, o atendimento deve ser encaminhado automaticamente para um atendente humano. O encaminhamento deve incluir o histórico completo da conversa via protocolo.

### RN04 - Fluxo de Contingência do OCR
Caso a IA não consiga identificar com clareza os medicamentos de uma receita (leitura parcial ou ilegível), o atendimento deve ser obrigatoriamente transferido para um atendente humano, com o protocolo da sessão repassado automaticamente.

### RN05 - Geração Obrigatória de Protocolo
Todo atendimento iniciado pelo chatbot deve gerar um número de protocolo único. Esse protocolo deve ser visível ao usuário e acessível ao atendente para fins de continuidade e rastreabilidade, independentemente de o atendimento ter sido resolvido pela IA ou encaminhado para humano.

---

## Receitas e Medicamentos Controlados

### RN06 - Trava de Medicamentos Controlados
É proibido adicionar ao carrinho ou finalizar a venda de medicamentos controlados sem o upload prévio e a validação bem-sucedida da receita médica via OCR.

### RN07 - Validade da Receita
O sistema deve verificar a data de emissão da receita. Receitas com data de validade expirada (conforme legislação vigente da Anvisa) devem ser recusadas, com mensagem explicativa ao usuário.

### RN08 - Reserva Temporária de Estoque
Após a validação de uma receita com medicamentos disponíveis, o sistema deve reservar os itens identificados no estoque por **30 minutos**. Expirado esse prazo sem finalização do pedido, a reserva deve ser cancelada automaticamente.

---

## Cadastro e Dados do Usuário

### RN09 - Cadastro Obrigatório para Compra
O usuário pode navegar pelo catálogo e usar o chatbot sem cadastro. Porém, para finalizar qualquer compra, o cadastro completo (e-mail, telefone e CPF) é obrigatório.

### RN10 - CPF Único por Conta
Cada CPF pode estar vinculado a apenas uma conta ativa no sistema, prevenindo duplicidade de cadastro.

### RN11 - Consentimento Explícito para Dados de Saúde
O armazenamento de dados relacionados à saúde do usuário (histórico de medicamentos, receitas, ciclo de uso) só pode ocorrer mediante aceite explícito dos termos de consentimento, em conformidade com a LGPD.

---

## Pagamentos e Pedidos

### RN12 - Confirmação de Pagamento Antes do Processamento
Nenhum pedido deve ser encaminhado para separação ou entrega antes da confirmação do pagamento pela API de terceiros. O status do pedido deve permanecer como "Aguardando pagamento" até essa confirmação.

### RN13 - Notificação de Recompra Baseada em Ciclo Real
A notificação push de recompra de medicamentos de uso contínuo só deve ser disparada quando o sistema identificar, com base no histórico de compras, um padrão recorrente de pelo menos **2 pedidos anteriores** do mesmo item.

---

> **Distinção importante:**
> Regras de Negócio (RN) definem **o que é permitido ou proibido** no domínio do negócio.
> Requisitos Funcionais (RF) definem **o que o sistema deve fazer**.
> Requisitos Não Funcionais (RNF) definem **como o sistema deve se comportar**.
> Os três documentos são complementares e devem ser consultados em conjunto.
