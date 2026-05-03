import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

enum AuthErrorField {
    case email
    case password
    case none
}

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var errorField: AuthErrorField = .none

    
    var cancellables = Set<AnyCancellable>()
    
    var isFormValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($email, $password)
            .map{ email, password in
                email.contains("@") && password.count >= 6
            }
            .eraseToAnyPublisher()
    }
    
    func login(completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.handleError(error)
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }

    func register(completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let error = error {
                    self?.handleError(error)
                    completion(.failure(error))
                } else {
                    self?.saveUserToFirestore(userId: result?.user.uid ?? "", email: self?.email ?? "", completion: completion)
                }
            }
        }
    }
    func saveUserToFirestore(userId: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        let role = email == "admin@halal.com" ? "admin" : "user"

        
        UserDefaults.standard.set(role, forKey: "userRole")

        db.collection("users").document(userId).setData([
            "email": email,
            "name": "User",
            "role": role
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func handleError(_ error: Error) {
        let nsError = error as NSError
        let code = AuthErrorCode(_bridgedNSError: nsError)?.code ?? AuthErrorCode(rawValue: nsError.code)
        
        switch code {
            case .wrongPassword, .invalidCredential:
                errorMessage = "Incorrect password"
                errorField = .password

            case .userNotFound:
                errorMessage = "This email is not registered"
                errorField = .email

            case .emailAlreadyInUse:
                errorMessage = "This email is already registered"
                errorField = .email

            case .networkError:
                errorMessage = "Please check your internet connection"
                errorField = .none

            case .tooManyRequests:
                errorMessage = "Too many attempts. Please try again later"
                errorField = .none

            default:
                errorMessage = "An error occurred. Please try again"
                errorField = .none
              }
        
    }
    
    
}
