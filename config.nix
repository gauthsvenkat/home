{ config, pkgs, ... }:

{
  # Stuff that doesn't change often
  home.stateVersion = "23.05"; # Don't change this

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  # packages
  home.packages = with pkgs; [ fastfetch pre-commit tree meslo-lgs-nf ripgrep cmake nodejs rustup xclip lazygit lazydocker tmux gh cue ];

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
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "docker" "docker-compose" "sudo" "git" "autojump" ];
    };
    shellAliases = {
      v = "nvim";
    };
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      test -f ~/.p10k.zsh && source ~/.p10k.zsh
      test -f .env && export $(grep -v '^#' .env | xargs)
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
}
