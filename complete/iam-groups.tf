
resource "aws_iam_group_policy" "sysadmin_policy" {
  name  = "sysadmin"
  group = aws_iam_group.sysadmin.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_group_membership" "sysadmin" {
  name = "tf-testing-group-membership"

  users = [
    aws_iam_user.sysadmin1.name,
    aws_iam_user.sysadmin2.name,
  ]

  group = aws_iam_group.sysadmin.name
}

resource "aws_iam_group" "sysadmin" {
  name = "test-sysadmin"
}

######################################################################
# Creating SysAdmin users 1 & 2
######################################################################
#SysAdmin 1

resource "aws_iam_user" "sysadmin1" {
  name          = "sysadmin1"
  path          = "/system/"
  force_destroy = true
}

resource "aws_iam_access_key" "sysadmin1_access_key" {
  user = aws_iam_user.sysadmin1.name
}

#SysAdmin 2

resource "aws_iam_user" "sysadmin2" {
  name          = "sysadmin2"
  path          = "/system/"
  force_destroy = true
}

resource "aws_iam_access_key" "sysadmin2_access_key" {
  user = aws_iam_user.sysadmin2.name
}

########################################################################
# Create encrypted password
########################################################################

resource "aws_iam_user_login_profile" "sysadmin1" {
  user    = aws_iam_user.sysadmin1.name
  pgp_key = "keybase:grunya"
  password_length = 10
}
resource "aws_iam_user_login_profile" "sysadmin2" {
  user    = aws_iam_user.sysadmin2.name
  pgp_key = "keybase:grunya"
  password_length = 10
}

output "this_sysadmin1_password" {
  value = aws_iam_user_login_profile.sysadmin1.encrypted_password
}

output "this_sysadmin2_password" {
  value = aws_iam_user_login_profile.sysadmin2.encrypted_password
}