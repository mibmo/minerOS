{ lib, pkgs, inputs, config, options, modulesPath, ... }:
let
  osVersion = "1.0.0";
  osCommit = inputs.self.rev or "dirty";
  osCommitShort =
    lib.lists.fold
      (l: r: l + r)
      ""
      (lib.lists.take 7 (lib.strings.stringToCharacters osCommit));
in
{
  imports = [
    (modulesPath + "/installer/cd-dvd/iso-image.nix")
    (modulesPath + "/profiles/all-hardware.nix")
    (modulesPath + "/profiles/installation-device.nix")
    (modulesPath + "/profiles/base.nix")
    (modulesPath + "/profiles/minimal.nix")
    #(modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  console.packages = options.console.packages.default ++ [ pkgs.terminus_font ];

  environment.noXlibs = false;
  documentation = {
    man.enable = false;
    doc.enable = false;
  };

  fonts.fontconfig.enable = false;

  isoImage = {
    isoName = "${config.isoImage.isoBaseName}-${osVersion}-${osCommitShort}-${pkgs.stdenv.hostPlatform.system}.iso";
    isoBaseName = "mineros";
    squashfsCompression = "lz4";
  };
}
