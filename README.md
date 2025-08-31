./make-vms.sh 4

python -m venv venv

source venv/bin/activate

python3 ansible/generate_inventory.py

pip3 install ansible

make

# Blog

https://ddingddang.tistory.com/73

https://ddingddang.tistory.com/74
