# Requisitos Não Funcionais (RNF)
> **Como o sistema deve se comportar — qualidade, restrições e atributos de operação.**
> Documento vivo — versão alinhada à Proposta de Solução do Ecossistema Digital da Farmácia Americana.

---

## Segurança

### RNF01 - Proteção de Dados Sensíveis (LGPD)
Os dados de saúde, CPF e informações de pagamento devem ser criptografados em trânsito (TLS 1.2+) e em repouso (AES-256), seguindo integralmente a Lei Geral de Proteção de Dados (Lei nº 13.709/2018).

### RNF02 - Autenticação Segura
O sistema deve implementar autenticação via tokens JWT com expiração configurável. O login social (Google) deve ser gerenciado por OAuth 2.0. Dados de senha nunca devem ser armazenados em texto puro.

### RNF03 - Controle de Acesso por Função
O sistema deve diferenciar permissões entre perfis: **Cliente**, **Atendente** e **Administrador**, garantindo que cada perfil acesse apenas os recursos pertinentes à sua função.

---

## Performance

### RNF04 - Tempo de Resposta do OCR
O processamento de OCR em uma receita fotografada não deve exceder **5 segundos** em condições normais de rede (4G/Wi-Fi estável).

### RNF05 - Tempo de Carregamento da Home
A tela inicial (Home/Sales) deve carregar e exibir o conteúdo principal em no máximo **3 segundos** em conexões 4G.

### RNF06 - Latência do Chatbot
O chatbot (Lumi) deve retornar a primeira resposta ao usuário em no máximo **4 segundos** após o envio da mensagem.

---

## Disponibilidade e Confiabilidade

### RNF07 - Uptime do Sistema
O sistema deve estar operacional pelo menos **99% do tempo** (equivalente a menos de 87,6 horas de inatividade por ano), garantindo continuidade no fluxo de vendas.

### RNF08 - Tratamento de Falhas
Em caso de indisponibilidade de serviços externos (API de pagamento, serviço de IA), o sistema deve exibir mensagens de erro claras ao usuário e registrar o incidente em log, sem travar ou fechar o aplicativo inesperadamente.

---

## Portabilidade e Compatibilidade

### RNF09 - Multiplataforma (Flutter)
O app deve ser desenvolvido em **Flutter**, garantindo performance nativa em Android (versão 8.0+) e iOS (versão 14+) a partir de um único código-fonte.

### RNF10 - Responsividade de Layout
A interface deve se adaptar corretamente a diferentes tamanhos de tela, desde smartphones compactos (≈ 5") até tablets (≈ 10"), sem quebra de layout ou elementos sobrepostos.

---

## Escalabilidade e Arquitetura

### RNF11 - Escalabilidade do Chatbot
A arquitetura do módulo de IA (Lumi) deve suportar múltiplos atendimentos simultâneos sem degradação de performance ou perda de contexto de conversa entre sessões distintas.

### RNF12 - Arquitetura Orientada a Serviços
O back-end deve ser estruturado em serviços desacoplados (ex: serviço de catálogo, serviço de IA, serviço de pedidos), facilitando a manutenção e a evolução independente de cada módulo.

---

## Usabilidade

### RNF13 - Onboarding Intuitivo
O fluxo de cadastro e primeiro acesso deve ser concluído em no máximo **4 etapas**, com indicadores de progresso visíveis ao usuário.

### RNF14 - Acessibilidade Básica
O app deve seguir as diretrizes de acessibilidade do Flutter (contraste mínimo de cores, suporte a leitores de tela nativos do Android/iOS) para atender usuários com necessidades visuais.

---

> **Nota:** RNFs são restrições de qualidade que impactam decisões de arquitetura. Cada item acima deve ser considerado como critério de aceitação em pull requests e revisões de sprint.
