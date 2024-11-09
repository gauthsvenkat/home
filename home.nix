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
    "EDITOR" = "nvim";
  };

  # packages
  home.packages = with pkgs; [
    pre-commit
    tree
    meslo-lgs-nf
    cmake
    nodejs
    rustup
    xclip
    cue
    nix-output-monitor
    nixfmt-rfc-style
    just
  ];

  programs = {
    fastfetch.enable = true;
    bat.enable = true;
    ripgrep.enable = true;
    lazygit.enable = true;
    direnv.enable = true;

    nh = {
      enable = true;
      flake = "${homeDirectory}/.config/home-manager";
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      options = [
        "--cmd j"
      ];
    };

    git = {
      enable = true;
      userEmail = "gauthsvenkat@gmail.com";
      userName = "Gautham Venkataraman";
    };

    fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox_dark";
        update_ms = 1000;
        proc_tree = true;
      };
    };

    yazi = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    zsh = {
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
          "fzf"
          "zoxide"
        ];
      };
      shellAliases = {
        v = "${pkgs.neovim}/bin/nvim";
        t = "${pkgs.tree}/bin/tree";
        b = "${pkgs.bat}/bin/bat";
        y = "${pkgs.yazi}/bin/yazi";
        lg = "${pkgs.lazygit}/bin/lazygit";
      };
      initExtra = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        test -f ~/.p10k.zsh && source ~/.p10k.zsh
        ${pkgs.fastfetch}/bin/fastfetch
      '';
    };
  };
}
