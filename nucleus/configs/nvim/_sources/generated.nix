# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  neotree = {
    pname = "neotree";
    version = "206241e451c12f78969ff5ae53af45616ffc9b72";
    src = fetchFromGitHub {
      owner = "nvim-neo-tree";
      repo = "neo-tree.nvim";
      rev = "206241e451c12f78969ff5ae53af45616ffc9b72";
      fetchSubmodules = false;
      sha256 = "sha256-eNGuQEjAKsPuRDGaw95kCVOmP64ZDnUuFBppqtcrhZ4=";
    };
    date = "2024-06-11";
  };
  nvim-base-16 = {
    pname = "nvim-base-16";
    version = "6ac181b5733518040a33017dde654059cd771b7c";
    src = fetchFromGitHub {
      owner = "RRethy";
      repo = "nvim-base16";
      rev = "6ac181b5733518040a33017dde654059cd771b7c";
      fetchSubmodules = false;
      sha256 = "sha256-GRF/6AobXHamw8TZ3FjL7SI6ulcpwpcohsIuZeCSh2A=";
    };
    date = "2024-05-23";
  };
  org-bullets = {
    pname = "org-bullets";
    version = "3623e86e0fa6d07f45042f7207fc333c014bf167";
    src = fetchFromGitHub {
      owner = "nvim-orgmode";
      repo = "org-bullets.nvim";
      rev = "3623e86e0fa6d07f45042f7207fc333c014bf167";
      fetchSubmodules = false;
      sha256 = "sha256-aIEe1dgUmDzu9kl33JCNcgyfp8DymURltH0HcZfph0Y=";
    };
    date = "2024-02-21";
  };
  org-roam = {
    pname = "org-roam";
    version = "45153562e7bfe806d84747d6518cad714c63ca2e";
    src = fetchFromGitHub {
      owner = "chipsenkbeil";
      repo = "org-roam.nvim";
      rev = "45153562e7bfe806d84747d6518cad714c63ca2e";
      fetchSubmodules = false;
      sha256 = "sha256-7s7nePlg/lF/JplR3qvY+ZT1B/wUG6TymCis4OMBBQ8=";
    };
    date = "2024-06-23";
  };
  telescope-orgmode = {
    pname = "telescope-orgmode";
    version = "b1d0fab19fafeb7de0fd78b16d4c023021c01765";
    src = fetchFromGitHub {
      owner = "nvim-orgmode";
      repo = "telescope-orgmode.nvim";
      rev = "b1d0fab19fafeb7de0fd78b16d4c023021c01765";
      fetchSubmodules = false;
      sha256 = "sha256-46R9HO6kmGmWzBXAiL+SeR44uj0P716vwOfUTI8ec7E=";
    };
    date = "2024-07-07";
  };
}
