import Foundation
import FirebaseAuth
import Combine
import FirebaseFirestore

class ProfileViewModel : ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var role = ""
    @Published var totalScans = 0
    @Published var halalScans = 0
    @Published var haramScans = 0
    @Published var isLoading = false
    
    var cancellables = Set<AnyCancellable>()
    
    func loadUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        email = Auth.auth().currentUser?.email ?? ""

        Firestore.firestore().collection("users").document(uid)
            .getDocument { [weak self] snapshot, _ in
                guard let data = snapshot?.data() else { return }
                DispatchQueue.main.async {
                    self?.name = data["name"] as? String ?? "User"
                    self?.role = data["role"] as? String ?? "user"
                }
            }

        Firestore.firestore().collection("scans").document(uid).collection("items")
            .getDocuments { [weak self] snapshot, _ in
                let total = snapshot?.documents.count ?? 0
                let halal = snapshot?.documents.filter {
                    $0.data()["isHalal"] as? Bool == true
                }.count ?? 0
                DispatchQueue.main.async {
                    self?.totalScans = total
                    self?.halalScans = halal
                    self?.haramScans = total - halal
                }
            }
    }

    func updateName(_ newName: String, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { completion(false); return }
        Firestore.firestore().collection("users").document(uid).updateData(["name": newName]) { [weak self] error in
            if error == nil {
                DispatchQueue.main.async {
                    self?.name = newName
                    completion(true)
                }
            } else {
                DispatchQueue.main.async { completion(false) }
            }
        }
    }

    func updatePassword(current: String, new: String, completion: @escaping (Result<Void, String>) -> Void) {
        guard let user = Auth.auth().currentUser, let email = user.email else {
            completion(.failure("User not found"))
            return
        }
        let credential = EmailAuthProvider.credential(withEmail: email, password: current)
        user.reauthenticate(with: credential) { _, error in
            if let error = error {
                let code = AuthErrorCode(rawValue: (error as NSError).code)
                switch code {
                case .wrongPassword, .invalidCredential:
                    completion(.failure("Current password is incorrect"))
                default:
                    completion(.failure("An error occurred"))
                }
                return
            }

            user.updatePassword(to: new) { error in
                if let error = error {
                    let code = AuthErrorCode(rawValue: (error as NSError).code)
                    switch code {
                    case .weakPassword:
                        completion(.failure("Password is too short (min. 6 characters)"))
                    default:
                        completion(.failure("Failed to update password"))
                    }
                } else {
                    completion(.success(()))
                }
            }
        }
    }
    
    
    
}
