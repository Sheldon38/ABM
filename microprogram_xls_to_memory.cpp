//zeno_converter.cpp
#include <bits/stdc++.h>

using namespace std;

// helper function to convert bin to num
unsigned long binaryToDecimal(string);

int main(int argc, char const *argv[])
{
    // data
    vector<string> addressArray({"XXXX000", "XXXX001", "0001010", "0001011", "0010010", "0010011", "0010100", "1110010", "1111010"});
    vector<string> dataArray({"0011101000101110", "0100111100110110", "0101101000101110", "1100111000111100", "0101101000101110", "0100111000111010", "1010111000111100", "1000111000011110", "1001111000011110"});

    // calculate maximum num bits used for address
    size_t maxAddressBits = 0;
    for (int i = 0; i < addressArray.size(); i++)
    {
        maxAddressBits = max(maxAddressBits, addressArray[i].size());
    }
    // max address val is 2^bits
    size_t addressRange = 1;
    while (maxAddressBits--)
    {
        addressRange <<= 1;
    }

    // default stuff for algo
    const string defaultValue = "0110111000111110";
    const int instStartBit = 3;
    vector<string> finalMemory(addressRange, defaultValue);

    for (int i = 0; i < addressArray.size(); i++)
    {
        // get instruction
        string inst(addressArray[i]);

        if (inst.find('X') != string::npos)
        {
            vector<int> dcLoc;
            int totalCases = 0, dc = 0;
            for (int j = 0; j < inst.size(); j++)
            {
                if (inst[j] == 'X')
                {
                    dc++;
                    dcLoc.push_back(j);
                }
            }

            for (int j = dcLoc.size() - 1; j >= 0; j--)
            {
                inst[dcLoc[j]] = '0';
            }
            finalMemory[binaryToDecimal(inst)] = dataArray[i];

            totalCases = 1;
            while (dc--)
            {
                totalCases <<= 1;
            }
            totalCases--;

            while (totalCases--)
            {
                int carry = 0;
                int j = dcLoc.size() - 1;

                inst[dcLoc[j]] = inst[dcLoc[j]] + carry + 1;
                if (inst[dcLoc[j]] == '2')
                {
                    carry = 1;
                    inst[dcLoc[j--]] = '0';
                }

                while (carry && j >= 0)
                {

                    inst[dcLoc[j]] = inst[dcLoc[j]] + carry;
                    if (inst[dcLoc[j]] == '2')
                    {
                        carry = 1;
                        inst[dcLoc[j--]] = '0';
                    }
                    else
                    {
                        carry = 0;
                    }
                }
                finalMemory[binaryToDecimal(inst)] = dataArray[i];
            }
        }
        else
        {
            finalMemory[binaryToDecimal(inst)] = dataArray[i];
        }
    }

    for (auto &&i : finalMemory)
    {
        cout << i << "\n";
    }
    cout << "\n";

    return 0;
}

unsigned long binaryToDecimal(string binaryString)
{
    unsigned long value = 0;
    unsigned long pow2 = 1;

    for (int i = binaryString.size() - 1; i >= 0; i--)
    {
        value += (binaryString[i] - 48) * pow2;
        pow2 <<= 1;
    }

    return value;
}
