resource "aws_iam_policy" "flask_app_policy" {
  name = "flask_app_policy"
  description = "Allow access to ECS"

  policy = jsondecode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ecs:*",
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_policy" "react_app_policy" {
  name = "react_app_policy"
  description = "Allow access to S3"

  policy = jsondecode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": "arn:aws:s3:::sctp-ce4-group1-react-flask"
        }
    ]
})
}