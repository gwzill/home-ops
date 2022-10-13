module "home-ops" {
  source  = "mineiros-io/repository/github"
  version = "0.16.2"

  name         = "home-ops"
  description  = "My home or for-home infrastructure written as code, adhering to GitOps practices"
  topics       = ["flux", "gitops", "iac", "k8s-at-home", "kubernetes", "renovate"]
  homepage_url = "https://bjw-s.github.io/home-ops"
  visibility   = "public"

  auto_init              = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true

  has_issues   = true
  has_wiki     = false
  has_projects = false
  is_template  = false

  plaintext_secrets = {
    "BJWS_APP_ID"          = data.sops_file.github_secrets.data["apps.bjws_bot.app_id"]
    "BJWS_APP_PRIVATE_KEY" = data.sops_file.github_secrets.data["apps.bjws_bot.private_key"]
  }

  issue_labels_merge_with_github_labels = false
  issue_labels = concat(
    [
      { name = "area/ci", color = "72ccf3", description = "Issue relates to CI" },
      { name = "area/kubernetes", color = "72ccf3", description = "Issue relates to Kubernetes" },

      { name = "renovate/container", color = "ffc300", description = "Issue relates to a Renovate container update" },
      { name = "renovate/helm", color = "ffc300", description = "Issue relates to a Renovate helm update" },
    ],
    local.default_issue_labels
  )

  pages = {
    custom_404 = true
    html_url   = "https://bjw-s.github.io/home-ops/"
    status     = "built"
    url        = "https://api.github.com/repos/bjw-s/home-ops/pages"
    branch     = "gh-pages"
    path       = "/"
  }

  webhooks = [
    {
      events       = ["push"]
      url          = data.sops_file.github_secrets.data["home_ops.webhook.url"]
      active       = true
      content_type = "json"
      secret       = data.sops_file.github_secrets.data["home_ops.webhook.secret"]
    }
  ]
}

module "pmb" {
  source  = "mineiros-io/repository/github"
  version = "0.16.2"

  name        = "pmb"
  description = "Poor Man's Backup"
  topics      = ["kubernetes", "docker", "backups", "sidecar"]
  visibility  = "public"

  auto_init              = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true

  has_issues   = true
  has_wiki     = false
  has_projects = false
  is_template  = false

  plaintext_secrets = {
    "BJWS_APP_ID"          = data.sops_file.github_secrets.data["apps.bjws_bot.app_id"]
    "BJWS_APP_PRIVATE_KEY" = data.sops_file.github_secrets.data["apps.bjws_bot.private_key"]
  }

  issue_labels_merge_with_github_labels = false
  issue_labels = concat(
    [],
    local.default_issue_labels
  )
}

module "renovate-config" {
  source  = "mineiros-io/repository/github"
  version = "0.16.2"

  name        = "renovate-config"
  description = "Renovate configuration presets"
  topics      = ["renovate", "gitops", "ci"]
  visibility  = "public"

  auto_init              = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true

  has_issues   = true
  has_wiki     = false
  has_projects = false
  is_template  = false

  plaintext_secrets = {
    "BJWS_APP_ID"          = data.sops_file.github_secrets.data["apps.bjws_bot.app_id"]
    "BJWS_APP_PRIVATE_KEY" = data.sops_file.github_secrets.data["apps.bjws_bot.private_key"]
  }

  issue_labels_merge_with_github_labels = false
  issue_labels = concat(
    [],
    local.default_issue_labels
  )
}

module "helm-charts" {
  source  = "mineiros-io/repository/github"
  version = "0.16.2"

  name         = "helm-charts"
  description  = "A collection of Helm charts"
  topics       = ["helm", "kubernetes"]
  homepage_url = "https://bjw-s.github.io/helm-charts/"
  visibility   = "public"

  auto_init              = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true

  has_issues   = true
  has_wiki     = false
  has_projects = false
  is_template  = false

  plaintext_secrets = {
    "BJWS_APP_ID"          = data.sops_file.github_secrets.data["apps.bjws_bot.app_id"]
    "BJWS_APP_PRIVATE_KEY" = data.sops_file.github_secrets.data["apps.bjws_bot.private_key"]
  }

