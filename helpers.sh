
idisk() {
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./hosts/"$1"/disks.nix
}

ios() {
    sudo nixos-install --flake ".#$1"
}
