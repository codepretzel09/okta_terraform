## Variables defined for the okta_user.tf module
variable "user_email" {
  description = "The user's email address"
  validation {
    condition     = lower(var.user_email) == var.user_email
    error_message = "The user email must not have capital letters."
  }
}
variable "first_name" {
  description = "users first name"
  #  validation {
  #     condition = title(var.first_name) == var.first_name
  #     error_message = "Please ensure the first letter of the name is capitalized."
  # }
}
variable "last_name" {
  description = "users last name"
  # validation {
  #     condition = title(var.last_name) == var.last_name
  #     error_message = "Please ensure the first letter of the name is capitalized."
  # }
}

variable "status" {
  description = "status"
  validation {
    condition = contains([
      "ACTIVE",
      "STAGED",
      "DEPROVISIONED",
      "SUSPENDED",
    ], (var.status))
    error_message = "The user status must be in the approved list."
  }
}
variable "user_type" {
  description = "Type of User"
  validation {
    condition = contains([
      "Employee",
      "Part Time Employee",
      "Contractor",
      "employee_outside_us",
      "Service Account",
    ], (var.user_type))
    error_message = "The user type must be in the approved list."
  }
}
variable "organization" {
  description = "Organization"
  default     = "Red Canary"
}
variable "division" {
  description = "division"
  validation {
    condition = contains([
      "",
      "Business Operations",
      "Community",
      "Engineering",
      "Marketing",
      "Operations",
      "Product Management",
      "Revenue",
      "Talent",
      "Trust",
    ], (var.division))
    error_message = "The value must be from the approved Red Canary Function/Division list."
  }
}
variable "department" {
  description = "department"
  validation {
    condition = contains([
      "",
      "Accounting",
      "Architecture",
      "Business Operations",
      "Channel and Partnerships",
      "Continuous Improvement",
      "Creative",
      "Customer Security Operations",
      "Customer Solutions Engineering",
      "Customer Success",
      "Demand Generation",
      "Educational Programs",
      "Enterprise Sales",
      "Finance",
      "Information Security",
      "Information Technology",
      "Legal",
      "Marketing Operations",
      "Microsoft Strategy",
      "Mid-Market Sales",
      "Open Source Programs",
      "Operations",
      "Product Design",
      "Product Management",
      "Product Marketing",
      "Product Operations",
      "Product Support",
      "Research and Development",
      "Revenue Operations",
      "Software Engineering",
      "Talent Acquisition",
      "Talent Operations",
      "Talent Partners",
      "Technology Partnerships",
      "Trust Operations"
    ], (var.department))
    error_message = "The department must be in the approved list."
  }
}
variable "cost_center" {
  description = "cost center"
  validation {
    condition = contains([
      "",
      "Administration",
      "Analytics",
      "Business Solutions",
      "Consulting Partners",
      "Content Marketing",
      "Corporate Security",
      "Customer Success Operations",
      "Detection Enablement",
      "Detection Engineering",
      "Digital Marketing",
      "Enterprise Technical Accounts",
      "Field Marketing",
      "Governance, Risk & Compliance",
      "Incident Handling",
      "Intelligence",
      "IT Support Administration",
      "Marketing Operations",
      "Product Security",
      "Revenue Enablement",
      "Sales Development",
      "Sales Operations",
      "Systems and Tools",
      "Systems Engineering",
      "Technical Support Engineering",
      "Technology Partners",
    ], (var.cost_center))
    error_message = "The organizational team name must be in the approved list or blank."
  }
}
variable "title" {
  description = "Role or Job Title"
  validation {
    condition = contains([
      "",
      " ", #Added by MR 2022-0106 to account for Brianne Houck
      "Accountant II",
      "Accountant III",
      "Accounting Manager",
      "Assistant Controller",
      "Associate Detection Engineer",
      "Associate Enterprise Technical Account Manager",
      "Associate General Counsel",
      "Benefits and Compliance Manager",
      "Chief Executive Officer",
      "Chief Financial Officer",
      "Chief Revenue Officer",
      "Chief Security Officer",
      "Chief Trust Officer",
      "Community Manager",
      "Consulting Partner Manager",
      "Contractor", #Added by MR 2022-0106 to account for contractors
      "Content Strategy Manager",
      "Continuous Improvement Principal",
      "Continuous Improvement Specialist",
      "Controller",
      "Counsel",
      "Creative Traffic Coordinator",
      "Customer Solutions Engineer",
      "Customer Success Manager",
      "Customer Success Operations Specialist",
      "Deal Desk Specialist",
      "Detection Engineer",
      "Detection Validation Engineer",
      "Digital Marketing Manager",
      "Director, Continuous Improvement",
      "Director, Corporate Security",
      "Director, Creative",
      "Director, Customer Solutions Engineering",
      "Director, Detection Engineering",
      "Director, Educational Programs",
      "Director, Financial Planning & Analysis",
      "Director, Governance, Risk & Compliance",
      "Director, Incident Handling",
      "Director, Information Technology",
      "Director, Intelligence",
      "Director, Open Source Programs",
      "Director, Product Design",
      "Director, Product Security",
      "Director, Product Support",
      "Director, Regional Mid-Market Sales",
      "Director, Sales Development",
      "Director, Sales Enablement",
      "Director, Talent",
      "Director, Technology Partnerships",
      "Enterprise Technical Account Manager",
      "Executive Assistant",
      "Experiential Marketing & Events Manager",
      "Field Marketing Manager",
      "Founder",
      "FP&A Analyst",
      "General Counsel",
      "General Manager, Microsoft Strategy",
      "Governance, Risk and Compliance Analyst",
      "Group Manager, Product",
      "Incident Handler",
      "Information Security Specialist",
      "Intelligence Analyst",
      "IT Support Administrator",
      "Manager, Consulting Partners",
      "Manager, Content Design",
      "Manager, Customer Solutions Engineering",
      "Manager, Customer Success",
      "Manager, Customer Success Operations",
      "Manager, Detection Engineering",
      "Manager, Enterprise Technical Accounts",
      "Manager, Incident Handling",
      "Manager, Information Technology",
      "Manager, Product Marketing",
      "Manager, Sales Development",
      "Manager, Sales Operations",
      "Manager, Software Engineering",
      "Manager, Technical Accounts",
      "Manager, Technical Support",
      "Marketing Operations Manager",
      "Marketing Project Manager",
      "Microsoft Partner Manager",
      "Mid-Market Account Executive",
      "Office Manager",
      "Partner Development Representative",
      "Partner Relationship Manager",
      "Payroll and Accounting Associate",
      "People Mover",
      "Principal Data Scientist",
      "Principal Detection Engineer",
      "Principal Engineer",
      "Principal Incident Handler",
      "Principal Intelligence Analyst",
      "Principal Malware Analyst",
      "Principal Product Manager",
      "Principal Software Engineer",
      "Principal Solutions Specialist",
      "Principal Talent Partner",
      "Principal Technical Writer",
      "Principal Technology Partner Manager",
      "Principal Threat Researcher",
      "Product Designer",
      "Product Manager",
      "Product Security Engineer",
      "Production Designer",
      "Production Engineer",
      "Recruiter",
      "Resiliency Program Manager",
      "Sales Development Representative",
      "Sales Enablement Content Manager",
      "Sales Enablement Coordinator",
      "Sales Enablement Manager",
      "Sales Operations Specialist",
      "Security Engineer",
      "Senior Analyst, Growth Strategy",
      "Senior Corporate Security Engineer",
      "Senior Customer Solutions Engineer",
      "Senior Customer Success Manager",
      "Senior Deal Desk Specialist",
      "Senior Detection Engineer",
      "Senior Detection Validation Engineer",
      "Senior Director, Consulting Partners",
      "Senior Director, Detection Enablement",
      "Senior Director, Managed Threat Response",
      "Senior Editor",
      "Senior FP&A Analyst",
      "Senior Governance, Risk And Compliance Analyst",
      "Senior Graphic Designer",
      "Senior Incident Handler",
      "Senior Information Security Specialist",
      "Senior Intelligence Analyst",
      "Senior Intelligence Engineer",
      "Senior Malware Analyst",
      "Senior Manager, Business Solutions",
      "Senior Manager, Digital Marketing",
      "Senior Manager, Field Marketing",
      "Senior Manager, Software Engineering",
      "Senior Mid-Market Account Executive",
      "Senior Product Marketing Manager",
      "Senior Product Security Engineer",
      "Senior Production Engineer",
      "Senior Program Manager",
      "Senior Recruiter",
      "Senior Salesforce Administrator",
      "Senior Security Engineer",
      "Senior Software Engineer",
      "Senior Solutions Specialist",
      "Senior Talent Partner",
      "Senior Technical Account Manager",
      "Senior Technical Recruiter",
      "Senior Technical Support Engineer",
      "Senior Technical Writer",
      "Senior Threat Researcher",
      "Senior UX/UI Designer",
      "Social Media Manager",
      "Software Engineer",
      "Staff Software Engineer",
      "SVP, Engineering",
      "SVP, Operations",
      "SVP, Talent",
      "Systems Engineer",
      "Talent Operations Manager",
      "Technical Account Manager",
      "Technical Support Engineer",
      "Technical Writer",
      "Technology Partner Manager",
      "VP, Channel and Partnerships",
      "VP, Customer Security Operations",
      "VP, Customer Success",
      "VP, Engineering",
      "VP, Mid-Market Sales",
      "VP, Product Management",
      "VP, Product Marketing",
      "VP, Revenue Operations",
    ], (var.title))
    error_message = "The job title must be in the approved list."
  }
}
# CUSTOM ATTRIBUTE VARIABLES
variable "attributes" {

  description = "Red Canary Custom Variable for USer IDs and Product Teams"
  default     = <<JSON
    {
      "customAttribute_redcanary_product_team" : "",
      "customAttribute_redcanary_userid_github" : "",
      "customAttribute_redcanary_userid_terraform" : "",
      "customAttribute_redcanary_userid_carbonblack_community" : ""
    }
    JSON
}
# GROUP VARIABLES, these things are not used for dynamic access
variable "groups" {
  description = "okta groups"
  type        = list(string)
  default     = []
}

variable "manager" {
  default = ""
}
variable "manager_id" {
  default = ""
}
variable "state" {
  default = ""
}
variable "mobile_phone" {
  default = ""
}

variable "second_email" {
  default = null
}

variable "middle_name" {
  default = ""
}

variable "honorific_prefix" {
  default = ""
}

variable "honorific_suffix" {
  default = ""
}
