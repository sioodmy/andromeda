{
  inputs,
  pkgs,
  ...
}: {
  foot = import ./foot {inherit inputs pkgs;};
}
