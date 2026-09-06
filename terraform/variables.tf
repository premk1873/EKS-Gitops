variable "aws_region" {
  default     = "us-east-1"
  type        = string
  description = "AWS region for EKS cluster"
}

variable "cluster_name" {
  default     = "notes_eks"
  type        = string
  description = "Name of EKS cluster"
}

variable "cluster_version" {
  default     = "1.35"
  type        = string
  description = "Version of EKS cluster"
}

variable "node_instance_type" {
  default     = "c7i-flex.large"
  type        = string
  description = "Instance type of nodes in EKS cluster"
}

variable "desired_nodes" {
  default     = 2
  type        = number
  description = "Number of desired nodes in EKS cluster"
}

variable "max_nodes" {
  default     = 5
  type        = number
  description = "Number of max nodes in EKS cluster"
}

variable "min_nodes" {
  default     = 2
  type        = number
  description = "Number of max nodes in EKS cluster"
}