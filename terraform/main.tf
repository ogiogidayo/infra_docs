provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "hello_world" {
  ami           = "ami-0253ce315ad0c9655"
  instance_type = "t2.micro"

  tags = {
    Name = "Hello World"
  }
}
