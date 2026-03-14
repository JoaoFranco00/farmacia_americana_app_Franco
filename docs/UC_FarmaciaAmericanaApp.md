# Casos de Uso (UC)
> Documento vivo — versão alinhada à Proposta de Solução do Ecossistema Digital da Farmácia Americana.
> Base: RF, RNF, RN e Backlog — Versões Finais.

---

## UC01 — Realizar Cadastro

### Ator Principal
Usuário (Cliente)

### Objetivo
Permitir que um novo usuário crie sua conta na plataforma para acessar as funcionalidades de compra.

### Pré-condições
- O usuário não deve possuir cadastro ativo com o mesmo CPF ou e-mail.

### Pós-condições
- Conta criada com sucesso e sessão iniciada automaticamente.
- Aceite dos Termos de Uso e Política de Privacidade registrado no sistema.

### Fluxo Principal
1. O usuário acessa a tela de cadastro.
2. O sistema exibe os campos: nome, e-mail, telefone e CPF.
3. O usuário preenche os campos e avança.
4. O sistema exibe os Termos de Uso e a Política de Privacidade.
5. O usuário aceita os termos.
6. O sistema valida os dados e verifica se o CPF e o e-mail já estão cadastrados.
7. O sistema cria a conta e inicia a sessão do usuário.

### Fluxos Alternativos
- **A1 — CPF já cadastrado:**
  O sistema exibe mensagem informando que já existe uma conta vinculada ao CPF informado.

- **A2 — E-mail já cadastrado:**
  O sistema exibe mensagem informando que o e-mail já está em uso e sugere recuperação de acesso.

- **A3 — Usuário não aceita os termos:**
  O sistema bloqueia a criação da conta e informa que o aceite é obrigatório.

- **A4 — Cadastro via Google:**
  O sistema redireciona para o fluxo OAuth 2.0 do Google. Após autenticação, os dados básicos são preenchidos automaticamente e o usuário é direcionado para aceite dos termos.

### RF Relacionados
- RF13 - Cadastro e Autenticação
- RF17 - Consentimento LGPD

### RNF Relacionados
- RNF01 - Proteção de Dados Sensíveis (LGPD)
- RNF02 - Autenticação Segura
- RNF13 - Onboarding Intuitivo

### RN Relacionadas
- RN08 - Cadastro Obrigatório para Compra
- RN09 - CPF Único por Conta
- RN10 - Consentimento Explícito para Dados de Saúde

---

## UC02 — Realizar Login

### Ator Principal
Usuário (Cliente)

### Objetivo
Permitir que o usuário acesse o sistema com uma conta já existente.

### Pré-condições
- O usuário deve possuir cadastro ativo.

### Pós-condições
- Sessão iniciada com sucesso e usuário redirecionado para a tela inicial (Home).

### Fluxo Principal
1. O usuário acessa a tela de login.
2. O usuário informa e-mail e senha.
3. O sistema valida as credenciais.
4. O sistema gera um token JWT e inicia a sessão.
5. O usuário é redirecionado para a Home.

### Fluxos Alternativos
- **A1 — Senha incorreta:**
  O sistema exibe mensagem de erro genérica (sem indicar qual campo está errado, por segurança).

- **A2 — Conta não encontrada:**
  O sistema exibe mensagem informando que não existe conta com o e-mail informado.

- **A3 — Login via Google:**
  O sistema redireciona para o fluxo OAuth 2.0 do Google e autentica o usuário automaticamente.

- **A4 — Recuperação de senha:**
  O usuário solicita recuperação. O sistema envia um link de redefinição para o e-mail cadastrado.

### RF Relacionados
- RF13 - Cadastro e Autenticação

### RNF Relacionados
- RNF02 - Autenticação Segura

### RN Relacionadas
- RN08 - Cadastro Obrigatório para Compra

---

## UC03 — Buscar e Navegar pelo Catálogo

### Ator Principal
Usuário (Cliente)

### Objetivo
Permitir que o usuário encontre produtos pelo catálogo, seja por busca direta ou navegando por categorias.

### Pré-condições
- Nenhuma. O catálogo deve ser acessível sem login.

### Pós-condições
- O usuário visualiza os produtos desejados com informações completas.

