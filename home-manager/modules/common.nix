{
  home.username = "boguskladik";
  home.homeDirectory = "/home/boguskladik";

  programs.fish = {
    enable = true;
    interactiveShellInit = "set fish_greeting";
  };

  programs.git = {
    enable = true;
    userName = "Bogus Kladik";
    userEmail = "boguskladik@gmail.com";
  };

  programs.helix.enable = true;

  home.sessionVariables = { };
}
