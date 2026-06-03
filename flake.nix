{
  description = "Nix flake of gnome-rounded-blur";
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = with pkgs;
        mkShell rec {
          inherit (self.packages.${system}.gnome-rounded-blur)
            nativeBuildInputs buildInputs;
          LD_LIBRARY_PATH =
            "\${LD_LIBRARY_PATH}:${lib.makeLibraryPath buildInputs}";
        };

      packages.${system} = rec {
        default = gnome-rounded-blur;
        gnome-rounded-blur = pkgs.callPackage ./default.nix { };
      };

      nixosModules.default = { ... }:
        let pkg = self.packages.${system}.default;
        in {
          environment.systemPackages = [ pkg ];
          environment.extraInit = ''
            export GI_TYPELIB_PATH="${pkg}/lib/girepository-1.0:$GI_TYPELIB_PATH"
          '';
        };
    };
}