### Fluxo Principal
1. O usuário acessa a Home ou a tela de Categorias.
2. O sistema exibe os produtos disponíveis com nome, imagem, preço e status de estoque.
3. O usuário digita um termo na barra de busca.
4. O sistema retorna os resultados com autocompletar e tolerância a erros ortográficos.
5. O usuário seleciona um produto para ver seus detalhes.

### Fluxos Alternativos
- **A1 — Navegação por Categorias:**
  O usuário seleciona uma categoria (MIPs, Suplementos, Higiene, Controlados, Infantil). O sistema filtra e exibe apenas os produtos daquela categoria.

- **A2 — Nenhum resultado encontrado:**
  O sistema exibe mensagem informando que nenhum produto foi encontrado para o termo pesquisado e sugere termos relacionados.

- **A3 — Produto indisponível:**
  O sistema exibe o produto mas indica "Indisponível no momento", bloqueando a opção de adicionar ao carrinho.

### RF Relacionados
- RF01 - Catálogo Dinâmico
- RF02 - Busca Inteligente
- RF04 - Gestão de Categorias
- RF05 - Recomendações Sazonais

### RNF Relacionados
- RNF05 - Tempo de Carregamento da Home

### RN Relacionadas
- *(Nenhuma restrição de negócio direta para navegação sem compra)*

---

## UC04 — Gerenciar Carrinho de Compras

### Ator Principal
Usuário (Cliente)

### Objetivo
Permitir que o usuário monte seu pedido adicionando, ajustando e removendo itens antes do checkout.

### Pré-condições
- O produto deve estar disponível em estoque.

### Pós-condições
- Carrinho atualizado e pronto para o fluxo de checkout.

### Fluxo Principal
1. O usuário seleciona um produto no catálogo e toca em "Adicionar ao Carrinho".
2. O sistema adiciona o item e atualiza o subtotal em tempo real.
3. O usuário acessa a tela do Carrinho.
4. O usuário ajusta quantidades ou remove itens conforme necessário.
5. O sistema recalcula o subtotal a cada alteração.
6. O usuário avança para o checkout.

### Fluxos Alternativos
- **A1 — Tentativa de adicionar Medicamento Controlado:**
  O sistema bloqueia a adição e redireciona o usuário para o fluxo de envio de receita (UC06) antes de prosseguir.

- **A2 — Item esgota durante a sessão:**
  O sistema notifica o usuário que o item não está mais disponível e o remove automaticamente do carrinho.

### RF Relacionados
- RF03 - Carrinho de Compras

### RNF Relacionados
- RNF07 - Uptime do Sistema

### RN Relacionadas
- RN05 - Trava de Medicamentos Controlados

---

## UC05 — Interagir com o Chatbot Lumi

### Ator Principal
Usuário (Cliente)

### Objetivo
Permitir que o usuário tire dúvidas sobre medicamentos, receba indicações de MIPs e obtenha suporte de atendimento em linguagem natural.

### Pré-condições
- Nenhuma. O chat deve ser acessível sem login para consultas gerais.

### Pós-condições
- Dúvida do usuário respondida e protocolo de atendimento gerado.

### Fluxo Principal
1. O usuário acessa a tela de Atendimento e inicia uma conversa com o Lumi.
2. O sistema gera um número de protocolo único para a sessão.
3. O usuário descreve seus sintomas ou dúvidas em linguagem natural.
4. O Lumi processa a mensagem e retorna uma resposta baseada em MIPs e protocolos de saúde pública.
5. O usuário pode continuar a conversa ou encerrar o atendimento.

### Fluxos Alternativos
- **A1 — Sintomas fora do escopo dos MIPs:**
  O Lumi identifica que os sintomas exigem avaliação médica, informa o usuário e não sugere nenhum medicamento para a situação.

- **A2 — Usuário solicita indicação de controlado:**
  O Lumi informa que não pode indicar medicamentos de uso controlado e orienta o usuário a consultar um farmacêutico.

- **A3 — Transbordo para atendente humano:**
  O usuário solicita falar com um atendente. O sistema encerra a sessão de IA e repassa o protocolo com o histórico completo da conversa para o atendente.

- **A4 — Pagamento pelo chat:**
  O usuário decide finalizar uma compra dentro do chat. O sistema redireciona para o fluxo de checkout (UC07) sem encerrar a sessão.

