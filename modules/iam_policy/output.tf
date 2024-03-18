output "flask_app_policy" {
  value = aws_iam_policy.flask_app_policy.arn
}

output "react_app_policy" {
  value = aws_iam_policy.react_app_policy.arn
}