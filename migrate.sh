#!/bin/bash

# Enable strict error handling
set -e

# Debug mode can be enabled by setting DEBUG=true
[[ "${DEBUG:-false}" == "true" ]] && set -x

# Function to display usage information
usage() {
    echo "Usage:"
    echo "  $0 export [--source-host HOST] [--source-token TOKEN] [--source-account-id ID]"
    echo "    Environment variables: DBT_CLOUD_HOST_URL, DBT_CLOUD_TOKEN, DBT_CLOUD_ACCOUNT_ID"
    echo ""
    echo "After exporting, cd into the target directory and use standard Terraform commands:"
    echo "  cd target"
    echo "  terraform init"
    echo "  terraform plan"
    echo "  terraform apply"
    exit 1
}

# Function to print section headers
print_header() {
    echo ""
    echo "=== $1 ==="
    echo ""
}

# Function to create a temporary directory for output
setup_temp_dir() {
    local temp_dir
    temp_dir=$(mktemp -d)
    echo "Created temporary directory: $temp_dir" >&2
    echo "$temp_dir"
}

# Function to cleanup temporary files
cleanup() {
    local temp_dir="$1"
    echo "Cleaning up temporary files..." >&2
    rm -rf "$temp_dir"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Export configuration from source instance
export_config() {
    print_header "Starting Export Process"
    
    # Set environment variables for dbtcloud-terraforming if not already set
    export DBT_CLOUD_HOST_URL="${DBT_CLOUD_HOST_URL:-$1}"
    export DBT_CLOUD_TOKEN="${DBT_CLOUD_TOKEN:-$2}"
    export DBT_CLOUD_ACCOUNT_ID="${DBT_CLOUD_ACCOUNT_ID:-$3}"

    # Create output directory
    mkdir -p ./target
    
    # Create or clear the resources.tf file
    : > "./target/resources.tf"

    # Check if resource types file exists
    if [ ! -f "resource_types.txt" ]; then
        echo "Error: resource_types.txt file not found"
        echo "This file is required and should contain a list of resource types to export"
        echo "Example resource types:"
        echo "  dbtcloud_global_connection"
        echo "  dbtcloud_group"
        echo "  dbtcloud_notification"
        exit 1
    fi

    # Read all resource types into a comma-separated string
    resource_types=$(grep -v '^[[:space:]]*$' resource_types.txt | tr '\n' ',')
    # Remove trailing comma if it exists
    resource_types=${resource_types%,}
    
    # Verify we have at least one resource type
    if [ -z "$resource_types" ]; then
        echo "Error: resource_types.txt is empty"
        echo "Please add at least one resource type to export"
        exit 1
    fi
    
    echo "Using resource types from resource_types.txt:"
    echo "$resource_types" | tr ',' '\n' | sed 's/^/  - /'
    echo ""

    print_header "Generating Configuration"
    
    # Run dbtcloud-terraforming for all resource types at once
    if dbtcloud-terraforming generate \
        --resource-types "$resource_types" \
        --linked-resource-types all \
        > "./target/resources.tf"; then
        echo "Successfully generated configuration"
    else
        echo "Error generating configuration"
        exit 1
    fi
    
    print_header "Export Complete"
    echo "Configuration has been exported to: ./target/resources.tf"
    echo "Next steps:"
    echo "1. cd target"
    echo "2. cp terraform.tfvars.example terraform.tfvars"
    echo "3. Edit terraform.tfvars with your target instance details"
    echo "4. terraform init"
    echo "5. terraform plan"
    echo ""
}

# Main script logic
case "$1" in
    export)
        shift
        source_host=""
        source_token=""
        source_account_id=""
        
        # Parse command line arguments if provided
        while [[ $# -gt 0 ]]; do
            case "$1" in
                --source-host)
                    source_host="$2"
                    shift 2
                    ;;
                --source-token)
                    source_token="$2"
                    shift 2
                    ;;
                --source-account-id)
                    source_account_id="$2"
                    shift 2
                    ;;
                *)
                    usage
                    ;;
            esac
        done

        # Use environment variables if available, otherwise use command line arguments
        source_host=${DBT_CLOUD_HOST_URL:-$source_host}
        source_token=${DBT_CLOUD_TOKEN:-$source_token}
        source_account_id=${DBT_CLOUD_ACCOUNT_ID:-$source_account_id}

        # Check if we have all required values from either source
        if [ -z "$source_host" ] || [ -z "$source_token" ] || [ -z "$source_account_id" ]; then
            echo "Error: Missing required values. Please provide either environment variables or command line arguments."
            usage
        fi

        export_config "$source_host" "$source_token" "$source_account_id"
        ;;

    *)
        usage
        ;;
esac 