### RF Relacionados
- RF06 - Chatbot de Triagem (Lumi)
- RF10 - Protocolo de Atendimento
- RF11 - Pagamento Conversacional

### RNF Relacionados
- RNF06 - Latência do Chatbot
- RNF11 - Escalabilidade do Chatbot

### RN Relacionadas
- RN01 - Limite de Atuação da IA
- RN02 - Alerta de Encaminhamento Médico
- RN04 - Geração Obrigatória de Protocolo

---

## UC06 — Enviar e Processar Receita Médica (OCR)

### Ator Principal
Usuário (Cliente)

### Objetivo
Permitir que o usuário fotografe uma receita médica e tenha os medicamentos identificados e adicionados automaticamente ao carrinho.

### Pré-condições
- O usuário deve estar autenticado.
- O dispositivo deve ter câmera disponível ou permitir upload de imagem.

### Pós-condições
- Medicamentos identificados adicionados ao carrinho.
- Itens reservados no estoque por 30 minutos.
- Protocolo gerado para rastreabilidade.

### Fluxo Principal
1. O usuário acessa a opção de envio de receita (via chat ou carrinho).
2. O usuário fotografa a receita ou faz upload de uma imagem existente.
3. O sistema envia a imagem para o módulo de OCR com IA.
4. A IA extrai os nomes dos medicamentos e valida a data de emissão e o CRM do prescritor.
5. O sistema verifica a disponibilidade de cada medicamento no estoque.
6. Os medicamentos disponíveis são adicionados ao carrinho e reservados por 30 minutos.
7. O sistema exibe um resumo ao usuário com os itens identificados.

### Fluxos Alternativos
- **A1 — Receita ilegível ou leitura parcial:**
  O sistema informa o usuário que não foi possível processar a receita e transfere o atendimento para um farmacêutico humano com o protocolo da sessão.

- **A2 — Receita vencida:**
  O sistema identifica que a data de validade expirou, recusa o processamento e exibe mensagem explicativa ao usuário.

- **A3 — Medicamento identificado mas indisponível no estoque:**
  O sistema informa quais itens não estão disponíveis e adiciona apenas os disponíveis ao carrinho.

- **A4 — Reserva expirada sem finalização:**
  Após 30 minutos, o sistema cancela automaticamente a reserva e libera os itens no estoque.

### RF Relacionados
- RF07 - OCR de Receitas
- RF08 - Validação de Receita por IA
- RF09 - Trava de Segurança para Controlados
- RF10 - Protocolo de Atendimento

### RNF Relacionados
- RNF04 - Tempo de Resposta do OCR
- RNF01 - Proteção de Dados Sensíveis (LGPD)

### RN Relacionadas
- RN05 - Trava de Medicamentos Controlados
- RN06 - Validade da Receita
- RN07 - Reserva Temporária de Estoque
- RN03 - Fluxo de Contingência do OCR

---

## UC07 — Finalizar Compra (Checkout)

### Ator Principal
Usuário (Cliente)

### Objetivo
Permitir que o usuário conclua seu pedido escolhendo o método de pagamento e confirmando o endereço de entrega.

### Pré-condições
- O usuário deve estar autenticado e com cadastro completo.
- O carrinho deve conter ao menos um item disponível.

### Pós-condições
- Pedido registrado no sistema com status "Aguardando pagamento".
- Após confirmação do pagamento, status atualizado para "Em preparo".
- Confirmação enviada ao usuário.

### Fluxo Principal
1. O usuário acessa o carrinho e toca em "Finalizar Compra".
2. O sistema exibe o endereço de entrega cadastrado para confirmação.
3. O usuário confirma ou edita o endereço.
4. O sistema exibe as opções de pagamento: PIX ou Cartão de Crédito.
5. O usuário seleciona o método e conclui o pagamento via API de terceiros.
6. O sistema aguarda a confirmação da API de pagamento.
7. Confirmado o pagamento, o sistema registra o pedido como "Em preparo" e envia confirmação ao usuário.

### Fluxos Alternativos
- **A1 — Usuário não autenticado:**
  O sistema interrompe o checkout e redireciona para o login/cadastro. Após autenticação, retorna ao carrinho.

- **A2 — Falha na API de Pagamento:**
  O sistema exibe mensagem de erro, mantém o carrinho intacto e orienta o usuário a tentar novamente.

