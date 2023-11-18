{ config, pkgs, ... }:

{
  # Stuff that doesn't change often
  home.stateVersion = "23.05"; # Don't change this

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  # packages
  home.packages = with pkgs; [ neofetch pre-commit tree meslo-lgs-nf ];

  # autojump
  programs.autojump = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # git
  programs.git = {
    enable = true;
    userEmail = "gauthsvenkat@gmail.com";
    userName = "Gautham";
  };

  # zsh
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker" "docker-compose" "sudo" "git" "autojump" ];
    };
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      test -f ~/.p10k.zsh && source ~/.p10k.zsh
    '';
  };

  # fzf
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # btop
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "gruvbox_dark";
      update_ms = 1000;
      proc_tree = true;
    };
  };

  # neovim
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
      which-key-nvim
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
      nvim-hlslens
    ];
    extraLuaConfig = ''
        vim.o.termguicolors = true

        vim.wo.number = true
        vim.wo.relativenumber = true

        vim.g.gruvbox_material_background = 'hard'
        vim.cmd('colorscheme gruvbox-material')

        vim.g.airline_powerline_fonts = 1

        require('toggleterm').setup()
        require('gitsigns').setup()

        require('nvim-treesitter.configs').setup{
          highlight = {enable = true},
          indent = {enable = true},
        }

      require("which-key").setup()

      require("hlslens").setup()
    '';
  };
}
