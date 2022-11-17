# Azure Files - Create and Mount script
This script automatically creates and mounts Azure Files shares in Linux VMs, leveraging Managed Identities to authorise the API calls securely and without a secret.

# Requirements
- cifs-utils and jq packages are installed on the Linux VM

    - dnf/apt-get install cifs-utils - package required to mount SMB shared on Linux
    - dnf/apt-get install jq - package required to parse JSON data to retrieve Azure AD token

- Managed Identitiy enabled for the VM running this script

    System-Assigned (or User-Assigned) Managed Identitify is enabled
    The folloiwng roles are assigned:
    - Storage Account Contributor
    - Files SMB Elavated Contributor
    - Resource Group Reader

- You have prepared the script by editing the variables 
    - sub-id - the long alphanumeric string of your subscription
    - rg - the name of the resource group that this VM and Azure Files instance reside in
    - storacc - the name of the Storage Account to be used to create Files shares
    - sak - the primary Access Key of the above Storage Account
    - settings - the settings for the Files share
        - Tier: Transaction Optimized, Hot or Cool
        - Quota: 1-5120 (GBs - standard shares have a 5TB limit)
- You have made the script executable
    - sudo chmod -x create-and-mount-afshare.sh

# Running the script
Simply run the below command, replacing "example" with the desired name of the share to be created and mounted

    - bash ./create-and-mount-afshare.sh example
