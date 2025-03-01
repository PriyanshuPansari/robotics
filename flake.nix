{
  description = "RoboSim: A Custom Robotics Framework";
  
  inputs ={
  nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
  flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = import nixpkgs {
          inherit system;
        };
      in 
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # C++ toolchain
            gcc13
            clang_17
            cmake
            ninja
            gdb
            
            # Libraries
            eigen
            glfw
            glew
            glm
            libGL
            
            # UI and visualization
            imgui
            
            # Development tools
            ccache
            cppcheck
            clang-tools
            
            # Documentation
            doxygen
            graphviz
            ];
        };
      }
      );
}

