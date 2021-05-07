Mediawiki Installation on AWS using Terraform and Ansible Playbook: 
===================================================================


Infra Details:
----------------
 - Terraform is used to create below Infrastructure
 	- 1 VPC
 	- 2 Subnets  
 	- 1 Keypair 
 	- 2 EC2 Instances - 1 Web and 1 DB
 	- 1 Elastic Load Balancer

 - Note: I have used single web server because of infra limitation but more can be used as per the requirements.


Configuration Management Details:
---------------------------------
 - Ansible does the config Management and performs the following: 
    - Dynamically fetches resources based on the tags you defined in the terraform IaC using ec2.py and ec2.ini files copied from github.
    - Installation of the mariadb.
    - Database and Users creation. 
    - Encrypts the passwords into a vault. 
    - Role that installs Apache HTTPD, PHP on amazon linux.
    - Mediawiki specific Webserver configuration
    - Start webserver and ready for use from web.


Pre-Requisites: 
---------------
1. Terraform is installed and the PATH is set. 
	
2. AWS Secret variables are set: 
	Tip:
	```
	export AWS_ACCESS_KEY_ID='****'
	export AWS_SECRET_ACCESS_KEY='***'
	export EC2_INI_PATH=ec2.ini
	```
3. Python 2.7+ and Ansible 2.x is installed
	
	More info on: 
	https://docs.ansible.com/ansible/devel/installation_guide/intro_installation.html

Execution steps
===============
Clone the Repo
-------------
1. Clone the Repository. 

2. Navigate to the folder: terrform-aws-infra:

	``` cd terrform-aws-infra```
	
Terraform Initialize
--------------------
3. Initialize the working directory.:

    ```terraform init -input=false```

Plan
----
4. Create a plan and save it to the local file tfplan: 

	```terraform plan -out=tfplan -input=false``` 

Apply
-----
5. Apply the plan stored in the file tfplan.
	```terraform apply -input=false -auto-approve tfplan``` 

Key
---
6. Output the autogenerated keypair into a file for ansible. 
	```terraform output pem > ../ansible-playbook/mediawiki.pem```
	
Ansible Playbook
----------------
7. Run Ansible Playbook site.yml which will install DB and Webserver as per roles:

	```cd ../ansible-playbook ```
  	```ansible-playbook site.yml -i ec2.py --private-key mediawiki.pem --ask-vault-pass -u ec2-user -v```
   Note: vault key is mw.

9. Open the Browser to complete the installation wizard. 
