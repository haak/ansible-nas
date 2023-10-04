run:
	ansible-playbook -i inventories/inventory.yml nas.yml --become-password-file ./.vault_pass
run1:
	ansible-playbook -i inventories/inventory.yml nas.yml -K --limit pc-its130
tagged:
	ansible-playbook -i inventories/inventory.yml main.yml --vault-password-file ~/.vault_pass --tags $(tag)

run-limit:
	ansible-playbook -i inventories/inventory.yml --limit $(host) main.yml --vault-password-file ~/.vault_pass

dynamic:
	ansible-playbook -i inventories/inventory.yml --limit $(host) dynamic-roles/dynamic-roles-playbook.yml -K

ping:
	ansible all -i inventories/inventory.yml -m ping

requirements:
	ansible-galaxy install -r requirements.yml

vagrant:
	vagrant up && vagrant provision
