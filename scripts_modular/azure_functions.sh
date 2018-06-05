#!/bin/bash
source config.sh

init_log() {
 	mkdir -p ${LOG_DIR}
	> $LOG_FILE
	write_log "start"
 }
 
write_log() {
	local msg=$1
	echo "$(date) $msg" >> ${LOG_FILE}
}

create_group() {
	local group_name=$1
	local region=$2

	write_log "Creating group ${group_name} in region ${region}"
	
	az group create --name $group_name --location ${region}

	if [ ! $? -eq 0 ]; then
		msg="Failed to create group ${group_name} exiting" 
		echo "$msg"
		write_log "$msg"
	    exit
	fi
	write_log "group created"

}

delete_group() {
	local group_name=$1
	
	write_log "Deleting group ${group_name} in region ${region}"
	
	az group delete --no-wait --name $group_name --yes 

	if [ ! $? -eq 0 ]; then
		msg="Failed to create group ${group_name} exiting" 
		echo "$msg"		
		write_log "$msg"
	    exit
	fi

}

create_machine() {
	local machine_name=$1
	local resource_group=$2
	local template_file=$3
	local vm_size=$4
	local vm_name=$5
	local dns_label=$6
	local admin_password=$7
	local password_mount=$8
	local admin_public_key=$9
	
	
	write_log "creating machine $machine_name $vm_name"
	
	az group deployment create --name "$machine_name" --resource-group "$resource_group" \
		    	--template-file "$template_file" --parameters vmSize="$vm_size" \
		vmName="$vm_name" dnsLabelPrefix="$dns_label" \
		adminPassword="$admin_password" scriptParameterPassMount="$password_mount" \
		adminPublicKey="$admin_public_key" >> $LOG_MSG_AZURE
	
	write_log "machine $machine_name $vm_name created"
}

create_machines() {
	local machine_name=$1
	local resource_group=$2
	local template_file=$3
	local vm_size=$4
	local vm_name=$5
	local dns_label=$6
	local admin_password=$7
	local password_mount=$8
	local admin_public_key=$9
	
	local number_instances=${10}
	

	echo "num_instances=$number_instances"
	for (( i = 1; i <= $number_instances; i++ )); do
		sufix="num$i"
	    create_machine "$machine_name$sufix" $resource_group $template_file $vm_size "$vm_name$sufix" "$dns_label$sufix" "$admin_password" "$password_mount" "$admin_public_key" 	&
	    sleep 20
	done
	wait
	sleep 190

}






