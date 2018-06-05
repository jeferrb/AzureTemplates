#!/bin/bash

. ./azure_functions.sh --source-only


test_create_and_delete_group() {
	echo "### test_create_and_delete_group"
	
	local group_name="gromacs${RANDOM}"
	local region="westus2"

	init_log

	echo "Creating group ${group_name} in region ${region}"
	create_group ${group_name} ${region}
	
	echo "Deleting group ${group_name} in region ${region}"
	delete_group ${group_name} ${region}
 	
}


test_write_log() {
	echo "### test_write_log"
	init_log
	
	msg="Creating group group_name in region region"
	write_log "$msg"
}


set_variables() {
	source config.sh
	
	group_name="gromacs${RANDOM}"
	region="westus2"
		
	machine_name="${group_name}$(whoami)$(date +%s)"
	resource_group="$group_name"
	template_file="azuredeploy_non_image.json"
	vm_size="Basic_A0"
	machine_number=1
	vm_name="$group_name$machine_number"
	dns_label="${group_name}dnsprefix${machine_number}"
	admin_password=$ADMIN_PASS
	password_mount=$PASS_MOUNT
	admin_public_key="`cat ~/.ssh/id_rsa.pub`"
	
	echo " "
	echo "group_name=$group_name"
	echo "region=$region"
	echo "machine_name=$machine_name"
	echo "resource_group=$resource_group"
	echo "template_file=$template_file"
	echo "vm_size=$vm_size"
	echo "machine_number=$machine_number"
	echo "vm_name=$vm_name"
	echo "dns_label=$dns_label"
	echo "admin_password=$admin_password"
	echo "password_mount=$password_mount"
	echo "admin_public_key=$admin_public_key"
	echo " "

}

test_create_and_delete_machine() {
	echo "### test_create_and_delete_machine"

	set_variables	
	init_log
	
	echo "Creating group ${group_name} in region ${region}"
	create_group ${group_name} ${region}
	
	
	echo "Creating machine"
	create_machine $machine_name $resource_group $template_file $vm_size $vm_name $dns_label "$admin_password" "$password_mount" "$admin_public_key" &	
	sleep 10
	
	echo "Deleting group ${group_name} in region ${region}"
	delete_group ${group_name} ${region}
}

test_create_and_delete_many_machines() {
	echo "### test_create_and_delete_many_machines"
	n_machines=2
	
	set_variables
	init_log

	echo "#Creating group ${group_name} in region ${region}"
	create_group ${group_name} ${region}


	echo "#Creating $n_machines machines"
	create_machines $machine_name $resource_group $template_file $vm_size $vm_name $dns_label "$admin_password" "$password_mount" "$admin_public_key" $n_machines &
	sleep 10


	echo "Deleting group ${group_name} in region ${region}"
	delete_group ${group_name} ${region}
}

create_machine_for_test() {
	echo "Creating group ${group_name} in region ${region}"
	create_group ${group_name} ${region}

	echo "Creating machine"
	create_machine $machine_name $resource_group $template_file $vm_size $vm_name $dns_label "$admin_password" "$password_mount" "$admin_public_key" &
	sleep 10
}


#test_write_log
#test_create_and_delete_group
test_create_and_delete_machine
#test_create_and_delete_many_machines 
#test_get_machine_ip
#test_get_machines_ips
#test_ssh_credential
#test_execute


