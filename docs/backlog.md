# Backlog — Épicos e User Stories
> Documento vivo — versão alinhada à Proposta de Solução do Ecossistema Digital da Farmácia Americana.
> Formato: **Como** [persona], **quero** [ação], **para** [benefício].

---

## [Épico 01] Identidade e Segurança (Auth & LGPD)
> Fundação de confiança do sistema. Garante que os dados dos pacientes sejam tratados com segurança e conformidade legal.

| ID | User Story | Prioridade |
|----|-----------|------------|
| US-01 | **Como** novo usuário, **quero** me cadastrar com e-mail, telefone e CPF, **para** criar minha conta na plataforma. | Alta |
| US-02 | **Como** usuário, **quero** fazer login com minha conta Google, **para** acessar o app sem precisar lembrar de uma senha extra. | Alta |
| US-03 | **Como** usuário, **quero** recuperar minha senha por e-mail, **para** não perder o acesso à minha conta. | Alta |
| US-04 | **Como** usuário, **quero** aceitar os Termos de Uso e a Política de Privacidade no cadastro, **para** entender como meus dados de saúde serão utilizados. | Alta |
| US-05 | **Como** usuário, **quero** revogar o consentimento de uso dos meus dados de saúde, **para** exercer meu direito garantido pela LGPD. | Média |
| US-06 | **Como** administrador, **quero** que o sistema diferencie permissões entre Cliente, Atendente e Admin, **para** garantir que cada perfil acesse apenas o que é pertinente. | Alta |

---

## [Épico 02] Catálogo e Experiência de Venda (E-commerce)
> Coração transacional do app. Determina a qualidade da jornada de compra autônoma do cliente.

| ID | User Story | Prioridade |
|----|-----------|------------|
| US-07 | **Como** cliente, **quero** visualizar os produtos com nome, imagem, preço e disponibilidade em estoque, **para** tomar uma decisão de compra informada. | Alta |
| US-08 | **Como** cliente, **quero** buscar um produto pelo nome ou princípio ativo com autocompletar, **para** encontrar o que preciso rapidamente mesmo sem saber a grafia exata. | Alta |
| US-09 | **Como** cliente, **quero** navegar por categorias (MIPs, Suplementos, Higiene, Controlados, Infantil), **para** descobrir produtos sem precisar saber o nome exato. | Alta |
| US-10 | **Como** cliente, **quero** adicionar, remover e alterar a quantidade de produtos no carrinho, **para** montar meu pedido sem fricção. | Alta |
| US-11 | **Como** cliente, **quero** ver produtos em destaque na Home baseados na época do ano, **para** encontrar ofertas relevantes ao meu contexto de saúde atual. | Média |
| US-12 | **Como** cliente, **quero** ver o subtotal do meu carrinho atualizado em tempo real, **para** controlar meus gastos antes de finalizar a compra. | Alta |

---

## [Épico 03] Inteligência de Atendimento — Chatbot Lumi (IA & Chat)
> O diferencial competitivo do produto. Substitui o atendimento repetitivo humano por uma IA contextual e rastreável.

| ID | User Story | Prioridade |
|----|-----------|------------|
| US-13 | **Como** cliente, **quero** conversar com o chatbot Lumi em linguagem natural, **para** tirar dúvidas sobre medicamentos sem precisar falar com um atendente. | Alta |
| US-14 | **Como** cliente, **quero** perguntar ao Lumi "o que posso tomar para dor de cabeça?", **para** receber sugestões seguras de MIPs sem automedicação perigosa. | Alta |
| US-15 | **Como** cliente, **quero** que o Lumi me avise quando meus sintomas exigem consulta médica, **para** não me arriscar com automedicação em casos sérios. | Alta |
| US-16 | **Como** cliente, **quero** que cada sessão de chat gere um número de protocolo, **para** poder retomar o atendimento com um farmacêutico humano sem repetir as informações. | Alta |
| US-17 | **Como** atendente, **quero** receber o protocolo da conversa com o contexto completo, **para** dar continuidade ao atendimento de forma ágil e informada. | Alta |
| US-18 | **Como** cliente, **quero** conseguir fechar meu pedido e pagar diretamente no chat com o Lumi, **para** não precisar sair da conversa para finalizar a compra. | Média |

---

## [Épico 04] Visão Computacional e Receitas (OCR + IA)
> Elimina o principal gargalo operacional da farmácia: a leitura manual de receitas.

| ID | User Story | Prioridade |
|----|-----------|------------|
| US-19 | **Como** cliente, **quero** fotografar minha receita médica pelo app, **para** não precisar digitar cada medicamento manualmente. | Alta |
| US-20 | **Como** cliente, **quero** que o sistema extraia os nomes dos medicamentos da receita fotografada e os adicione ao meu carrinho, **para** agilizar minha compra. | Alta |
| US-21 | **Como** cliente, **quero** que o sistema me avise se a receita está vencida ou ilegível, **para** evitar erros na minha compra. | Alta |
| US-22 | **Como** cliente, **quero** que o app verifique a disponibilidade dos medicamentos da receita em estoque antes de montar o carrinho, **para** não ser surpreendido com itens indisponíveis no checkout. | Alta |
| US-23 | **Como** sistema, **quero** bloquear a adição de medicamentos controlados ao carrinho sem validação prévia de receita, **para** garantir conformidade legal e segurança do paciente. | Alta |
| US-24 | **Como** atendente, **quero** que o sistema reserve os itens identificados na receita por 30 minutos, **para** ter tempo de confirmar o pedido sem perder o estoque para outra venda. | Média |

---

## [Épico 05] Checkout e Pagamentos (Fluxo Transacional)
> Converte intenção de compra em receita. Foco em redução de fricção e segurança.

| ID | User Story | Prioridade |
|----|-----------|------------|
| US-25 | **Como** cliente, **quero** pagar meu pedido via PIX, **para** concluir a compra de forma instantânea sem precisar de cartão. | Alta |
| US-26 | **Como** cliente, **quero** pagar meu pedido com cartão de crédito, **para** ter a opção de parcelamento. | Alta |
| US-27 | **Como** cliente, **quero** cadastrar meu endereço de entrega no checkout, **para** receber meu pedido sem precisar ir à farmácia. | Alta |
| US-28 | **Como** cliente, **quero** receber uma confirmação do meu pedido após o pagamento, **para** ter segurança de que a compra foi registrada. | Alta |

---

## [Épico 06] Fidelização e Predição (Ciclo de Saúde)
> Transforma o app de uma ferramenta de compra em um parceiro de saúde do paciente crônico.

| ID | User Story | Prioridade |
|----|-----------|------------|
| US-29 | **Como** paciente crônico, **quero** ver o histórico completo dos meus pedidos com status, **para** acompanhar minhas compras recorrentes. | Alta |
| US-30 | **Como** paciente crônico, **quero** receber uma notificação push quando meu medicamento de uso contínuo estiver prestes a acabar, **para** não interromper meu tratamento por falta de estoque. | Alta |
| US-31 | **Como** paciente crônico, **quero** repetir um pedido anterior com um único toque, **para** economizar tempo na recompra de medicamentos de uso regular. | Alta |
| US-32 | **Como** cliente, **quero** editar meu endereço e número de telefone na seção "Conta", **para** manter meus dados de entrega sempre atualizados. | Média |

---

> **Critério de Prioridade:**
> - **Alta** — Essencial para o MVP estar funcional e entregar valor ao usuário.
> - **Média** — Agrega valor mas pode ser entregue em sprint posterior sem comprometer o MVP.
> - **Baixa** — Desejável, a ser priorizado conforme capacidade do time.
