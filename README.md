# bash-ssh-script
Script that adding function to connect through ssh to multiple machines with config in JSON


## Preconditions

Need to be installed jq to parse json properly

### How to use

Copy content of .bash_profile to your user
Copy server_parsing.sh to custom dir and set up it's path in .bash_profile

After starting script content of servermap.json will be parsed and available after command `show`
Supports autocomplete



Example: 
	show <ENTER>
	show server2:INT:production

	Will be executed 
		ssh -A -tt ubuntu@10.0.0.4 ". ~/.profile; sudo -s"