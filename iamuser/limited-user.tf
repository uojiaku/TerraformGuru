
## create user
resource "aws_iam_user" "createosi" {
    name = "osi"
}

## create group
resource "aws_iam_group" "groupnzuko" {
    name = "nzuko"
    path = "/users/"
}

## add user to group
resource "aws_iam_group_membership" "squadosi" {
    name = "add-osi-to-group"
    users = [ "osi" ]
    group = aws_iam_group.groupnzuko.name
}

## create policy
resource "aws_iam_policy" "limitedpolicy" {
    name = "limitedaccess"
    description = "Giving limited access to the group"
    policy = "${file("limited_group_policy.json")}"
}

# add policy to group
resource "aws_iam_group_policy_attachment" "attachpolicyosi" {
    group = aws_iam_group.groupnzuko.name
    policy_arn = aws_iam_policy.limitedpolicy.arn
}