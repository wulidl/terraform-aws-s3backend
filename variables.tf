variable "namespace" {
  description = "value of the namespace"
  default     = "default"
  type        = string
}

variable "force_destroy_state" {
  description = "value of the force_destroy_state"
  default     = true
  type        = bool
}