- **A3 — Pagamento via PIX:**
  O sistema gera o QR Code e o código copia-e-cola. O pedido permanece como "Aguardando pagamento" até a confirmação.

- **A4 — Reserva de estoque expirada durante o checkout:**
  O sistema alerta o usuário que um ou mais itens não estão mais reservados e solicita confirmação para tentar nova reserva.

### RF Relacionados
- RF12 - Métodos de Pagamento
- RF13 - Cadastro e Autenticação
- RF14 - Perfil e Gerenciamento de Conta

### RNF Relacionados
- RNF01 - Proteção de Dados Sensíveis (LGPD)
- RNF08 - Tratamento de Falhas

### RN Relacionadas
- RN08 - Cadastro Obrigatório para Compra
- RN11 - Confirmação de Pagamento Antes do Processamento

---

## UC08 — Receber Notificação e Repetir Pedido Recorrente

### Ator Principal
Usuário (Cliente — Paciente Crônico)

### Objetivo
Permitir que o sistema antecipe a necessidade de recompra de medicamentos de uso contínuo e que o usuário repita o pedido com um único toque.

### Pré-condições
- O usuário deve ter ao menos 2 pedidos anteriores do mesmo medicamento registrados.
- As notificações push devem estar habilitadas no dispositivo.

### Pós-condições
- Novo pedido adicionado ao carrinho ou confirmado diretamente.
- Usuário redirecionado para o checkout.

### Fluxo Principal
1. O sistema analisa o histórico de compras e detecta um padrão recorrente de medicamento de uso contínuo.
2. O sistema calcula a data estimada de término do estoque pessoal do usuário.
3. O sistema dispara uma notificação push com a mensagem de alerta de recompra.
4. O usuário toca na notificação.
5. O app abre diretamente com o medicamento pré-adicionado ao carrinho.
6. O usuário confirma e é redirecionado para o checkout (UC07).

### Fluxos Alternativos
- **A1 — Usuário ignora a notificação:**
  Nenhuma ação é tomada. O sistema pode reenviar a notificação após intervalo configurável.

- **A2 — Medicamento indisponível no momento da notificação:**
  A notificação informa a indisponibilidade e sugere ao usuário entrar em contato pelo chat.

- **A3 — Usuário deseja alterar o pedido:**
  O usuário acessa o carrinho normalmente e ajusta as quantidades antes de finalizar.

### RF Relacionados
- RF15 - Histórico de Compras
- RF16 - Predição de Recompra (Ciclo de Saúde)

### RNF Relacionados
- RNF11 - Escalabilidade do Chatbot
- RNF07 - Uptime do Sistema

### RN Relacionadas
- RN12 - Notificação de Recompra Baseada em Ciclo Real

---

## UC09 — Gerenciar Perfil e Dados da Conta

### Ator Principal
Usuário (Cliente)

### Objetivo
Permitir que o usuário visualize e edite seus dados cadastrais, endereço de entrega e preferências de privacidade diretamente pela seção "Conta" do app.

### Pré-condições
- O usuário deve estar autenticado.

### Pós-condições
- Dados atualizados persistidos no sistema.
- Alterações refletidas imediatamente nos próximos fluxos de checkout e notificação.

### Fluxo Principal
1. O usuário acessa a seção "Conta" pelo menu inferior.
2. O sistema exibe os dados cadastrais atuais: nome, e-mail, telefone e endereço de entrega.
3. O usuário seleciona o campo que deseja editar.
4. O usuário altera o valor e confirma.
5. O sistema valida e salva as alterações.
6. O sistema exibe confirmação visual da atualização.

### Fluxos Alternativos
- **A1 — Novo telefone já vinculado a outra conta:**
  O sistema exibe mensagem de conflito e solicita que o usuário informe outro número.

- **A2 — Usuário deseja revogar consentimento de dados de saúde:**
  O sistema exibe um aviso explicando as implicações (desativação do histórico de medicamentos e predição de ciclo). Após confirmação, o consentimento é revogado e os dados de saúde são anonimizados.

- **A3 — Usuário deseja excluir a conta:**
  O sistema exibe aviso sobre a irreversibilidade da ação. Após confirmação, a conta é desativada e os dados são tratados conforme a política de retenção da LGPD.

