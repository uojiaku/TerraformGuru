
variable "awsprops" {
    default = {
        region = "us-east-1"
        vpc = "vpc-0744c5df62048e82a"
        ami = "ami-006dcf34c09e50022"
        itype = "t2.micro"
        subnet = "subnet-0754e2b9175066ec6"
        publicip = true
        keyname = "tf-key-pair"
        secgroupname = "IAC-Sec-Group"
        secgroupdescription = "IAC-Sec-Group"
        interface_id = "eni-091a56ac3b5e5143f"
    }
}