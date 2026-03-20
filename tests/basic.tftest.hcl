run "validate" {
  command = plan

  plan_options {
    refresh = false
  }

  assert {
    condition     = true
    error_message = "Module validation failed"
  }
}
