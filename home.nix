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

    eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
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
      plugins =
        let
          se = rec {
            name = "smart-enter";
            path = "${name}/init.lua";
            content = ''
              return {
                entry = function()
                  local h = cx.active.current.hovered
                  ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = true })
                end,
              }
            '';
            pkg = "${pkgs.writeTextDir se.path se.content}/${name}";
          };
        in
        {
          ${se.name} = se.pkg;
        };
      keymap = {
        input.prepend_keymap = [
          {
            on = "<Esc>";
            run = "close";
            desc = "Cancel input";
          }
        ];
        manager.prepend_keymap = [
          {
            on = "o";
            run = "shell \"$SHELL\" --block --confirm ";
            desc = "Open shell";
          }
          {
            on = "<Esc>";
            run = "close";
            desc = "Close yazi";
          }
          {
            on = "<Enter>";
            run = "plugin --sync smart-enter";
            desc = "Enter directory, or open file";
          }
        ];
      };
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
        l = "${pkgs.eza}/bin/eza -l --icons -a";
        lt = "${pkgs.eza}/bin/eza --tree --icons --git --level=3";
        v = "${pkgs.neovim}/bin/nvim";
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