### RF Relacionados
- RF14 - Perfil e Gerenciamento de Conta
- RF17 - Consentimento LGPD

### RNF Relacionados
- RNF01 - Proteção de Dados Sensíveis (LGPD)
- RNF03 - Controle de Acesso por Função

### RN Relacionadas
- RN09 - CPF Único por Conta
- RN10 - Consentimento Explícito para Dados de Saúde

---

## UC10 — Consultar Histórico de Pedidos

### Ator Principal
Usuário (Cliente)

### Objetivo
Permitir que o usuário acesse o histórico completo de suas compras, acompanhe o status de pedidos em aberto e inicie uma recompra a partir de um pedido anterior.

### Pré-condições
- O usuário deve estar autenticado.
- O usuário deve ter ao menos um pedido registrado.

### Pós-condições
- O usuário visualiza o histórico com os detalhes e status de cada pedido.

### Fluxo Principal
1. O usuário acessa a seção "Conta" e seleciona "Histórico de Pedidos".
2. O sistema lista todos os pedidos em ordem cronológica decrescente.
3. Cada pedido exibe: data, itens comprados, valor total e status atual.
4. O usuário seleciona um pedido para ver os detalhes completos.
5. O sistema exibe a tela de detalhe com todos os itens, forma de pagamento e endereço de entrega utilizado.

### Fluxos Alternativos
- **A1 — Repetir pedido anterior:**
  O usuário toca em "Repetir Pedido" em um registro do histórico. O sistema adiciona os mesmos itens ao carrinho, verificando disponibilidade atual de estoque para cada um, e redireciona para o checkout (UC07).

- **A2 — Item do pedido anterior indisponível na recompra:**
  O sistema informa quais itens não estão disponíveis e adiciona apenas os disponíveis ao carrinho, exibindo um aviso.

- **A3 — Nenhum pedido encontrado:**
  O sistema exibe mensagem orientando o usuário a realizar sua primeira compra.

### RF Relacionados
- RF15 - Histórico de Compras

### RNF Relacionados
- RNF07 - Uptime do Sistema
- RNF03 - Controle de Acesso por Função

### RN Relacionadas
- RN11 - Confirmação de Pagamento Antes do Processamento

---

## UC11 — Atendente Receber e Responder Protocolo de Atendimento

### Ator Principal
Atendente (Farmacêutico)

### Objetivo
Permitir que o atendente acesse os protocolos gerados pelo chatbot Lumi, visualize o contexto completo da conversa e dê continuidade ao atendimento de forma ágil quando necessário.

### Pré-condições
- O atendente deve estar autenticado com perfil "Atendente" ou "Administrador".
- Deve existir ao menos um protocolo aberto ou transferido para atendimento humano.

### Pós-condições
- Atendimento continuado com contexto preservado.
- Protocolo atualizado com o registro da intervenção humana.

### Fluxo Principal
1. O atendente acessa o painel de protocolos.
2. O sistema lista os protocolos ativos, ordenados por prioridade e hora de abertura.
3. O atendente seleciona um protocolo.
4. O sistema exibe o histórico completo da conversa do usuário com o Lumi, incluindo sintomas relatados, produtos consultados e receitas enviadas.
5. O atendente analisa o contexto e inicia a resposta ao usuário.
6. O atendente encerra o protocolo após resolução, registrando o desfecho.

### Fluxos Alternativos
- **A1 — Protocolo transferido por falha de OCR:**
  O sistema sinaliza o protocolo com a flag "OCR Incompleto" e exibe a imagem da receita original para análise manual do atendente.

- **A2 — Protocolo sem resposta do usuário:**
  Após tempo configurável sem interação do usuário, o protocolo é arquivado automaticamente com status "Encerrado por inatividade".

- **A3 — Atendente redireciona para outro setor:**
  O atendente pode transferir o protocolo para outro perfil de atendente, mantendo o histórico intacto.

### RF Relacionados
- RF06 - Chatbot de Triagem (Lumi)
- RF10 - Protocolo de Atendimento
- RF07 - OCR de Receitas

### RNF Relacionados
- RNF03 - Controle de Acesso por Função
- RNF11 - Escalabilidade do Chatbot
- RNF07 - Uptime do Sistema

### RN Relacionadas
- RN03 - Fluxo de Contingência do OCR
- RN04 - Geração Obrigatória de Protocolo

