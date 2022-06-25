## Create application groups and assign groups with RBAC/ABAC

locals {
  apps = {
    # --- NEW APP GROUP ---
    # Application: 1Password - Owner
    # Owner: 
    # Approver(s): 
    # Description: 1Password app - Owner access
    # Permissions: Grants owner access to the example 1Password account
    "1password-owner" = { rule = join(" ", [
      "isMemberOfGroupNameContains(\"role-director-information-technology\") OR ",
      "isMemberOfGroupNameContains(\"role-chief-security-officer\")"
      # no exceptions for owner
      ])
    }

   
    # --- NEW APP GROUP ---
    # Application: ArgoCD - Admin
    # Owner: engineering@example.com
    # Approver(s): corporatesecurity@example.com  
    # Description: ArgoCD App Access - Admin
    # Permissions: Grants admin access to the example ArgoCD application    
    "argocd-admin" = { rule = join(" ", [
      "isMemberOfGroupNameContains(\"role-director-information-technology\") OR ",
      "isMemberOfGroupNameContains(\"org-team-information-technology-engineering\") OR ",
      "isMemberOfGroupNameContains(\"except-app-argocd-admin\")"
      ])
    }

    # --- NEW APP GROUP ---
    # Application: Asana - Admin
    "asana-admin" = { rule = join(" ", [
      # Reference this doc for expression language: https://developer.okta.com/docs/reference/okta-expression-language-in-identity-engine/#constants-and-operators
      # ATTRIBUTE-BASED ARGUMENTS, put your OR arguments FIRST
      # Exception Group arguments
      # Role Group arguments
      "isMemberOfGroupNameContains(\"role-it-support-administrator\") OR ",
      "isMemberOfGroupNameContains(\"role-director-information-technology\") OR ",
      "isMemberOfGroupNameContains(\"role-systems-engineer\") OR ",
      "isMemberOfGroupNameContains(\"except-app-asana-admin\")"
      ])
    }

    # --- NEW APP GROUP ---
    # Application: Asana - User
    "asana-user" = { rule = join(" ", [
      # Reference this doc for expression language: https://developer.okta.com/docs/reference/okta-expression-language-in-identity-engine/#constants-and-operators
      # ATTRIBUTE-BASED ARGUMENTS, put your OR arguments FIRST
      # Exception Group arguments
      # Role Group arguments
      "isMemberOfGroupNameContains(\"org-marketing\") OR ",
      "isMemberOfGroupNameContains(\"org-trust\") OR ",
      "isMemberOfGroupNameContains(\"org-community\") OR ",
      "isMemberOfGroupNameContains(\"org-dept-operations-continuous-improvement\") OR ",
      "isMemberOfGroupNameContains(\"role-chief-executive-officer\") OR ",
      "isMemberOfGroupNameContains(\"role-founder\") OR ",
      "isMemberOfGroupNameContains(\"role-svp-operations\") OR ",
      "isMemberOfGroupNameContains(\"role-vp-customer-security-operations\") OR ",
      "isMemberOfGroupNameContains(\"role-director-technology-partnerships\") OR ",
      "isMemberOfGroupNameContains(\"role-vp-product-management\") OR ",
      "isMemberOfGroupNameContains(\"role-product-manager\") OR ",
      "isMemberOfGroupNameContains(\"role-principal-product-manager\") OR ",
      "isMemberOfGroupNameContains(\"org-dept-operations-continuous-improvement\") OR ",
      "isMemberOfGroupNameContains(\"except-app-asana-user\")"
      ])
    }

    # --- NEW APP GROUP ---
    # Application: Atlassian - Site Admin
    # Owner: it@example.com
    # Approver(s): engineering@example.com
    # Description: Atlassian app - Administrative access
    # Permissions: Grants admin access to the example Atlassian account
    "atlassian-admin" = { rule = join(" ", [
      "isMemberOfGroupNameContains(\"role-it-support-administrator\") OR ",
      "isMemberOfGroupNameContains(\"role-manager-information-technology\") OR ",
      "isMemberOfGroupNameContains(\"role-director-information-technology\") OR ",
      "isMemberOfGroupNameContains(\"role-systems-engineer\") OR ",
      "isMemberOfGroupNameContains(\"except-app-atlassian-admin\")"
      ])
    }

    # --- NEW APP GROUP ---
    # Application: Atlassian - Trusted
    # Owner: it@example.com
    # Approver(s): engineering@example.com
    # Description: Atlassian app - Trusted access
    # Permissions: Grants trusted access to the example Atlassian account
    "atlassian-trusted" = { rule = join(" ", [
      "isMemberOfGroupNameContains(\"role-chief-executive-officer\") OR ",
      "isMemberOfGroupNameContains(\"role-chief-product-officer\") OR ",
      "isMemberOfGroupNameContains(\"role-chief-security-officer\") OR ",
      "isMemberOfGroupNameContains(\"role-vp-product-management\") OR ",
      "isMemberOfGroupNameContains(\"role-vp-engineering\") OR ",
      "isMemberOfGroupNameContains(\"role-svp-engineering\") OR ",
      "isMemberOfGroupNameContains(\"except-app-atlassian-trusted\")"
      ])
    }

   

    # --- NEW APP GROUP ---
    # Application: Zendesk - Customer- User
    # Owner: 
    # Approver(s): 
    # Description: Zendesk - Customer app - User access
    # Permissions: Grants user access to the example Zendesk - Customer account
    "zendesk-customer-user" = { rule = join(" ", [
      "isMemberOfGroupNameContains(\"role-technical-support-engineer\") OR ",
      "isMemberOfGroupNameContains(\"role-svp-operations\") OR ",
      "isMemberOfGroupNameContains(\"org-engineering\") OR ",
      "isMemberOfGroupNameContains(\"org-dept-customer-security-operations\") OR ",
      "isMemberOfGroupNameContains(\"org-dept-revenue-customer-solutions-engineering\") OR ",
      "isMemberOfGroupNameContains(\"org-team-channel-and-partnerships-consulting\") OR ",
      "isMemberOfGroupNameContains(\"org-dept-product-management-tech-partnerships\") OR ",
      "isMemberOfGroupNameContains(\"role-chief-executive-officer\") OR ",
      "isMemberOfGroupNameContains(\"role-founder\") OR ",
      "isMemberOfGroupNameContains(\"except-app-zendesk-customer-user\")"
      ])
    }

  }
}

# create an application group
resource "okta_group" "app" {
  for_each    = local.apps
  name        = "app-${each.key}"
  description = "RBAC/ABAC"
}
# define a rule for application groups using RBAC/ABAC
resource "okta_group_rule" "app" {
  for_each          = local.apps
  name              = "app-${each.key}"
  status            = "ACTIVE"
  group_assignments = [okta_group.app[each.key].id]
  expression_type   = "urn:okta:expression:1.0"
  expression_value  = each.value.rule
}
