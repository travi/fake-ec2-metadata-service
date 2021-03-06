# Fake EC2 Metadata Service

So you’re developing an app that will run in a VM locally but relies on the [EC2 Metadata Service](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html) for some part of its behavior when running in Amazon’s cloud. How do you run the same thing locally?

Enter the Fake EC2 Metadata Service, a simple Sinatra app that exposes some of the functionality running on http://169.254.169.254.

## Setup

Create a loopback interface bound to 169.254.169.254 (this probably needs to be run with root privileges):

    ifconfig lo:0 169.254.169.254 netmask 255.255.255.255 up

Now run the app (also probably needs root, since it binds to port 80):

    ruby ec2-metadata-service.rb

## Example Requests

    curl http://169.254.169.254/latest/meta-data/local-ipv4
    curl http://169.254.169.254/latest/meta-data/local-hostname

