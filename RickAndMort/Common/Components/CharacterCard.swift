import SwiftUI
import Kingfisher

struct CharacterCard: View {
    @State private var isAppeared = false
    let character: Character
    
    var body: some View {
        HStack(spacing: 15) {
            KFImage(URL(string: character.image))
                .placeholder { Color.gray.opacity(0.3) }
                .retry(maxCount: 3, interval: .seconds(1))
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .clipped()
            
            VStack(alignment: .leading, spacing: 5) {
                Text(character.name)
                    .font(.headline).foregroundColor(.white)
                
                HStack(spacing: 5) {
                    Circle()
                        .fill(character.status == "Alive" ? .green : (character.status == "Dead" ? .red : .gray))
                        .frame(width: 8, height: 8)
                    
                    Text("\(character.species) - \(character.status)")
                        .font(.subheadline).foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(15)
        .offset(y: isAppeared ? 0 : 20)
        .opacity(isAppeared ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                isAppeared = true
            }
        }
    }
}
