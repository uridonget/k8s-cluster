import os

def generate_inventory():
    num_nodes = int(os.environ.get('VAGRANT_VM_COUNT', 3))

    inventory_content = "[masters]\n"
    inventory_content += f"master-node ansible_host=192.168.56.101\n\n"

    if num_nodes > 1:
        inventory_content += "[workers]\n"
        for i in range(2, num_nodes + 1):
            inventory_content += f"worker-node-{i-1} ansible_host=192.168.56.{100 + i}\n"
        inventory_content += "\n"

    inventory_content += "[all:vars]\n"
    inventory_content += "ansible_user=ubuntu\n"
    inventory_content += "ansible_ssh_private_key_file=~/.ssh/k8s-key\n"
    inventory_content += "ansible_python_interpreter=/usr/bin/python3\n"
    inventory_content += "host_key_checking = False\n"
    inventory_content += "ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'\n"

    # project_root를 사용자 홈 디렉토리를 기준으로 설정
    project_root = os.path.expanduser("~/k8s")
    inventory_dir = os.path.join(project_root, "ansible")
    os.makedirs(inventory_dir, exist_ok=True)
    inventory_path = os.path.join(inventory_dir, "inventory.ini")

    with open(inventory_path, "w") as f:
        f.write(inventory_content)

    print(f"Generated inventory.ini at {inventory_path}")

if __name__ == "__main__":
    generate_inventory()