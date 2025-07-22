
.PHONY: all  install_tools configure_firewall init_master join_workers install_flannel

ANSIBLE_INVENTORY = ansible/inventory.ini
PLAYBOOK_DIR = ansible/playbook

all: install_tools configure_firewall init_master join_workers install_flannel

install_tools:
	ansible-playbook -i $(ANSIBLE_INVENTORY) $(PLAYBOOK_DIR)/install_k8s_tools.yml

configure_firewall:
	ansible-playbook -i $(ANSIBLE_INVENTORY) $(PLAYBOOK_DIR)/configure_firewall.yml

init_master:
	ansible-playbook -i $(ANSIBLE_INVENTORY) $(PLAYBOOK_DIR)/init_k8s_master.yml

join_workers:
	ansible-playbook -i $(ANSIBLE_INVENTORY) $(PLAYBOOK_DIR)/join_k8s_workers.yml

install_flannel:
	ansible-playbook -i $(ANSIBLE_INVENTORY) $(PLAYBOOK_DIR)/install_flannel.yml