  issue_labels_merge_with_github_labels = false
  issue_labels = concat(
    [],
    local.default_issue_labels
  )

  branches = [
    {
      name          = "development"
      source_branch = "main"
    },
    {
      name = "gh-pages"
    }
  ]

  push_collaborators = [
    "onedr0p"
  ]

  pages = {
    custom_404 = true
    html_url   = "https://bjw-s.github.io/helm-charts/"
    status     = "built"
    url        = "https://api.github.com/repos/bjw-s/helm-charts/pages"
    branch     = "gh-pages"
    path       = "/"
  }
}

module "container-images" {
  source  = "mineiros-io/repository/github"
  version = "0.16.2"

  name         = "container-images"
  description  = "Kubernetes tailored container images for various applications"
  topics       = ["kubernetes", "docker", "containers"]
  visibility   = "public"

  auto_init              = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true

  has_issues   = true
  has_wiki     = false
  has_projects = false
  is_template  = false

  plaintext_secrets = {
    "BJWS_APP_ID"          = data.sops_file.github_secrets.data["apps.bjws_bot.app_id"]
    "BJWS_APP_PRIVATE_KEY" = data.sops_file.github_secrets.data["apps.bjws_bot.private_key"]
  }

  issue_labels_merge_with_github_labels = false
  issue_labels = concat(
    [],
    local.default_issue_labels
  )
}

module "helm-charts-actions" {
  source  = "mineiros-io/repository/github"
  version = "0.16.2"

  name         = "helm-charts-actions"
  description  = "A collection of GitHub actions to use with helm-charts repo"
  topics       = ["helm", "github-actions"]
  visibility   = "public"

  auto_init              = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true

  has_issues   = true
  has_wiki     = false
  has_projects = false
  is_template  = false

  plaintext_secrets = {
    "BJWS_APP_ID"          = data.sops_file.github_secrets.data["apps.bjws_bot.app_id"]
    "BJWS_APP_PRIVATE_KEY" = data.sops_file.github_secrets.data["apps.bjws_bot.private_key"]
  }

  issue_labels_merge_with_github_labels = false
  issue_labels = concat(
    [],
    local.default_issue_labels
  )
}

module "gh-workflows" {
  source  = "mineiros-io/repository/github"
  version = "0.16.2"

  name         = "gh-workflows"
  description  = "A collection of reusable GitHub workflows"
  topics       = ["ci", "github", "workflows"]
  visibility   = "public"

  auto_init              = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true

  has_issues   = true
  has_wiki     = false
  has_projects = false
  is_template  = false

  plaintext_secrets = {
    "BJWS_APP_ID"          = data.sops_file.github_secrets.data["apps.bjws_bot.app_id"]
    "BJWS_APP_PRIVATE_KEY" = data.sops_file.github_secrets.data["apps.bjws_bot.private_key"]
  }

  issue_labels_merge_with_github_labels = false
  issue_labels = concat(
    [],
    local.default_issue_labels
  )
}

module "klipper-config" {
  source  = "mineiros-io/repository/github"
  version = "0.16.2"

  name         = "klipper-config"
  description  = "My Klipper configurations"
  topics       = ["3dprinter", "klipper"]
  visibility   = "public"

  auto_init              = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true

  has_issues   = true
  has_wiki     = false
  has_projects = false
  is_template  = false

  issue_labels_merge_with_github_labels = false
  issue_labels = concat(
    [],
    local.default_issue_labels
  )
}

module "esphome-config" {
  source  = "mineiros-io/repository/github"
  version = "0.16.2"

  name         = "esphome-config"
  description  = "My ESPHome configs."
  topics       = ["esphome", "esphome-devices", "esphome-config", "home-assistant"]
  visibility   = "public"

  auto_init              = true
  allow_merge_commit     = false
  allow_squash_merge     = true
  allow_auto_merge       = true
  delete_branch_on_merge = true

  has_issues   = true
  has_wiki     = false
  has_projects = false
  is_template  = false

  issue_labels_merge_with_github_labels = false
  issue_labels = concat(
    [],
    local.default_issue_labels
  )
}
