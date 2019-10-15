#-----compute/main.tf#-----

data "aws_ami" "server_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "tf_auth" {
  key_name   = "${var.key_name}"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNxP/0YyCfOASxdzbW3xDcbIQU9wKvC0Jz18og/mXaxYFiYXMMQ+NQpsHbCz4jg4cLQJMLZ4enSELqQ/H3vkykkKoCPSXcJbI6SUj/plokz0338KBVpn/7axN50Mq4S/6DB31IIZv0aQrDi1PY7LLCjitX3Kx6dcwOHcut8GrnVa2kalafsHlzxvyJQH+pCE5O8mwIQKj+taBFyJiSQvD2FB+XROxrhqlJfzICx4DDPPEKkP2uzNT/Q3A+YPwZvMeuJwXJAASR1sOYfORRdCBTbvpplFlwGo61RvABVb1TEg89izcKUYcNYIteb5Wsy6hzcMxdtLAfcily+bgJg2bh malyadribeegala@mbeegala-mac"
}

resource "aws_instance" "tf_server" {
  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami           = "${data.aws_ami.server_ami.id}"

  tags={
    Name = "tf_server-${count.index +1}"
  }

  key_name               = "${aws_key_pair.tf_auth.id}"
  vpc_security_group_ids = ["${var.security_group}"]
  subnet_id              = "${element(var.subnets, count.index)}"
  }
  
