# Azure and Terraform Repository
Here lies a collection of Infrastructure as Code templates for deploying
reference architecture to Azure.

# Tips
Before attempting run any IaC templates, ensure you follow the guide to
configure terraform within Azure CLI.

- Step 1: Check current version within Azure CLI using "terraform version"
- Step 2: If you're on an old version, grab the URL for the Linux AMD64 from https://www.terraform.io/downloads.html
- Step 3: Download it to the /home/<user>/ folder with "wget <URL you copied>"
- Step 4: Unzip it with "unzip <filename>"
- Step 5: Create a bin directory in your home folder using "mkdir bin"
- Step 6: Move the Terraform binary into the bin folder using "mv terraform bin/"
- Step 7: Restart the Azure CLI
- Step 8: Confirm the update using "terraform version"
