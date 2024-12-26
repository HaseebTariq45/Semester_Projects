#include<iostream>
#include<fstream>
#include<string>
using namespace std;

const int No_Of_Packets = 10;     // Assume Number of packets
const int No_Of_Rules = 10;       // Assume Number of rules
int index_of_SDP_struct = 0;      // Making it global because its value was again initialized again to '0' due to recursion

// Structure to store Source, Destination, and Protocol
struct SDP   {
    string source;
    string destination;
    string protocol;
};

// Structure to store Rule details
struct Rules    {
    int rule_number;
    string To_Apply;
    string IP_or_Pro;
    string action;
};

                                    // FUNCTIONS PROTOTYPING

// Function to import the sample file and store it in the SDP struct              
void Import_Sample_File(SDP Src_DST_Pro[No_Of_Packets]);
// Function to separate the packets from the sample string using recursion
void Packets(string Sample_String, SDP Src_DST_Pro[No_Of_Packets]);
// Function to separate the individual components of a single packet
void Seprate(string Single_Packet, SDP Src_DST_Pro[No_Of_Packets]);
// Function to import the rule file and store it in the Rules struct
void Import_Rule_File(Rules rule[No_Of_Rules]);
// Function to apply the rules to the packets and write the result to a file
void applyRule(SDP packet[No_Of_Packets], Rules rule[No_Of_Rules]);
// Function to check if a range exists in the pattern segment
bool RangeExists(string patternSegment);
// Function to match the IP pattern with the target IP
bool matchIP(string pattern, string target);
// Function to check if a value is within a given range
bool isInRange(string range, int value);

// Function to import the sample file and store it in the SDP struct
void Import_Sample_File(SDP Src_DST_Pro[No_Of_Packets])   {
    fstream Sample_File;
    string Sample_String; // String to store the read data from the file
    Sample_File.open("sample.txt",ios::in);    // read mode
        if(Sample_File.is_open())    {
                                                    // Read the entire line (assumed to be a single line) from the file
            Sample_File >> Sample_String;           // This line is expected to contain the packet data to be processed
            Sample_File.close();
        }
        else    {
            // If the file could not be opened, display an error message
            cout << "Sample File not found !";
        }
    Packets(Sample_String,Src_DST_Pro);       // This function will seprate packets
}

// Function to recursively process packet data from a string and extract individual packets
void Packets(string Sample_String,SDP Src_DST_Pro[No_Of_Packets])  {  
    // Find the position of the closing bracket in the Sample_String
    int loc1 = Sample_String.find("]");

    if (loc1 >= 0)   {    // Recursion base case: check if the closing bracket is found   

        string Single_Packet = Sample_String.substr(0,loc1+1);   // Extract the single packet string up to and including the closing bracket
        Sample_String = Sample_String.substr(loc1+1);     // Update the Sample_String by removing the extracted single packet part

        Seprate(Single_Packet,Src_DST_Pro);    // Send the single packet string to the Seprate function for further processing
        
        Packets(Sample_String,Src_DST_Pro);    // Recursively call the Packets function with the updated Sample_String
    }
    // If no closing bracket is found, the function will end,
    // as it indicates there are no more packets to process in the string
}

// Function to separate components of a single packet string into source, destination, and protocol
void Seprate(string Single_Packet,SDP Src_DST_Pro[No_Of_Packets]) {
    string seprate; // String to hold the current component being extracted
    int index = 0; // Index for iterating through the Single_Packet string

    // Loop through each character in the Single_Packet string
    while(Single_Packet[index] != '\0')    {
      // Storing whole 'Single_Packet' string which is bassically whole sample file into another string character by character.
        seprate += Single_Packet[index];  // This is done to seprate all the components while in iteration.

       // Check if the current character is a semicolon, indicating the end of a component
        if(Single_Packet[index] == ';') {
           // Remove the semicolon from the end of the 'seprate' string           
            seprate.pop_back();

           // Check if the current component is the source IP
            if(seprate.find("SRC:") == 1)   {
               // Extract the source IP and store it in the SDP struct
                Src_DST_Pro[index_of_SDP_struct].source = seprate.substr(5);
            }

            // Check if the current component is the destination IP
            if(seprate.find("DST:") == 0)   {
                // Extract the destination IP and store it in the SDP struct
                Src_DST_Pro[index_of_SDP_struct].destination = seprate.substr(4);
            }

            // Check if the current component is the protocol
            if(seprate.find("PRO:") == 0)   {
                // Extract the protocol and store it in the SDP struct
                Src_DST_Pro[index_of_SDP_struct].protocol = seprate.substr(4);

               // Increment the index to move to the next SDP struct in the array
                index_of_SDP_struct++;   
            }

              // Reset the 'seprate' string for the next component
            seprate = "";
        }  
           // Move to the next character in the Single_Packet string
            index++;
        }  
}


