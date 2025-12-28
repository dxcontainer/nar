{
  lib,
  buildGoModule,
}:

buildGoModule {
  pname = "nar";
  version = "1.0.0";

  # See: https://nix.dev/guides/best-practices#reproducible-source-paths
  src = builtins.path { 
    path = ./.; 
    name = "nar"; 
  };

  # This is required even though we don't use third-party modules.
  vendorHash = null;

  meta = with lib; {
    description = "A Command-Line Interface (CLI) in Go for Generating Reproducible Nix Archive (NAR) Files and Subresource Integrity (SRI) Hashes";
    homepage = "https://github.com/dxcontainer/nar";
    license = licenses.bsd3;
    mainProgram = "nar";
    maintainers = [
      {
        name = "DxContainer";
        email = "nix@dxcontainer.org";
      }
    ];
  };
}
