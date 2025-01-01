#include <iostream>
#include <string>
#include <limits>
#include <cctype>

using namespace std;

// Function to validate if the string contains only alphabetic characters and spaces
bool isValidString(const string& input) {
    for (char c : input) {
        if (!isalpha(c) && c != ' ') {
            return false;
        }
    }
    return true;
}

// Function to get validated input (either string or int)
template <typename T>
T getValidatedInput(const string& prompt) {
    T input;
    bool valid = false;

    while (!valid) {
        cout << prompt;
        
        if constexpr (is_same<T, string>::value) {
            // Handle string input using getline
            getline(cin, input);
            if (isValidString(input)) {
                valid = true;
            } else {
                cout << "Invalid input. Please enter a valid string (letters and spaces only): " << endl;
            }
        } else if constexpr (is_same<T, int>::value) {
            // Handle integer input
            if (cin >> input) {
                valid = true;
            } else {
                cin.clear();  // Clear the error flag
                cin.ignore(numeric_limits<streamsize>::max(), '\n');  // Ignore invalid input
                cout << "Invalid input. Please enter a valid integer: " << endl;
            }
        }
    }
    return input;
}

int main() {
    // Get validated string input
    string name = getValidatedInput<string>("Enter your name: ");
    
    // Get validated integer input
    int age = getValidatedInput<int>("Enter your age: ");
    
    // Display the results
    cout << "Hello, " << name << "!" << endl;
    cout << "You are " << age << " years old." << endl;
    
    return 0;
}
