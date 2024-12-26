/*
MADE BY : 
Ali Hamza
Basim Mehdi
Soban Yam
Abdullah Mehmood
*/

#include"header.h"

int main()		{

    SDP Src_DST_Pro[No_Of_Packets];     // Array to store packets of Data type "SDP"
    Rules All_Rules[No_Of_Rules];       // Array to store rules of Data type "Rules"

    Import_Sample_File(Src_DST_Pro);    // Import sample file and store in the SDP struct
    Import_Rule_File(All_Rules);        // Import rule file and store in the Rules struct

    applyRule(Src_DST_Pro,All_Rules);   // Apply rules to the packets

    return 0;
}