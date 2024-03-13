self: { lib, config, pkgs, ... }: let
  inherit (lib) mkOption types mapAttrs';

  playgroundOptions = { name, ... }: {
    options = {
      domain = mkOption {
        type = types.str;
        default = name;
        description = "The domain to host the playground";
      };

      jwt-signature-file = mkOption {
        type = types.path;
        description = "A file containing a JWT signing token";
      };

      github-client-id = mkOption {
        type = types.str;
        description = "The GitHub OAuth application client ID";
      };

      github-client-secret-file = mkOption {
        type = types.path;
        description = "A file containing the GitHub OAuth application client secret";
      };

      flake = mkOption {
        type = types.attrs;
        default = self;
        description = "A Nix Flake for the playground application";
      };
    };
  };

  cfg = config.marlowe.playgrounds;
in {
  options = {
    marlowe.playgrounds = mkOption {
      type = types.attrsOf (types.submodule playgroundOptions);
      default = {};
      description = "Marlowe Playground instances to run";
    };
  };
  config = {
    http-services.static-sites = mapAttrs' (name: playground: {
      name = "${name}-frontend";
      value = {
        inherit (playground) domain;
        root = "${playground.flake.packages.x86_64-linux.marlowe-playground-client}/share/marlowe-playground-client/static";
      };
    }) cfg;

    http-services.proxied-services = mapAttrs' (name: playground: let
      webghc = config.http-services.internal-services."${name}-webghc";
    in {
      name = "${name}-backend";
      value = {
        inherit (playground) domain;
        prefix = "/api";
        systemdConfig = port: {
          description = "Marlowe Playground (${name})";
          wants = [ webghc.service-unit ];
          path = [ playground.flake.packages.x86_64-linux.marlowe-playground-server pkgs.jq ];
          preStart = ''
            jq -n \
              --rawfile ghClientSecret $CREDENTIALS_DIRECTORY/ghcs \
              --rawfile jwt $CREDENTIALS_DIRECTORY/jwt \
              --arg ghClientId ${lib.escapeShellArg playground.github-client-id} \
              --arg frontendUrl ${lib.escapeShellArg playground.domain} \
              '{ "github-client-id": $ghClientId
               , "github-client-secret": $ghClientSecret
               , "jwt-signature": $jwt
               , "frontend-url": $frontendUrl
               , "github-cb-path": "/#/gh-oauth-cb"
               }' > $CREDENTIALS_DIRECTORY/config.json
          '';
          serviceConfig = {
            LoadCredential = [
              "ghcs:${playground.github-client-secret-file}"
              "jwt:${playground.jwt-signature-file}"
            ];
            ExecStart = "marlowe-playground-server --port ${toString port} --config \${CREDENTIALS_DIRECTORY}/config.json";
            Environment.WEBGHC_URL = webghc.domain;
          };
        };
      };
    }) cfg;
  };

  # TODO add webghc
}
