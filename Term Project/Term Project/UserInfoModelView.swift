//
//  UserInfoModelView.swift
//  Term Project
//
//  Created by Win Yu Maung on 25/08/2024.
//

import Foundation

var personIndex : Int!

class PersonViewModel {
    private let defaults = UserDefaults.standard
    private let usersKey = "users" // Key to store the list of users

    // An array to hold multiple Person objects
    var persons: [Person] = [] {
        didSet {
            // Save the array to UserDefaults whenever it is updated
            savePersonsToDefaults()
        }
    }

    init() {
        // Load the users from UserDefaults when the ViewModel is initialized
        loadPersonsFromDefaults()
    }

    private func savePersonsToDefaults() {
        if let encodedPersons = try? JSONEncoder().encode(persons) {
            defaults.set(encodedPersons, forKey: usersKey)
        }
    }

    private func loadPersonsFromDefaults() {
        if let savedPersonsData = defaults.data(forKey: usersKey),
           let savedPersons = try? JSONDecoder().decode([Person].self, from: savedPersonsData) {
            self.persons = savedPersons
        }
    }

    // Method to add a new person or update an existing one
    func CheckPerson(Username: String, Passwords: String) -> Bool {
        if let index = persons.firstIndex(where: { $0.Username == Username && $0.Passwords == Passwords }) {
            // Person already exists, update the details
//            persons[index] = Person(Username: Username, Email: persons[index].Email, Passwords: persons[index].Passwords)
            personIndex = index
            return true
        } else {
            // Person does not exist, add a new one
            return false
        }
    }
    
    func updatePerson(at index: Int, with Username: String, Email: String, Passwords: String) {
        guard index < persons.count else { return }
        persons[index] = Person(Username: Username, Email: Email, Passwords: Passwords)
    }
    
    func updateUsername(at index: Int, with Username : String){
        guard index < persons.count else { return }
        persons[index] = Person(Username: Username, Email: persons[index].Email, Passwords: persons[index].Passwords)
    }
    
    func updateEmail(at index: Int, with Email : String){
        guard index < persons.count else { return }
        persons[index] = Person(Username: persons[index].Username, Email: Email, Passwords: persons[index].Passwords)
    }
    
    func updatePasswords(at index: Int, with Passwords : String){
        guard index < persons.count else { return }
        persons[index] = Person(Username: persons[index].Username, Email: persons[index].Email, Passwords: Passwords)
    }
    
    func removePerson(at index: Int) {
        guard index < persons.count else { return }
        persons.remove(at: index)
    }
}

