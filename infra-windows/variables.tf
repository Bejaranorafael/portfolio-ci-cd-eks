# variables.tf: Define la AMI de Windows Server 2019 Base (us-east-1)
variable "ami_windows_2019" {
  description = " AMI para Windows Server 2019 Base"
  type        = string
  default     = "ami-01d75c5b7c7b8a8b1" 
}
