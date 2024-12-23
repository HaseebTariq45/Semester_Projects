#include <iostream>
#include <string>
using namespace std;

// Structure for Patient (Node in Linked List)
struct Patient {
    int id;
    string name;
    int age;
    string disease;
    string phone;
    string assignedDoctor;
    int bedNumber;
    Patient* next;
};

// Structure for Doctor
struct Doctor {
    int id;
    string name;
    int age;
    string phone;
};

class Hospital {
private:
    Patient* head;
    Doctor doctors[4]; // Fixed number of doctors
    int totalBeds;
    bool beds[20]; // Track bed availability

public:
    Hospital() {
        head = nullptr;
        totalBeds = 20;
        for (int i = 0; i < 20; i++) beds[i] = false;
        for (int i = 0; i < 4; i++) {
            doctors[i] = {i + 1, "", 0, ""};
        }
    }

    // Linked List Operations
    void addPatient(int id, string name, int age, string disease, string phone, string doctor, int bed) {
        Patient* newPatient = new Patient{id, name, age, disease, phone, doctor, bed, head};
        head = newPatient;
    }

    void displayPatients() {
        Patient* temp = head;
        while (temp) {
            cout << "Patient Details:\n";
            cout << "ID: " << temp->id << "\nName: " << temp->name << "\nAge: " << temp->age;
            cout << "\nDisease: " << temp->disease << "\nPhone: " << temp->phone;
            cout << "\nDoctor: " << temp->assignedDoctor << "\nBed: " << temp->bedNumber << endl;
            temp = temp->next;
        }
    }

    Patient* searchPatient(int id) {
        Patient* temp = head;
        while (temp) {
            if (temp->id == id) return temp;
            temp = temp->next;
        }
        return nullptr;
    }

    // Doctor Operations
    void addDoctor(int id, string name, int age, string phone) {
        if (id < 1 || id > 4) {
            cout << "Invalid Doctor ID." << endl;
            return;
        }
        doctors[id - 1] = {id, name, age, phone};
    }

    void displayDoctors() {
        for (int i = 0; i < 4; i++) {
            if (doctors[i].name != "") {
                cout << "ID: " << doctors[i].id << ", Name: " << doctors[i].name;
                cout << ", Age: " << doctors[i].age << ", Phone: " << doctors[i].phone << endl;
            }
        }
    }

    // Bed Assignment
    int assignBed() {
        for (int i = 0; i < totalBeds; i++) {
            if (!beds[i]) {
                beds[i] = true;
                return i + 1;
            }
        }
        return -1; // No beds available
    }

    void releaseBed(int bedNumber) {
        if (bedNumber > 0 && bedNumber <= totalBeds) {
            beds[bedNumber - 1] = false;
        }
    }

    // Owner Menu
    void ownerMenu() {
        int choice;
        do {
            cout << "\nOwner Menu:\n";
            cout << "1. Add Doctor\n2. Display Doctors\n3. Display All Patients\n4. Exit\n";
            cin >> choice;
            switch (choice) {
                case 1: {
                    int id, age;
                    string name, phone;
                    cout << "Enter Doctor ID (1-4): ";
                    cin >> id;
                    cout << "Enter Name: ";
                    cin >> name;
                    cout << "Enter Age: ";
                    cin >> age;
                    cout << "Enter Phone: ";
                    cin >> phone;
                    addDoctor(id, name, age, phone);
                    break;
                }
                case 2:
                    displayDoctors();
                    break;
                case 3:
                    displayPatients();
                    break;
                case 4:
                    return;
                default:
                    cout << "Invalid choice!" << endl;
            }
        } while (choice != 4);
    }

    // Doctor Menu
    void doctorMenu() {
        int choice;
        do {
            cout << "\nDoctor Menu:\n";
            cout << "1. View Patients\n2. Exit\n";
            cin >> choice;
            switch (choice) {
                case 1:
                    displayPatients();
                    break;
                case 2:
                    return;
                default:
                    cout << "Invalid choice!" << endl;
            }
        } while (choice != 2);
    }

    // Receptionist Menu
    void receptionistMenu() {
        int choice;
        do {
            cout << "\nReceptionist Menu:\n";
            cout << "1. Add Patient\n2. Exit\n";
            cin >> choice;
            switch (choice) {
                case 1: {
                    int id, age;
                    string name, disease, phone, doctor;
                    cout << "Enter Patient ID: ";
                    cin >> id;
                    cout << "Enter Name: ";
                    cin >> name;
                    cout << "Enter Age: ";
                    cin >> age;
                    cout << "Enter Disease: ";
                    cin >> disease;
                    cout << "Enter Phone: ";
                    cin >> phone;
                    cout << "Assign Doctor (Enter Doctor's Name): ";
                    cin >> doctor;
                    int bed = assignBed();
                    if (bed == -1) {
                        cout << "No beds available!" << endl;
                    } else {
                        addPatient(id, name, age, disease, phone, doctor, bed);
                        cout << "Patient added with Bed Number: " << bed << endl;
                    }
                    break;
                }
                case 2:
                    return;
                default:
                    cout << "Invalid choice!" << endl;
            }
        } while (choice != 2);
    }
};

int main() {
    Hospital hospital;
    int userType;
    bool exit = false;

    while (!exit) {
        cout << "\n--- Hospital Management System ---\n";
        cout << "1. Owner\n2. Doctor\n3. Receptionist\n4. Exit\n";
        cin >> userType;
        switch (userType) {
            case 1:
                hospital.ownerMenu();
                break;
            case 2:
                hospital.doctorMenu();
                break;
            case 3:
                hospital.receptionistMenu();
                break;
            case 4:
                cout << "Exiting system. Goodbye!" << endl;
                exit = true;
                break;
            default:
                cout << "Invalid choice! Try again.\n";
        }
    }
    return 0;
}
