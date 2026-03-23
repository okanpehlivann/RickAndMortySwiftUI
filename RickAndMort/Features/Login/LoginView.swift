import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    let darkNavy = Color(red: 10/255, green: 25/255, blue: 48/255)
    
    var body: some View {
        ZStack {
            darkNavy.ignoresSafeArea()
            
            VStack(spacing: 25) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundColor(.cyan)
                
                Text("Rick and Morty App")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    TextField("", text: $viewModel.username, prompt: Text("Kullanıcı Adı").foregroundColor(.white.opacity(0.6)))
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    SecureField("", text: $viewModel.password, prompt: Text("Şifre").foregroundColor(.white.opacity(0.6)))
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)
                
                Button(action: {
                    viewModel.performLogin()
                }) {
                    Text("Giriş Yap")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
        }
    }
}


#Preview {
    LoginView()
}
