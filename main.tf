provider "aws" {
  region = "us-east-1" # Change this to your desired region
  access_key = "AKIAUMJERKO4N54UOTDT"
  secret_key = "q021TiyX/+sxp/vUNwTVBfviZUL87fE78NmM+nBI"
}

resource "aws_iam_user" "first_user" {
  name = "pritam-Cave-1"
  force_destroy = true
}

resource "aws_iam_user" "user2" {
  name = "pritam-Cave-2"
  force_destroy = true
}

resource "aws_iam_user" "user3" {
  name = "pritam-Cave-3"
  force_destroy = true
}

#creating login credentials for the user's that are there
resource "aws_iam_user_login_profile" "first_user" {
  user    = aws_iam_user.first_user.name
  pgp_key = "keybase:some_person_that_exists"
  password_length = 10
}
resource "aws_iam_user_login_profile" "user2" {
  user    = aws_iam_user.user2.name
  pgp_key = "keybase:some_person_that_exists"
  password_length = 10
}
resource "aws_iam_user_login_profile" "user3" {
  user    = aws_iam_user.user3.name
  pgp_key = "keybase:some_person_that_exists"
  password_length = 10
}

#outputting the password
output "password" {
  value = aws_iam_user_login_profile.first_user.encrypted_password
}

resource "aws_s3_bucket" "first_user_bucket" {
  bucket = "pritam-cave-bucket"
}



# resource "aws_instance" "first_user_instance" {
#   ami           = "ami-0c55b159cbfafe1f0"
#   instance_type = "t2.micro"
# }

# Policy assignment first_users
resource "aws_iam_policy" "s3_full_access" {
  name        = "s3_full_access"
  description = "Provides full access to S3"
  policy      = file("s3_full_access_policy.json")
}

resource "aws_iam_policy_attachment" "s3_full_access_attachment" {
  name       = "s3_full_access_attachment"
  policy_arn = aws_iam_policy.s3_full_access.arn
  users      = [aws_iam_user.first_user.name, aws_iam_user.user2.name, aws_iam_user.user3.name]
}

resource "aws_iam_policy" "ec2_full_access" {
  name        = "ec2_full_access"
  description = "Provides full access to EC2"
  policy      = file("ec2_full_access_policy.json")
}

resource "aws_iam_policy_attachment" "ec2_full_access_attachment" {
  name       = "ec2_full_access_attachment"
  policy_arn = aws_iam_policy.ec2_full_access.arn
  users      = [aws_iam_user.first_user.name, aws_iam_user.user2.name, aws_iam_user.user3.name]
}
