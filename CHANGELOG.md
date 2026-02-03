# Registro de alterações

## Não lançado (2026-02-02)

### Adicionado
- Suporte à emissão de NF-e para **Pessoa Jurídica (PJ)**: adição de campos no payload do cliente (`cnpj`, `razao_social`, `ie`, `suframa`, entre outros).
- Testes de integração para emissão de NF-e (PF e PJ) usando **Bypass**.

### Alterado
- Correções e melhorias de documentação (`@moduledoc`) em módulos principais e de request para deixar descrições mais claras e em português.

### Removido
- Remoção do shim/compatibilidade `WebmaniaNfe.Invoice.Request` (quando aplicável).

---

> Nota: atualize a seção `Não lançado` com a versão quando preparar um release.
