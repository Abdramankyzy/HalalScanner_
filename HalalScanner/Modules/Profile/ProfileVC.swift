import UIKit
import FirebaseFirestore
import FirebaseAuth
import Combine


class ProfileVC: UIViewController {
    
    let profileView = ProfileView()
    

    weak var coordinator: AppCoordinator?
    
    let viewModel = ProfileViewModel()
    var cancellables = Set<AnyCancellable>()

        
    override func loadView() {
        view = profileView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        title = "Profile"
        bindViewModel()
        viewModel.loadUserData()
        profileView.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        profileView.editNameButton.addTarget(self, action: #selector(editNameTapped), for: .touchUpInside)
        profileView.editPasswordButton.addTarget(self, action:  #selector(editPasswordTapped), for: .touchUpInside)
        profileView.ratingButton.addTarget(self, action: #selector(rateTapped), for: .touchUpInside)
        profileView.feedbackButton.addTarget(self, action: #selector(feedbackTapped), for: .touchUpInside)
        
    }
    
    func bindViewModel() {
        viewModel.$name
            .receive(on: DispatchQueue.main)
            .sink { [weak self] name in
                self?.profileView.nameLabel.text = name
            }
            .store(in: &cancellables)
        
        viewModel.$role
            .receive(on: DispatchQueue.main)
            .sink { [weak self] role in
                self?.profileView.roleBage.text = role
            }
            .store(in: &cancellables)
        
        viewModel.$totalScans
            .combineLatest(viewModel.$halalScans, viewModel.$haramScans)
            .dropFirst()                    
            .receive(on: DispatchQueue.main)
            .sink { [weak self] total, halal, haram in
                self?.profileView.setupStatus(total: total, halal: halal, haram: haram)
                self?.profileView.updateProgress(total: total, halal: halal)
            }
            .store(in: &cancellables)
 
    }
    
    @objc func logoutTapped() {
        coordinator?.logout()
    }
    
    @objc func editNameTapped() {
        let alert = UIAlertController(title: "Edit Name", message: nil, preferredStyle: .alert)
        alert.addTextField { [weak self] textField in
            textField.placeholder = "Enter your new name"
            textField.text = self?.viewModel.name
            textField.autocapitalizationType = .words
        }
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self = self, let newName = alert.textFields?.first?.text,!newName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
            
            self.viewModel.updateName(newName) { [weak self] success in
                guard let self else { return }
                if !success {
                    let errrorAlert = UIAlertController(title: "Error", message: "Could not save your name", preferredStyle: .alert)
                    errrorAlert.addAction(UIAlertAction(title: "Ок", style: .default))
                    self.present(errrorAlert, animated: true)
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: true)
    }
    @objc func editPasswordTapped() {
        let alert = UIAlertController(title: "Change Password", message: nil, preferredStyle: .alert)
        alert.addTextField { [weak self] textField in
            textField.placeholder = "Current password"
            textField.isSecureTextEntry = true
        }
        alert.addTextField { field in
            field.placeholder = "New password (min. 6 characters)"
            field.isSecureTextEntry = true
            }
        alert.addTextField { field in
            field.placeholder = "Confirm new password"
            field.isSecureTextEntry = true
        }
        let saveAction = UIAlertAction(title: "Change", style: .default) { [weak self] _ in
            guard let self = self,
                  let current = alert.textFields?[0].text, !current.isEmpty,
                  let newPass = alert.textFields?[1].text, !newPass.isEmpty,
                  let confirm = alert.textFields?[2].text else { return }
            
            guard newPass == confirm else {
                self.showError("New passwords do not match")
                return
            }
            
            guard newPass.count >= 6 else {
                self.showError("Password is too short (min. 6 characters)")
                return
            }
            
            self.viewModel.updatePassword(current: current, new: confirm) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success:
                    let ok = UIAlertController(title: "✅", message: "Password changed successfully", preferredStyle: .alert)
                    ok.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(ok, animated: true)
                case .failure(let message):
                    self.showError(message)
                }
            }
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(saveAction)
        present(alert, animated: true)
        
    }
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc func rateTapped() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("ratings").whereField("uid", isEqualTo: uid)
            .getDocuments { [weak self] snapshot, error in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if let docs = snapshot?.documents, !docs.isEmpty {
                        let existingStars = docs.first?.data()["stars"] as? Int ?? 0
                        let stringStars = String(repeating: "⭐", count: existingStars)
                        let alert = UIAlertController(title: "Already Rated", message: "Your rating: \(stringStars)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alert, animated: true)
                        return
                    }
                    
                    let alert = UIAlertController(title: "Rate the App", message: "Your rating means a lot to us!", preferredStyle: .alert)
                    
                    let stars = ["⭐", "⭐⭐", "⭐⭐⭐", "⭐⭐⭐⭐", "⭐⭐⭐⭐⭐"]
                    stars.enumerated().forEach { index, star in
                        alert.addAction(UIAlertAction(title: "\(star) - \(index + 1) star(s)", style: .default) { [weak self] _ in
                            self?.submitRating(index + 1)
                        })
                        
                    }
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                    self.present(alert, animated: true)
                }
            }
    
    }
    
    func submitRating(_ stars: Int) {
        guard let uid = Auth.auth().currentUser?.uid, let email = Auth.auth().currentUser?.email else { return }
        
        Firestore.firestore().collection("ratings").document(uid).setData([
            "uid": uid,
            "email": email,
            "stars": stars,
            "date": Date()
        ]){ [weak self] error in
            guard let self = self else { return }
            let title = error == nil ? "Thank you! 🙏" : "Error"
            let message = error == nil
            ? "You gave \(stars) star(s). Thank you for your feedback!"
            : "Could not save your rating"
            
            DispatchQueue.main.async {
                let ok = UIAlertController(title: title, message: message, preferredStyle: .alert)
                ok.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ok, animated: true)
            }
        }
        
        
        
    }
    
    @objc func feedbackTapped() {
        let alert = UIAlertController(
            title: "Contact / Help",
            message: "Write your question or suggestion",
            preferredStyle: .alert
        )

        alert.addTextField { field in
            field.placeholder = "Enter your message..."
        }

        let sendAction = UIAlertAction(title: "Send", style: .default) { [weak self] _ in
            guard let self = self,
                  let text = alert.textFields?.first?.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }

            self.submitFeedback(text)
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(sendAction)
        present(alert, animated: true)
    }

    private func submitFeedback(_ text: String) {
        guard let uid = Auth.auth().currentUser?.uid,
              let email = Auth.auth().currentUser?.email else { return }

        Firestore.firestore().collection("feedback").addDocument(data: [
            "uid": uid,
            "email": email,
            "message": text,
            "date": Date()
        ]) { [weak self] error in
            guard let self = self else { return }
            let title = error == nil ? "Thank you! 🙏" : "Error"
            let message = error == nil
                ? "Your message was sent"
                : "Could not send message"

            DispatchQueue.main.async {
                let ok = UIAlertController(title: title, message: message, preferredStyle: .alert)
                ok.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ok, animated: true)
            }
        }
    }
    
    
    
}