// Function to import the rule file and store it in the Rules struct
void Import_Rule_File(Rules rule[No_Of_Rules])  {
    // Initialize a file stream to read from the rules file
    fstream Rule_File;
    Rule_File.open("rules.txt",ios::in);

    // Check if the rules file has been opened successfully
    if(Rule_File.is_open()) {
      int rule_count = 0; // Counter for the number of rules read

       // Continue reading until the end of the file is reached
    while (!Rule_File.eof())    {  
        // Read the rule number from the file and store it in the rule array
        Rule_File >> rule[rule_count].rule_number; 

        // Read the type of rule (SRC, DST, or PRO) and store it
        Rule_File >> rule[rule_count].To_Apply; 

        // Read the IP or protocol that the rule applies to and store it
        Rule_File >> rule[rule_count].IP_or_Pro; 

        // Read the action associated with the rule and store it
        Rule_File >> rule[rule_count].action;

        // Increment the rule counter
        rule_count++;
    }
        // Close the file stream once all rules have been read
        Rule_File.close();
    }
    else {
        // Print an error message if the file could not be opened
        cout << "Enable to read Rule file" << endl;
    }
}


// Function to apply the rules to the packets and write the result to a file
void applyRule(SDP packet[No_Of_Packets], Rules rule[No_Of_Rules])
{                              
    fstream result;

    result.open("result.dat",ios::out); // Open the result file in write mode

    if(result.is_open())    {   // Check if the result file is successfully opened

        for (int i = 0; i < No_Of_Packets; i++)     { // Loop through each packet 

            for (int j = 0; j < No_Of_Rules; j++)       {   // Loop through each rule 
                bool flag = false;


                if(rule[j].To_Apply == "SRC")    // Apply rule to the source IP
                {   
                    if(RangeExists(rule[j].IP_or_Pro))  {

                    flag = (matchIP(rule[j].IP_or_Pro, packet[i].source));

                }
                    else
                    flag = (packet[i].source == rule[j].IP_or_Pro);
                }
                else if(rule[j].To_Apply == "DST")  // Apply rule to the destination IP
                {   
                    if(RangeExists(rule[j].IP_or_Pro))  {

                    flag = (matchIP(rule[j].IP_or_Pro, packet[i].destination));

                }
                    else
                    flag = (packet[i].destination == rule[j].IP_or_Pro);
                }
                else if(rule[j].To_Apply == "PRO")  // Apply rule to the protocol
                {
                    flag = (packet[i].protocol == rule[j].IP_or_Pro);
                }

                if (flag)   // If the rule matches, write the result to the file
                {
                    result << "SRC " << packet[i].source << " DST " << packet[i].destination << " PRO " << packet[i].protocol
                    << " " << rule[j].action << " " << rule[j].rule_number << endl;
                    break;
                } 
            }
    }       
    result << endl << endl << endl << endl << endl << "\t\t\t\t Semester Final Project \n\n\n\tMade By:\nAli Hamza\nBasim Mehdi\nAbdullah Mehmood\nSoban Yam" << endl;
    result.close();
    }
    else    {
        cout << "Unable to write result file !" << endl;
    }
}

// Function to check if a range exists in the pattern segment
bool RangeExists(string patternSegment)  {
    // Check if the patternSegment string contains a dash ('-')
    if(patternSegment.find('-') != string::npos)    {
        // If a dash is found, it indicates the presence of a range
        return true;
    }
        // If no dash is found, it means the patternSegment does not represent
        else return false;
}


// Function to match the IP pattern with the target IP
bool matchIP(string pattern, string target) {
    // Initialize positions for scanning the pattern and target strings
    int patternPos = 0, targetPos = 0;
    // Variables to store positions of the next dot ('.') in pattern and target
    int patternNext, targetNext;

   // Loop until we reach the end of either the pattern or the target string
    while (patternPos < pattern.size() && targetPos < target.size()) {
       // Find the next dot in the pattern string from the current position
        patternNext = pattern.find('.', patternPos);
        targetNext = target.find('.', targetPos);
        // If find does not find the character or substring, it returns string::npos.

        // If find does not find the character or substring, it returns string::npos
        if (patternNext == string::npos)    patternNext = pattern.size();
        if (targetNext == string::npos)     targetNext = target.size();

        // Extract the current segment from the pattern string
        string patternSegment = pattern.substr(patternPos, patternNext - patternPos);
        string targetSegment = target.substr(targetPos, targetNext - targetPos);


       // Check if the current segment of the target matches the pattern segment If not, the IP doesn't match the pattern, return false
            if(!isInRange(patternSegment, stoi(targetSegment)))   return false;
        
        // Move to the next segment in the pattern, skip over the dot if not at the end
        patternPos = patternNext == pattern.size() ? patternNext : patternNext + 1;
        targetPos = targetNext == target.size() ? targetNext : targetNext + 1;
    }

   // Check if we've reached the end of both the pattern and target strings
    bool result = (patternPos == pattern.size() && targetPos == target.size());

   // Return true if both strings have been fully processed, else false
    return result;
}


// Function to check if a value is within a given range
bool isInRange(string range, int value) {
    // Find the position of the dash ('-')   
    int dashPos = range.find('-');
    // Extract the substring representing the start of the range (before the dash)
    int rangeStart = stoi(range.substr(0, dashPos));
    // Extract the substring representing the end of the range (after the dash)    
    int rangeEnd = stoi(range.substr(dashPos + 1));

    return (value >= rangeStart && value <= rangeEnd); // Check if the given value falls within the specified range
}                                                      // Return true if the value is greater than or equal to the range start
                                                      // and less than or equal to the range end, indicating it's within the range