resource "oci_stack_monitoring_process_set" "stack_monitoring_process_sets" {
  for_each = var.stack_monitoring_process_sets

  compartment_id = each.value.compartment_id
  display_name   = each.value.display_name
  defined_tags   = each.value.defined_tags
  freeform_tags  = each.value.freeform_tags

  specification {
    dynamic "items" {
      for_each = each.value.specification.items
      content {
        label                      = items.value.label
        process_command            = items.value.process_command
        process_line_regex_pattern = items.value.process_line_regex_pattern
        process_user               = items.value.process_user
      }
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

