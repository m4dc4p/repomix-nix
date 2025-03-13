{ config, lib, pkgs, ... }:
let
  cfg = config.programs.repomix;
  repomixPackage = import ./. { inherit pkgs;};
in {
  options.programs.repomix = {
    enable = lib.mkEnableOption "Repomix, a tool to pack repository contents to a single file for AI consumption";
    package = lib.mkOption {
      type = lib.types.package;
      default = repomixPackage.nodeDependencies // {
          meta = repomixPackage.nodeDependencies.meta // { mainProgram = "repomix"; };
          pname = "repomix";
        };
      description = "The repomix package to use.";
    };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}