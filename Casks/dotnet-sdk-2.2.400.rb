cask "dotnet-sdk-2.2.400" do
  version "2.2.402,2.2.7"
  sha256 "e74d816bc034d0fcdfa847286a6cad097227d4864da1c97fe801012af0c26341"

  url "https://download.visualstudio.microsoft.com/download/pr/7430e32b-092b-4448-add7-2dcf40a7016d/1076952734fbf775062b48344d1a1587/dotnet-sdk-2.2.402-osx-x64.pkg"
  name ".NET Core SDK #{version.before_comma}"
  homepage "https://www.microsoft.com/net/core#macos"

  if MacOS.version <= :sierra
    conflicts_with cask: [
      "dotnet",
      "dotnet-sdk",
    ]
  end

  depends_on macos: ">= :sierra"

  pkg "dotnet-sdk-#{version.before_comma}-osx-x64.pkg"
  binary "/usr/local/share/dotnet/dotnet"

  uninstall pkgutil: "com.microsoft.dotnet.dev.#{version.before_comma}.component.osx.x64",
            delete:  [
              "/etc/paths.d/dotnet",
              "/etc/paths.d/dotnet-cli-tools",
            ]

  zap trash:   ["~/.dotnet", "~/.nuget"],
      pkgutil: [
        "com.microsoft.dotnet.hostfxr.#{version.after_comma}.component.osx.x64",
        "com.microsoft.dotnet.sharedframework.Microsoft.NETCore.App.#{version.after_comma}.component.osx.x64",
        "com.microsoft.dotnet.sharedhost.component.osx.x64",
      ]

  caveats "Uninstalling the offical dotnet-sdk casks will remove the shared runtime dependencies, "\
          "so you\'ll need to reinstall the particular version cask you want from this tap again "\
          "for the `dotnet` command to work again."
end
