resource "aws_ebs_volume" "volume" {

// Here , We need to give same AZ as the INstance Have.
    availability_zone = aws_instance.instance.availability_zone

// Size IN GiB
    size = 10

    tags = {

        Name = "ogu_na_itoolu"
    }    
}

// Lets Try To Print the AZ of volume and ID

output "volumeVal1" {

    value = "AZ of volume -> ${aws_ebs_volume.volume.availability_zone}"
    
}

output "volumeVal2" {

    value = "ID of Volume -> ${aws_ebs_volume.volume.id}"

}

// attach the volume

resource "aws_volume_attachment" "ebsAttach" {

    device_name = "/dev/sdh"
    volume_id = aws_ebs_volume.volume.id
    instance_id = aws_instance.instance.id

}

output "Done" {

    value = "Finaly Done !!"
}