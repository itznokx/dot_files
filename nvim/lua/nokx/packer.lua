-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  -- Plenary needed to telescope
  use {'nvim-lua/plenary.nvim'}
  
  -- Telescope plugin
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  
  -- Treesitter
  use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
  }
  
  -- Nvim Tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }
  
  -- Color representation for HEX CODES
  use("catgoose/nvim-colorizer.lua")
  
  -- Transparent Backgrounds
  use {"xiyaowong/transparent.nvim"}
  
  -- Nvim Themes
  use { "zootedb0t/citruszest.nvim"}      -- Citruszest
  use { "scottmckendry/cyberdream.nvim" } -- Cyberdream
  
  -- Status Line
  use {'tamton-aquib/staline.nvim'}

  --[[
  -- Cyberdream Config Example
  use { "scottmckendry/cyberdream.nvim",
    config = function()
      require("cyberdream").setup({
          transparent = true,
          borderless_telescope = false,
          extensions = {
              telescope = true,
              treesitter = true,
          }
      })
    end
  } 
  ]]-- 

end)
