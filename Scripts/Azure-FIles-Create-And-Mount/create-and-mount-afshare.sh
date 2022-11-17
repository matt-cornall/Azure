# Exit script in the event of any errors or failures
set -e

# Provide a name for the new Share
share=$1

# Set your variables here
subid=subscription-id
storacc=storage-account-name
rg=rg-resource-group-name
sak=storage-access-key-primary
settings="{'properties': {'accessTier': 'Cool', 'shareQuota': '1024'}}"

# Collecting secure token from Azure AD via VM Managed Identity
token=$(curl -X GET 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://management.azure.com/' -H Metadata:true | jq --raw-output .access_token)

# Call Azure Storage Service to create share
curl -H "Content-Type: application/json" -H "Accept: application/json" -H "Authorization: Bearer $token" -X PUT -d "$settings" "https://management.azure.com/subscriptions/$subid/resourceGroups/$rg/providers/Microsoft.Storage/storageAccounts/$storacc/fileServices/default/shares/$share?api-version=2022-05-01"

# Pause while storage is provisioned
echo
echo
echo "Waiting to mount while File share is created...(10 seconds)"
sleep 10
echo

# Create directory and mount storage
sudo mkdir /mnt/$share
if [ ! -d "/etc/smbcredentials" ]; then
sudo mkdir /etc/smbcredentials
fi
if [ ! -f "/etc/smbcredentials/$storacc.cred" ]; then
    sudo bash -c "echo "username=$storacc" >> /etc/smbcredentials/$storacc.cred"
    sudo bash -c "echo "password=$sak" >> /etc/smbcredentials/$storacc.cred"
fi
sudo chmod 600 /etc/smbcredentials/$storacc.cred
sudo bash -c "echo "//$storacc.file.core.windows.net/$share /mnt/$share cifs nofail,credentials=/etc/smbcredentials/$storacc.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30" >> /etc/fstab"
sudo mount -t cifs //$storacc.file.core.windows.net/$share /mnt/$share -o credentials=/etc/smbcredentials/$storacc.cred,dir_mode=0777,file_mode=0777,serverino,nosharesock,actimeo=30 
echo
echo "Complete."
echo