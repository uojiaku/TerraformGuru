terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "mysql" {
  name = "mysql:8"
}

resource "random_password" "mysql_root_password" {
  length = 16
}

resource "docker_container" "mysql" {
  name = "mysql"
  image = "${docker_image.mysql.latest}"

  //env =  MYSQL_ROOT_PASSWORD = "${random_password.mysql_root_password.result}"
  env = [ "MYSQL_ROOT_PASSWORD=1234", "MYSQL_USER=user1", "MYSQL_DATABASE=items", "MYSQL_PASSWORD=mypa55" ]
  
  
  

  /*mounts {
    source = "/Users/ojiakuboss/TerraformGuru/mysql/fresh"
    target = "/var/lib/mysql/data"
    type = "bind"
  }*/
  ports {
    internal = 3306
    external = 3306
  }
}

// mysql -uroot -p
// password: 1234