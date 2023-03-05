
## create user
resource "aws_iam_user" "createuser" {
    name = var.username
}

## create group
resource "aws_iam_group" "anewgroup" {
    name = "obodo"
    path = "/users/"
}

## add user to group
resource "aws_iam_group_membership" "squad" {
    name = "add-user-to-group"
    users = [ var.username ]
    group = aws_iam_group.anewgroup.name
}

## create policy
resource "aws_iam_policy" "anewpolicy" {
    name = "administrativeaccess"
    description = "Giving all access to the group"
    policy = "${file("group_policy.json")}"
}

# add policy to group
resource "aws_iam_group_policy_attachment" "attachpolicy" {
    group = aws_iam_group.anewgroup.name
    policy_arn = aws_iam_policy.anewpolicy.arn
}