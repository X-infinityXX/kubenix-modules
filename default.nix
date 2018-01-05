{ pkgs ? import <nixpkgs> {} }:

with pkgs.lib;

let
  kubenix = import (builtins.fetchGit {
    url = "https://github.com/xtruder/kubenix.git";
  }) { inherit pkgs; };

  globalConfig = {config, ...}: {
    config.kubernetes.version = "1.9";

    config.kubernetes.defaultModuleConfiguration.all = {
      config.kubernetes.moduleDefinitions = config.kubernetes.moduleDefinitions;
    };
  };
in {
  services = import ./services/module-list.nix ++ [({config, ...}: {
    kubernetes.defaultModuleConfiguration.all = {
      config.kubernetes.moduleDefinitions = config.kubernetes.moduleDefinitions;
    };
  })];

  tests = {
    rabbitmq = kubenix.buildResources {
      configuration.imports = [./test/rabbitmq.nix globalConfig];
    };

    elasticsearch = kubenix.buildResources {
      configuration.imports = [./test/elasticsearch.nix globalConfig];
    };

    elasticsearch-curator = kubenix.buildResources {
      configuration.imports = [./test/elasticsearch-curator.nix globalConfig];
    };

    redis = kubenix.buildResources {
      configuration.imports = [./test/redis.nix globalConfig];
    };

    nginx = kubenix.buildResources {
      configuration.imports = [./test/nginx.nix globalConfig];
    };

    galera = kubenix.buildResources {
      configuration.imports = [./test/galera.nix globalConfig];
    };

    etcd = kubenix.buildResources {
      configuration.imports = [./test/etcd.nix globalConfig];
    };

    deployer = kubenix.buildResources {
      configuration.imports = [./test/deployer.nix globalConfig];
    };

    rippled = kubenix.buildResources {
      configuration.imports = [./test/rippled.nix globalConfig];
    };

    zetcd = kubenix.buildResources {
      configuration.imports = [./test/zetcd.nix globalConfig];
    };

    kibana = kubenix.buildResources {
      configuration.imports = [./test/kibana.nix globalConfig];
    };

    parity = kubenix.buildResources {
      configuration.imports = [./test/parity.nix globalConfig];
    };

    mediawiki = kubenix.buildResources {
      configuration.imports = [./test/mediawiki.nix globalConfig];
    };

    beehive = kubenix.buildResources {
      configuration.imports = [./test/beehive.nix globalConfig];
    };

    minio = kubenix.buildResources {
      configuration.imports = [./test/minio.nix globalConfig];
    };

    prometheus = kubenix.buildResources {
      configuration.imports = [./test/prometheus.nix globalConfig];
    };

    prometheus-kubernetes = kubenix.buildResources {
      configuration.imports = [./test/prometheus-kubernetes.nix globalConfig];
    };

    grafana = kubenix.buildResources {
      configuration.imports = [./test/grafana.nix globalConfig];
    };
  };
}
