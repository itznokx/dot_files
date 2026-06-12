-- 1. Ensure Packer is installed (Bootstrap)
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true -- Returns true ONLY if it just installed
    end
    return false -- Returns false if it was already installed
end

local is_fresh_install = ensure_packer()

vim.opt.clipboard = "unnamedplus" 
vim.opt.termguicolors = true
vim.opt.laststatus = 2
vim.opt.showtabline = 2
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local status_ok, _ = pcall(require, "nokx")
if not status_ok then
    vim.notify("User config 'nokx' not found or failed to load.", vim.log.levels.WARN)
end

local tree_status_ok, nvim_tree = pcall(require, "nvim-tree")
if tree_status_ok then
    nvim_tree.setup({
        sort = {
            sorter = "case_sensitive",
        },
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = false,
        },
    })
else
    vim.notify("Nvim-tree is not installed yet.", vim.log.levels.WARN)
end

if is_fresh_install then
    print("Installing plugins for the first time...")
    vim.cmd("PackerSync")
end