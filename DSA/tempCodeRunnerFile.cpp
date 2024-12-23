#include <iostream>
using namespace std;

// Class for Patient
class Patient {
public:
    int id;
    string name;
    int age;
    string disease;
    string phone;
    string assignedDoctor;
    int bedNumber;
    Patient* next;

    // Constructor
    Patient(int id, string name, int age, string disease, string phone, string doctor, int bed) {
        this->id = id;
        this->name = name;
        this->age = age;
        this->disease = disease;
        this->phone = phone;
        this->assignedDoctor = doctor;
        this->bedNumber = bed;
        this->next = nullptr;
    }
};

// Class for Doctor
class Doctor {
public:
    int id;
    string name;
    int age;
    string phone;

    // Constructor
    Doctor(int id = 0, string name = "", int age = 0, string phone = "") {
        this->id = id;
        this->name = name;
        this->age = age;
        this->phone = phone;
    }
};

// Class for Hospital
class Hospital {
private:
    Patient* head;
    Doctor doctors[4]; // Fixed number of doctors (for simplicity)
    bool patientDoctorGraph[20][4]; // Adjacency matrix: 20 patients and 4 doctors

    int totalBeds;
    bool beds[20]; // Track bed availability

public:
    Hospital() {
        head = nullptr;
        totalBeds = 20;
        for (int i = 0; i < 20; i++) {
            beds[i] = false;
            for (int j = 0; j < 4; j++) {
                patientDoctorGraph[i][j] = false; // No patient assigned to any doctor initially
            }
        }

        for (int i = 0; i < 4; i++) {
            doctors[i] = Doctor(i + 1, "", 0, "");
        }
    }

    // Linked List Operations for Patients
    void addPatient(int id, string name, int age, string disease, string phone, string doctor, int bed) {
        Patient* newPatient = new Patient(id, name, age, disease, phone, doctor, bed);
        newPatient->next = head;
        head = newPatient;
    }

    void displayPatients() {
        if (!head) {
            cout << "No patients available.\n";
            return;
        }
        Patient* temp = head;
        while (temp) {
            cout << "\nPatient Details\n";
            cout << "ID: " << temp->id << "\nName: " << temp->name << "\nAge: " << temp->age;
            cout << "\nDisease: " << temp->disease << "\nPhone: " << temp->phone;
            cout << "\nDoctor: " << temp->assignedDoctor << "\nBed: " << temp->bedNumber << "\n";
            temp = temp->next;
        }
    }

    // Doctor Operations
    void addDoctor(int id, string name, int age, string phone) {
        if (id < 1 || id > 4) {
            cout << "Invalid Doctor ID.\n";
            return;
        }
        doctors[id - 1] = Doctor(id, name, age, phone);
    }

    void displayDoctors() {
        for (int i = 0; i < 4; i++) {
            if (doctors[i].name != "") {
                cout << "ID: " << doctors[i].id << ", Name: " << doctors[i].name;
                cout << ", Age: " << doctors[i].age << ", Phone: " << doctors[i].phone << endl;
            }
        }
    }

    // Adjacency Matrix Operations: Assign a doctor to a patient
    void assignDoctorToPatient(int patientId, int doctorId) {
        if (patientId < 1 || patientId > 20 || doctorId < 1 || doctorId > 4) {
            cout << "Invalid IDs.\n";
            return;
        }
        patientDoctorGraph[patientId - 1][doctorId - 1] = true; // Mark the relationship
        cout << "Patient " << patientId << " is assigned to Doctor " << doctorId << ".\n";
    }

    void displayPatientDoctorGraph() {
        cout << "\nPatient-Doctor Relationships:\n";
        for (int i = 0; i < 20; i++) {
            for (int j = 0; j < 4; j++) {
                if (patientDoctorGraph[i][j]) {
                    cout << "Patient " << i + 1 << " is assigned to Doctor " << j + 1 << "\n";
                }
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

    void displayBedStatus() {
        cout << "\nBed Status:\n";
        for (int i = 0; i < totalBeds; i++) {
            cout << "Bed " << i + 1 << ": " << (beds[i] ? "Occupied" : "Available") << "\n";
        }
    }

    // Menu Functions for Owner, Doctor, Receptionist
    void ownerMenu() {
        int choice;
        do {
            cout << "\nOwner Menu:\n";
            cout << "1. Add Doctor\n2. Display Doctors\n3. Display All Patients\n4. Display Bed Status\n5. Exit\n";
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
                    displayBedStatus();
                    break;
                case 5:
                    return;
                default:
                    cout << "Invalid choice!\n";
            }
        } while (choice != 5);
    }

    void receptionistMenu() {
        int choice;
        do {
            cout << "\nReceptionist Menu:\n";
            cout << "1. Add Patient\n2. Assign Doctor to Patient\n3. View Patient-Doctor Relationships\n4. Exit\n";
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
                    cout << "Assign Doctor (Enter Doctor's ID): ";
                    cin >> doctor;
                    int bed = assignBed();
                    if (bed == -1) {
                        cout << "No beds available.\n";
                    } else {
                        addPatient(id, name, age, disease, phone, doctor, bed);
                        cout << "Patient added with Bed Number: " << bed << "\n";
                    }
                    break;
                }
                case 2: {
                    int patientId, doctorId;
                    cout << "Enter Patient ID: ";
                    cin >> patientId;
                    cout << "Enter Doctor ID: ";
                    cin >> doctorId;
                    assignDoctorToPatient(patientId, doctorId);
                    break;
                }
                case 3:
                    displayPatientDoctorGraph();
                    break;
                case 4:
                    return;
                default:
                    cout << "Invalid choice!\n";
            }
        } while (choice != 4);
    }
};

int main() {
    Hospital hospital;
    int userType;
    cout << "Enter your role (1-Owner, 2-Doctor, 3-Receptionist): ";
    cin >> userType;

    switch (userType) {
        case 1:
            hospital.ownerMenu();
            break;
        case 2:
            hospital.receptionistMenu();
            break;
        default:
            cout << "Invalid role.\n";
    }
    return 0;
}
