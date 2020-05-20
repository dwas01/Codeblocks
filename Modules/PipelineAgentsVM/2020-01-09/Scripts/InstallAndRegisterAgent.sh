az vm run-command invoke -g $1 -n $2 --command-id RunShellScript --scripts "
su sshusertest ; 
mkdir /home/sshusertest/vstsagent -p ;
cd /home/sshusertest/vstsagent ;
wget https://vstsagentpackage.azureedge.net/agent/2.147.1/vsts-agent-linux-x64-2.147.1.tar.gz -nc ;
tar zxvf vsts-agent-linux-x64-2.147.1.tar.gz -k ;
sudo ./bin/installdependencies.sh ;
./config.sh --unattended --acceptteeeula --url https://SCTSGermany.visualstudio.com --auth PAT --token $3 --pool IaC --agent $HOSTNAME ;
sudo ./svc.sh install ;
sudo ./svc.sh start ;
"


# oneliner to install agent locally
cd /home/sshusertest/vstsagent && sudo -u sshusertest ./config.sh --unattended --acceptteeeula --url https://SCTSGermany.visualstudio.com --auth PAT --token xxx --pool IaC --agent $HOSTNAME && sudo ./svc.sh install && sudo ./svc.sh start;
# oneliner to remove agent locally
cd /home/sshusertest/vstsagent && sudo ./svc.sh stop && sudo ./svc.sh uninstall && sudo -u sshusertest ./config.sh remove --unattended --auth PAT --token xxx;