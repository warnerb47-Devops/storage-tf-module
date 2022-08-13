variable "access" {
  type = object({
    region     = string
    access_key = string
    secret_key = string
    key_name   = string
  })
  default = {
    region     = "value"
    access_key = "value"
    secret_key = "value"
    key_name   = "value"
  }
}

variable "s3_buckets" {
  type = list(object({
    name = string
  }))
  default = [
    {
      name = "value"
    }
  ]
}

variable "ecr" {
  type = list(object({
    name = string
  }))
  default = [
    {
      name = "value"
    }
  ]
}