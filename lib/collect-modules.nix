# Собирает список модулей из каталога:
# - pinned (в заданном порядке),
# - затем *.nix (кроме default.nix) и папки с default.nix (1 уровень),
# - игнорирует скрытые/временные файлы.
{ dir, pinned ? [ ], excludeHidden ? true # игнорировать .* файлы
, excludeDefault ? true # исключить default.nix из автосборки
}:
let
  d = builtins.readDir dir;
  names = builtins.attrNames d;

  isPinned = name: builtins.elem name pinned;
  isDefault = name: name == "default.nix";

  keepName = name:
    (!excludeHidden || builtins.match "\\..*" name == null)
    && builtins.match ".*~" name == null
    && (!excludeDefault || !isDefault name);

  nameToPath = name:
    let
      kind = d.${name};
      path = dir + "/${name}";
    in if kind == "regular" && builtins.match ".*\\.nix$" name != null then
      path
    else if kind == "directory"
    && builtins.pathExists (path + "/default.nix") then
      path
    else
      null;

  autoNames = builtins.filter (n: keepName n && !isPinned n) names;
  auto = builtins.filter (p: p != null) (map nameToPath autoNames);
  pinnedPaths = map (n: dir + "/${n}") pinned;
in pinnedPaths ++ auto
