output "json" {
  description = "JSON representation of variables map."

  value = join(",",
    [for k in keys(var.map) :
      templatefile(
        "${path.module}/json_template.tpl", {
          k = k
          v = aws_ssm_parameter.secret_var[k].arn,
        }
      )
    ]
  )
}

output "kms_key_id" {
  description = "KMS Key ID for the SSM Parameter Store."
  value       = aws_kms_key.encryption_key.key_id
}
