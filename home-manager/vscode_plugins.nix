{ pkgs, lib }:

let vscode-utils = pkgs.vscode-utils;
in {
  "pkief"."material-icon-theme" = vscode-utils.extensionFromVscodeMarketplace {
    name = "material-icon-theme";
    publisher = "pkief";
    version = "4.34.0";
    sha256 = "1ahshxw66436mc9jpiyfac0hinnqm3s0g3akybjrda13yd9884y7";
  };
  "equinusocio"."vsc-material-theme" =
    vscode-utils.extensionFromVscodeMarketplace {
      name = "vsc-material-theme";
      publisher = "equinusocio";
      version = "34.3.1";
      sha256 = "1qbnqjhzh3cw2ya96szj39r7swg4p7whvhacw1dis9b3rd64ab6z";
    };
  "tamasfe"."even-better-toml" = vscode-utils.extensionFromVscodeMarketplace {
    name = "even-better-toml";
    publisher = "tamasfe";
    version = "0.19.2";
    sha256 = "0q9z98i446cc8bw1h1mvrddn3dnpnm2gwmzwv2s3fxdni2ggma14";
  };
  "jnoortheen"."nix-ide" = vscode-utils.extensionFromVscodeMarketplace {
    name = "nix-ide";
    publisher = "jnoortheen";
    version = "0.3.1";
    sha256 = "1cpfckh6zg8byi6x1llkdls24w9b0fvxx4qybi9zfcy5gc60r6nk";
  };
  "arrterian"."nix-env-selector" = vscode-utils.extensionFromVscodeMarketplace {
    name = "nix-env-selector";
    publisher = "arrterian";
    version = "1.0.11";
    sha256 = "113zx78c3219knw4qa04242404n32vnk9rb6a3ynz41dgwh1mbbl";
  };
  "rust-lang"."rust-analyzer" = vscode-utils.extensionFromVscodeMarketplace {
    name = "rust-analyzer";
    publisher = "rust-lang";
    version = "0.4.1894";
    sha256 = "0b3kca1y284x18w45zhclvxgwjvpkvn91ji0iaf0m6q88zwpdzsq";
    arch = "linux-x64";
  };
  "nerg"."clips-lang" = vscode-utils.extensionFromVscodeMarketplace {
    name = "clips-lang";
    publisher = "nerg";
    version = "1.0.4";
    sha256 = "14x7d2dkxcpgwmqanq72dac47w25wfdprvz9zldcylxbwvnnvkvv";
  };

}
