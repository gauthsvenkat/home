{ config, pkgs, ... }:

{
  home.stateVersion = "23.05"; # Don't change this 
  home.username = "ando";
  home.homeDirectory = "/home/ando";

  home.packages = with pkgs; [
    neofetch
    firefox
    meslo-lgs-nf
  ];
  
  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.git.enable = true;

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker" "docker-compose" "sudo" "git" ];
    };
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      test -f ~/.config/home-manager/p10k.zsh && source ~/.config/home-manager/p10k.zsh
    '';
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark";
      update_ms = 1000;
      proc_tree = true;
    };
  };

  # ------------------------------------
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      toggleterm-nvim
      gitsigns-nvim
      vim-sleuth
      gruvbox-material
      auto-pairs
      vim-airline
      nvim-treesitter
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.toml
      nvim-treesitter-parsers.yaml
      nvim-treesitter-parsers.bash
      nvim-treesitter-parsers.csv
      nvim-treesitter-parsers.dockerfile
      nvim-treesitter-parsers.make
    ];
    extraLuaConfig = ''
      vim.o.termguicolors = true
      vim.o.clipboard = 'unnamedplus'

      vim.wo.number = true
      vim.wo.relativenumber = true

      vim.g.gruvbox_material_background = 'hard'
      vim.cmd('colorscheme gruvbox-material')

      require('toggleterm').setup()
      require('gitsigns').setup()
      require('nvim-treesitter.configs').setup{
        highlight = {enable = true},
        indent = {enable = true},
      }
    '';
  };
  # ------------------------------------
  targets.genericLinux.enable = true;
}
