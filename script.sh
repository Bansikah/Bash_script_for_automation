#!/bin/bash

# Function to greet the user and present the menu
greet_user() {
    echo "Hello! Welcome to the script."
    echo "Please select a task to execute:"
    echo "1. User Interaction"
    echo "2. System Inspection and Report"
    echo "3. File Operations"
    echo "4. Bonus Challenge - Data Fetching"
    echo "5. Exit"
}

# Function to perform system inspection and report
system_inspection() {
    # List all running processes and output to a file
    sudo ps -ef > processes.txt
    echo "List of running processes saved to processes.txt"

# Check active network connections and output to a file
    netstat -an > network_connections.txt
    echo "Active network connections saved to network_connections.txt"

  
    # Check disk usage, identify directories consuming the most space, and output to a file
    #du -h / | sort -rh > disk_usage.txt
    sudo du -h > disk_usage.txt
    echo "Disk usage summary saved to disk_usage.txt"

    
    # Summarize the findings in a brief report
    echo "System Inspection and Report Summary:"
    echo "-----------------------------------"
    echo "Running processes: $(wc -l < processes.txt)"
    echo "Disk space used: $(du -sh / | awk '{print $1}')"
    echo "Top 5 directories consuming disk space:"
    du -h / | sort -rh | head -n 5
    echo "Active network connections: $(wc -l < network_connections.txt)"
}

# Function to perform file operations
file_operations() {
    # Function to search for files by extension within a specified directory
    search_files() {
        read -p "Enter the directory path to search: " directory
        read -p "Enter the file extension to search (e.g., .txt): " extension

        echo "Searching for files with extension $extension in directory $directory..."
        find "$directory" -type f -name "*$extension"
    }

    # Function to count the number of lines in a specified file
    count_lines() {
        read -p "Enter the file path to count lines: " file

        echo "Counting the number of lines in file $file..."
        wc -l "$file"
    }

    # Function to backup a specified directory to a chosen location
    backup_directory() {
        read -p "Enter the directory path to backup: " directory
        read -p "Enter the backup location directory: " backup_location

        echo "Backing up directory $directory to $backup_location..."
        cp -r "$directory" "$backup_location"
        echo "Backup completed!"
    }

    # File operations menu
    echo "Please select a file operation:"
    echo "1. Search for files by extension"
    echo "2. Count the number of lines in a file"
    echo "3. Backup a directory"
    echo "4. Back to main menu"

    # Reading user input for file operations
    read -p "Enter your choice: " file_operation_choice

    # Checking user choice for file operations and executing tasks
    if [[ $file_operation_choice == "1" ]]; then
        search_files
    elif [[ $file_operation_choice == "2" ]]; then
        count_lines
    elif [[ $file_operation_choice == "3" ]]; then
        backup_directory
    elif [[ $file_operation_choice == "4" ]]; then
        echo "Returning to the main menu..."
    else
        echo "Invalid choice. Returning to the main menu..."
    fi
}

# Function to perform the bonus challenge of fetching real-time weather data
fetch_weather_data() {
    read -p "Enter the city name: " city
    read -p "Enter the API key for weather data (e.g., OpenWeatherMap API key): " api_key

    echo "Fetching weather data for $city..."
    weather_data=$(curl -s "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$api_key")

    # Parsing the weather data using jq (ensure jq is installed)
    temperature=$(echo "$weather_data" | jq -r '.main.temp')
    weather=$(echo "$weather_data" | jq -r '.weather[0].description')

    echo "Current weather in $city: $weather"
    echo "Temperature: $temperature °C"
}

# Main script logic
while true; do
    greet_user
    read -p "Enter your choice: " choice

    case $choice in
        1)
            echo "Performing User Interaction..."
            # Add your code for User Interaction here
            ;;
        2)
            echo "Performing System Inspection and Report..."
            system_inspection
            ;;
        3)
            echo "Performing File Operations..."
            file_operations
            ;;
        4)
            echo "Performing Bonus Challenge - Data Fetching..."
            fetch_weather_data
            ;;
        5)
            echo "Exiting the script. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac

    echo
done