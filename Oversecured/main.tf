resource "aws_iam_user" "oversecured_user" {
  name          = var.user_name
  path          = var.user_path
  force_destroy = true
}

resource "aws_iam_user_login_profile" "oversecured" {
  user    = aws_iam_user.oversecured_user.name
}
