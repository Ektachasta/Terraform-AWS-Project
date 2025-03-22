resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  
  tags = {
    Name = "my-sub1"
  }
}


resource "aws_subnet" "sub2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-sub2"
  }
}

resource "aws_internet_gateway" "myIGW" {
    vpc_id = aws_vpc.myvpc.id
}

resource "aws_route_table" "myRT" {
    vpc_id = aws_vpc.myvpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myIGW.id
   }
}

resource "aws_route_table_association" "RTassociation1" {
    subnet_id      = aws_subnet.sub1.id
    route_table_id = aws_route_table.myRT.id
}

resource "aws_route_table_association" "RTassociation2" {
    subnet_id      = aws_subnet.sub2.id
    route_table_id = aws_route_table.myRT.id
} 

resource "aws_security_group" "mySG" {
    vpc_id = aws_vpc.myvpc.id

   ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-sg"
  }
}

resource "aws_s3_bucket" "mybucket" {
  bucket = "myunique-bucket-12345"
}

resource "aws_instance" "webserver1" {
  ami           = "ami-0e35ddab05955cf57"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.sub1.id
  vpc_security_group_ids = [aws_security_group.mySG.id]
  user_data              = base64encode(file("userdata.sh"))
  tags = {
    Name = "myfirstec2"
  }
}

  resource "aws_instance" "webserver2" {
  ami           = "ami-0e35ddab05955cf57"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.sub2.id
  vpc_security_group_ids = [aws_security_group.mySG.id]
  user_data              = base64encode(file("userdata2.sh"))
  tags = {
    Name = "mysecondec2"
  }
}

resource "aws_lb" "my_alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.mySG.id]
  subnets            = [aws_subnet.sub1.id, aws_subnet.sub2.id]
  tags = {
    name = "web"
  }
}

resource "aws_lb_target_group" "my_target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "attachment1" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.webserver1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attachment2" {
  target_group_arn = aws_lb_target_group.my_target_group.arn
  target_id        = aws_instance.webserver2.id
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.my_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

output "load_balancer_dns" {
  value = aws_lb.my_alb.dns_name
}