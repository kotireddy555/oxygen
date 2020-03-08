module "ec2" {
  source = "git::ssh://git@github.com/kotireddy555/oxygen.git//ec2?ref=master"

   name                   = "ARC"
   ami                    = "ami-ebd02392"
   instance_type          = "t2.micro"
   key_name               = "test"
   vpc_security_group_ids = ["sg-96c597f6"]
   subnet_id              = "subnet-33c5187f"
}