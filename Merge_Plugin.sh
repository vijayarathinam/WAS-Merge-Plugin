#!/bin/bash

# Define paths for the plugin configuration files to be merged
WAS_Server1_PLUGIN="/opt/IBM/WebSphere/AppServer/profiles/AppSrv01/config/cells/Cell01/nodes/Node01/servers/Server1/plugin-cfg.xml"
WAS_Server2_PLUGIN="/opt/IBM/WebSphere/AppServer/profiles/AppSrv02/config/cells/Cell02/nodes/Node02/servers/Server2/plugin-cfg.xml"

# Define the destination for the merged plugin configuration file
MERGED_PLUGIN="/opt/IBM/WebSphere/HTTPServer/conf/plugin-cfg.xml"

# Define the path for the merge properties file
MERGE_PROPERTIES="/tmp/merge.properties"

# Generate the merge properties file
cat <<EOL > ${MERGE_PROPERTIES}
MergeSrc1=${WAS_Server1_PLUGIN}
MergeSrc2=${WAS_Server2_PLUGIN}
MergeDest=${MERGED_PLUGIN}
RemoveDuplicates=true
EOL

# Display the merge properties file for verification
echo "Generated merge.properties file:"
cat ${MERGE_PROPERTIES}

# Execute the MergePluginCfg command
/opt/IBM/WebSphere/AppServer/bin/MergePluginCfg.sh ${MERGE_PROPERTIES}

# Check if the merge was successful
if [ $? -eq 0 ]; then
    echo "Plugin configuration files merged successfully."
    echo "Merged file located at: ${MERGED_PLUGIN}"
else
    echo "Failed to merge plugin configuration files."
    exit 1
fi
