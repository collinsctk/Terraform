variable "aws_region" {
  type    = string
  default = "ap-northeast-2"
}

variable "db_table_name" {
  type    = string
  default = "terraform-learn"
}

variable "db_read_capacity" {
  type    = number
  default = 5
}

variable "db_write_capacity" {
  type    = number
  default = 5
}

variable "tag_user_name" {
  type = string
  default = 'db_tag'
}
