variable "stack_monitoring_process_sets" {
  description = <<EOT
Map of stack_monitoring_process_sets, attributes below
Required:
    - compartment_id
    - display_name
    - specification (block):
        - items (required, block):
            - label (optional)
            - process_command (optional)
            - process_line_regex_pattern (optional)
            - process_user (optional)
Optional:
    - defined_tags
    - freeform_tags
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    compartment_id = string
    display_name   = string
    defined_tags   = optional(map(string))
    freeform_tags  = optional(map(string))
    specification = object({
      items = list(object({
        label                      = optional(string)
        process_command            = optional(string)
        process_line_regex_pattern = optional(string)
        process_user               = optional(string)
      }))
    })
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.stack_monitoring_process_sets : (
        length(v.specification.items) >= 1
      )
    ])
    error_message = "Each items list must contain at least 1 items"
  }
}

