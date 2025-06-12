#!/bin/bash


########################################################################
# Author:      Rupaaz
# Date:        10th June 2025
# Title:       My first bash project
# Description: This project sends 5 ping to 'google.com' every 5 minutes
#              and then records average ping time in a .txt file.
########################################################################


# Let's store the Domain Name in a variable.
DomainName=$1;


# Create directory 'PingData' to store all data in it  if it's not already created
if [[ ! -d "$HOME/My Codes/PingData" ]]; then

	mkdir "$HOME/My Codes/PingData"

	echo -e  "\nThe directory 'PingData' is created successfuly."

else

	echo -e "\nThe directory 'PingData' is already exist."

fi


# Now lets send 'Ping' to the target Domain Name for 5 times and store that in a .txt file
ping -c 5 $DomainName >> ping.txt


# Let's extract line 2 to 6 of 'ping.txt' file which contain actual ping data
head -n 6 ping.txt | tail -n 5 |

# Now lets extract 8th column of the ping data which contains ping time
awk '{print $8}' |

# Now lets extract only the time from each string
cut -d '=' -f2 |

# Now sum all the ping times together and store in a .txt file
awk '{sum += $1} END {print sum}' >> totaltime.txt

# Calculate average time and store in a .txt file
declare TotalTime=$(cat totaltime.txt)

declare AverageTime=$(echo "scale=2;  $TotalTime/5" | bc)

# Store Average Time in a .txt file
echo "The Average Time taken to ping $DomainName 5 times is $AverageTime ms." >> "$HOME/My Codes/PingData/AveragePingTimes.txt"

# Now delete unnecessary files
rm -f ping.txt totaltime.txt

# Confirm that the code executed without error
echo -e "\nThe code executed successfully!"

