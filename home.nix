{ pkgs, ... }:

let
  username = "ando";
  homeDirectory = "/home/${username}";
in
{
  home.stateVersion = "23.05"; # Dont' change this

  targets.genericLinux.enable = true;
  home.username = username;
  home.homeDirectory = homeDirectory;

  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    "FLAKE" = "${homeDirectory}/.config/home-manager";
    "EDITOR" = "nvim";
  };

  # packages
  home.packages = with pkgs; [
    fastfetch
    pre-commit
    tree
    bat
    meslo-lgs-nf
    ripgrep
    cmake
    nodejs
    rustup
    xclip
    lazygit
    cue
    nix-output-monitor
    nh
    nixfmt-rfc-style
  ];

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

  # zsh
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "docker"
        "docker-compose"
        "sudo"
        "git"
        "autojump"
      ];
    };
    shellAliases = {
      v = "nvim";
      b = "bat";
      t = "tree";
    };
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      test -f ~/.p10k.zsh && source ~/.p10k.zsh
      test -f .env && export $(grep -v '^#' .env | xargs)
    '';
  };

}
