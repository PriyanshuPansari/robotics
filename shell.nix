# shell.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    python3Packages.pip
    uv  # Fast Python package installer and environment manager
  ];

  shellHook = ''
    # Create a virtual environment if it doesn't exist
    if [ ! -d .venv ]; then
      echo "Creating virtual environment..."
      uv venv .venv
    fi
    
    # Activate the virtual environment
    source .venv/bin/activate
  '';
}
