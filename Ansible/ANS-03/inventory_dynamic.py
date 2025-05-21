#!/usr/bin/env python3
import json

inventory = {
    "all": {
        "hosts": ["web1"],
        "vars": {},
    },
    "_meta": {
        "hostvars": {
            "web1": {
                "ansible_host": "10.37.129.3",
                "ansible_user": "vagrant",
                "ansible_password": "vagrant",
                "ansible_ssh_common_args": "-o StrictHostKeyChecking=no"
            }
        }
    }
}

print(json.dumps(inventory))
