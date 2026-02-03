# Changelog

## Unreleased (2026-02-02)

### Added
- Support for issuing NF-e for **Legal Entities (PJ)**: addition of fields to the customer payload (`cnpj`, `corporate_name`, `state_registration`, `suframa`, among others).
- Integration tests for NF-e issuance (individuals and legal entities) using **Bypass**.

### Changed
- Documentation fixes and improvements (`@moduledoc`) in core and request modules to make descriptions clearer and written in English.

### Removed
- Removal of the `WebmaniaNfe.Invoice.Request` shim/compatibility layer (when applicable).

---

> Note: update the `Unreleased` section with the version number when preparing a release.
`
