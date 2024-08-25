//
//  UserInfoModelView.swift
//  Term Project
//
//  Created by Win Yu Maung on 25/08/2024.
//

import Foundation

var personIndex : Int!
var PasswordBoolean: Bool!
var UserInfo = PersonViewModel()

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
    
    func CheckPerson(Username: String, Passwords: String) -> Bool {
        if let index = persons.firstIndex(where: { $0.Username == Username }) {
            // Person exists, now check if the password matches
            if persons[index].Passwords == Passwords {
                personIndex = index
                PasswordBoolean = true
                return true
            } else {
                // Password is incorrect
                personIndex = index
                PasswordBoolean = false
                return true
            }
        } else {
            // Person does not exist
            return false
        }
    }
    
    func CheckUsername(Username: String) -> Bool {
        if persons.firstIndex(where: {$0.Username == Username}) != nil{
            return true
        } else {
            return false
        }
    }
    
    func CheckEmail(Username: String, Email : String) -> Bool {
        if let index = persons.firstIndex(where: { $0.Username == Username }) {
            if persons[index].Email == Email {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func ChangePassword(Username:String, Email:String, Password: String){
        if let index = persons.firstIndex(where: { $0.Username == Username && $0.Email == Email}) {
            persons[index] = Person(Username: Username, Email: Email, Passwords: Password)
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
    
    func addPerson(Username: String, Email: String, Passwords: String){
        // Check if a person with the same username already exists
        if !CheckUsername(Username: Username) {
            // If not, create a new person and add it to the array
            let newPerson = Person(Username: Username, Email: Email, Passwords: Passwords)
            persons.append(newPerson)
        }
//            return true
//        } else {
//            // Handle the case where the username is already taken
//            return false
//        }
    }
    
}
