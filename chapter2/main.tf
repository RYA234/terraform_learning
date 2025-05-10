#  terraformブロック　以下のことを決める
#  プロバイダーへの要求事項の設定
#  HCP　Terraformの設定（第５章で解説）
#  ステートファイルのHCP　Terraform への移行
terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
            version = ">= 3.0.0"
        }
    }
}

#  provider ブロック
#  プロバイダーの設定
provider "docker"{
    host = "unix:///var/run/docker.sock"
}


# resource　ブロック
# 
resource "docker_image" "nginx"{
    name = "nginx:latest"
    keep_locally = true
}


resource "docker_container" "nginx"{
    image = docker_image.nginx.image_id
    name = "tutorial"
    ports{
        internal = 80
        external = 8000
    }
}
