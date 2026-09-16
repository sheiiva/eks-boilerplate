output "controller_role_arn" {
  description = "IAM role ARN used by the Karpenter controller (IRSA)."
  value       = aws_iam_role.controller.arn
}

output "node_role_arn" {
  description = "IAM role ARN assumed by Karpenter-provisioned nodes."
  value       = aws_iam_role.node.arn
}

output "node_instance_profile_name" {
  description = "Instance profile name for Karpenter nodes."
  value       = aws_iam_instance_profile.node.name
}

output "interruption_queue_name" {
  description = "SQS queue for EC2 interruption events."
  value       = aws_sqs_queue.interruption.name
}

output "node_pool_name" {
  description = "Default NodePool name."
  value       = "default"
}
