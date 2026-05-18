# Neovim config — context

Personal Neovim config layered on top of NvChad v2.5. This file names the
overlay seams so you (or an AI agent) can jump to the right file without
re-deriving the layering.

## Overlay model

- Stock NvChad v2.5 lives in `~/.local/share/nvim/lazy/NvChad/`, pulled in
  via `init.lua` as `{"NvChad/NvChad", import = "nvchad.plugins"}`.
- Everything in `lua/` is the **overlay**: it either patches a NvChad
  default (strips a mapping, extends an on_attach) or adds net-new behaviour.
- NvChad's own LSP defaults run via the `nvchad.configs.lspconfig.defaults()`
  call at the top of `lua/configs/lspconfig.lua`.

## Seams

| Seam | File |
|---|---|
| Plugin set (lazy specs, non-NvChad plugins) | `lua/plugins/init.lua` |
| Theme tweaks | `lua/chadrc.lua` |
| Vim options | `lua/options.lua` |
| Filetype + yank-highlight autocmds | `lua/autocmds.lua` |
| LSP keymap overlay (on LspAttach) | `lua/autocmds.lua` |
| Per-server LSP config (`vim.lsp.config` + `enable`) | `lua/configs/lspconfig.lua` |
| Rust LSP overrides (buffer-local) | `lua/configs/rustaceanvim.lua` |
| Formatter routing (JS/TS via prettier; lua via stylua) | `lua/configs/none-ls.lua` |
| Diagnostic UI + `<leader>d*` keymaps | `lua/configs/diagnostics.lua` |
| Cmp insert + cmdline behaviour | `lua/configs/cmp.lua` |
| NvChad defaults stripped (nvchad.term toggles) | `lua/mappings.lua` (top `del(...)` block) |
| Motion / edit overrides (display-line j/k, visual indent keep) | `lua/mappings.lua` |
| GitSigns mappings | `lua/mappings.lua` (bottom) |

## LSP keymap layering (read-order matters)

Four layers contribute to the LSP key set; later layers win:

1. **Neovim 0.11+ built-ins** — `K`, `[d`, `]d`, `grn`, `grr`, `gri`.
2. **NvChad v2.5 `on_attach`** — `gD`, `gd`, `<leader>D`, `<leader>ra`, `<leader>wa/wr/wl`.
3. **Our LspAttach autocmd** (`lua/autocmds.lua`) — `gi`, `gr`, `<leader>ca`;
   deletes Neovim's `gra` in favour of `<leader>ca`.
4. **Rust per-buffer overrides** (`lua/configs/rustaceanvim.lua`) — `K`,
   `<leader>ca` re-pointed to `RustLsp` wrappers.

## Formatting (who owns what filetype)

- `lua` — stylua via NvChad's stock conform.nvim.
- `js/ts/css/scss/less/json/markdown` — prettierd via `none-ls.nvim`.
- ts_ls (`lua/configs/lspconfig.lua`) explicitly disables its own
  formatter capabilities so none-ls wins. If you ever re-introduce eslint,
  edit both `none-ls.lua` (add the source) and ts_ls's on_attach
  (which side wins) in the same commit.

## Things deliberately *not* used

- `NvChad/nvterm` (v2.0) and `nvchad.term` (v2.5) — terminal toggles
  stripped in `lua/mappings.lua` (the `del(...)` block at the top).
- eslint via none-ls — disabled, the source registration was removed.
