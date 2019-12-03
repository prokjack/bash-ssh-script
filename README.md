# bash-ssh-script
Script that adding function to connect through ssh to multiple machines with config in JSON


## Preconditions

Need to be installed [jq](https://stedolan.github.io/jq/download/) to parse json properly
### How to use

Copy content of [.bash_profile](.bash_profile) to your user

Copy [server_parsing.sh](server_parsing.sh) to custom dir and set up it's path in [.bash_profile](.bash_profile)

After starting script content of [servermap.json](servermap.json) will be parsed and available after command [show](server_parsing.sh#L43)

Supports autocomplete.

For inner objects can be used separator `:`

Example json and command: 
```
{
  "server2": {
    "INT": {
          "staging": "10.0.0.3",
          "production": "10.0.0.4"
    },
    "EXT": {
          "staging": "10.0.0.5",
          "production": "10.0.0.6"
    }
  }
}
```
```  
	bash$ show server2:INT:production
```
Will be executed:
```
	ssh -A -tt ubuntu@10.0.0.4 ". ~/.profile; sudo -s"
```