---

## UC12 — Visualizar Recomendações Sazonais na Home

### Ator Principal
Usuário (Cliente)

### Objetivo
Permitir que o usuário descubra produtos relevantes ao contexto atual (sazonalidade, promoções e histórico) diretamente na tela inicial, sem necessidade de busca ativa.

### Pré-condições
- Nenhuma. A Home deve ser acessível sem login.
- As regras de recomendação sazonal devem estar configuradas pelo administrador.

### Pós-condições
- O usuário visualiza produtos em destaque relevantes ao momento.
- O usuário pode adicionar produtos diretamente ao carrinho a partir da Home.

### Fluxo Principal
1. O usuário abre o app e é direcionado para a Home.
2. O sistema carrega o bloco de destaques sazonais com base nas regras configuradas (ex: antialérgicos no inverno, protetor solar no verão).
3. O sistema exibe os produtos em destaque com nome, imagem, preço e disponibilidade.
4. O usuário toca em um produto para ver os detalhes ou o adiciona diretamente ao carrinho.

### Fluxos Alternativos
- **A1 — Usuário autenticado com histórico:**
  O sistema personaliza o bloco de destaques cruzando as regras sazonais com os produtos mais comprados pelo usuário, priorizando relevância individual.

- **A2 — Produto em destaque esgotado:**
  O sistema substitui automaticamente o produto esgotado pelo próximo da fila de destaques configurada, sem exibir lacunas na vitrine.

- **A3 — Falha no carregamento dos destaques:**
  O sistema exibe o catálogo padrão sem o bloco sazonal e registra o incidente em log, sem travar a tela.

### RF Relacionados
- RF01 - Catálogo Dinâmico
- RF05 - Recomendações Sazonais

### RNF Relacionados
- RNF05 - Tempo de Carregamento da Home
- RNF08 - Tratamento de Falhas

### RN Relacionadas
- *(Nenhuma restrição de negócio direta para visualização de vitrine)*

---

## UC13 — Administrador Gerenciar Catálogo de Produtos

### Ator Principal
Administrador

### Objetivo
Permitir que o administrador cadastre, edite, ative e desative produtos no catálogo, mantendo o estoque e as informações da vitrine sempre atualizados.

### Pré-condições
- O usuário deve estar autenticado com perfil "Administrador".

### Pós-condições
- Catálogo atualizado e refletido em tempo real para todos os clientes.

### Fluxo Principal
1. O administrador acessa o painel de gestão de produtos.
2. O sistema lista todos os produtos cadastrados com nome, categoria, preço e status (ativo/inativo).
3. O administrador seleciona a ação desejada: cadastrar novo produto, editar produto existente ou alterar status.
4. Para cadastro: o administrador preenche nome, descrição, imagem, preço, categoria e quantidade em estoque.
5. O sistema valida os campos obrigatórios e salva o produto.
6. O produto é publicado imediatamente no catálogo com o status configurado.

### Fluxos Alternativos
- **A1 — Produto duplicado:**
  O sistema identifica um produto com nome idêntico já cadastrado e exibe um aviso, solicitando confirmação antes de prosseguir.

- **A2 — Desativar produto com estoque disponível:**
  O sistema exibe um aviso informando que o produto possui estoque e solicita confirmação da desativação.

- **A3 — Atualização de estoque:**
  O administrador pode editar apenas a quantidade em estoque de um produto sem precisar editar os demais campos, agilizando o processo de reposição.

- **A4 — Produto da categoria "Controlados":**
  O sistema aplica automaticamente a flag de trava de receita ao produto, sem necessidade de configuração manual pelo administrador.

### RF Relacionados
- RF01 - Catálogo Dinâmico
- RF04 - Gestão de Categorias
- RF09 - Trava de Segurança para Controlados

### RNF Relacionados
- RNF03 - Controle de Acesso por Função
- RNF12 - Arquitetura Orientada a Serviços

### RN Relacionadas
- RN05 - Trava de Medicamentos Controlados

---

> **Convenção de nomenclatura:**
> - **Fluxo Principal** — caminho feliz, sem erros ou desvios.
> - **Fluxos Alternativos** — variações válidas ou erros tratáveis pelo sistema.
> Os UCs cobrem os principais fluxos definidos nos Épicos 01 a 06 do Backlog.
