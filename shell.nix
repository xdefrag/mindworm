{ pkgs ? import <nixpkgs> { } }:

let
  godot322 = pkgs.godot.overrideAttrs (oldAttrs: rec {
    version = "3.2.2";

    src = pkgs.fetchFromGitHub {
      owner = "godotengine";
      repo = "godot";
      rev = "${version}-stable";
      sha256 = "1kndls0rklha7kz9l4i2ivjxab4jpk3b2j7dcgcg2qc3s81yd0r6";
    };
  });

  vim-beelzebub = pkgs.vimUtils.buildVimPlugin {
    name = "vim-beelzebub";
    src = pkgs.fetchFromGitHub {
      owner = "xdefrag";
      repo = "vim-beelzebub";
      rev = "55393041be725c626ea5be9b9a8dba322255467d";
      sha256 = "0w76w9s6cwfl7mmgx9sldi535agg6q56g32aw0bggjh9i176gxih";
    };
  };

  vim-godot = pkgs.vimUtils.buildVimPlugin {
    name = "vim-godot";
    src = pkgs.fetchFromGitHub {
      owner = "habamax";
      repo = "vim-godot";
      rev = "8fd5bbdc3dcc9eacfccfce83456912d62235e6fc";
      sha256 = "0gkjzhm19ajagkxwh83b8kdpp1kmcnan0n1lppkb2937j3r9s37a";
    };
  };

  vim = ((pkgs.vim_configurable.override { python = pkgs.python3; }).customize {
    name = "vim";
    vimrcConfig.customRC = builtins.readFile ./vimrc;
    vimrcConfig.plug.plugins = with pkgs.vimPlugins; [
      coc-json
      coc-nvim
      coc-snippets
      coc-tabnine
      fugitive
      fzf-vim
      fzfWrapper
      ultisnips
      vim-beelzebub
      vim-commentary
      vim-dispatch
      vim-eunuch
      vim-gitgutter
      vim-godot
      vim-repeat
      vim-snippets
      vim-surround
      vim-unimpaired
      vim-wakatime
    ];
  });

in pkgs.mkShell {
  buildInputs = with pkgs; [ godot322 blender python nodejs fzf vim ];
}
