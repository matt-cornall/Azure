echo "Welcome to Matt's Azure create and mount share script!"
echo
echo "Prerequisites:"
echo "- System-assigned managed identity created for this VM"
echo "- Elevated SMD Data Contributor role assigned against the target Storage Account"
echo "- You know the customer's CRM ID"
echo
echo "Let's go.."
echo
read -p "Please enter the customer ID we're creating the share for:" crmid
read -p "Please enter the storage account name (this is case sensitive):" storid
echo
echo "Ok, creating the Azure Files share via API call"
curl -x PUT -d ""