#!/bin/bash
apt update
apt install -y apache2

# Get the instance ID using the instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Install the AWS CLI
apt install -y awscli

# Download the images from S3 bucket
#aws s3 cp s3://myterraformprojectbucket2023/project.webp /var/www/html/project.png --acl public-read

# Create a simple HTML file with the portfolio content and display the images
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>Webpage-1</title>
  <style>
    /* Add animation and styling for the text */
    @keyframes colorChange {
      0% { color: #ff5733; }
      50% { color: #33ff57; }
      100% { color: #3357ff; }
    }
    h1 {
      animation: colorChange 3s infinite;
      text-align: center;
    }
    body {
      font-family: Arial, sans-serif;
      text-align: center;
      background-color: #f4f4f4;
      padding: 20px;
    }
    .container {
      background: white;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
      display: inline-block;
    }
    .highlight {
      color: green;
      font-weight: bold;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>My First portfolio !</h1>
    <h2>Terraform Managed first Instance</h2>
    <h4>Instance ID: <span style="color:black">$INSTANCE_ID</span></h4>

  <p>Hi, I'm Ekta, a DevOps enthusiast passionate about creating efficient and scalable systems.</p>
  <p>With a focus on cloud infrastructure and containerized workflows, I aim to simplify complex tech and make it more accessible.</p>
  <p>Always eager to learn and grow in the tech world, I'm excited to connect and collaborate with like-minded individuals.</p>

  <p>Let's build something amazing together!</p>

  </div>
</body>
</html>
EOF

# Start Apache and enable it on boot
systemctl start apache2
systemctl enable apache2