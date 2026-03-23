import SwiftUI

struct EmptyStateView: View {
    let message: String
    let onClearFilters: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass.circle")
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.cyan.opacity(0.5))
            
            Text("Sonuç Bulunamadı.")
                .font(.title3.bold())
                .foregroundColor(.white)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button(action: onClearFilters) {
                Text("Filtreleri Temizle")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.cyan)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 100)
    }
}

#Preview {
    EmptyStateView(message: "Boş liste", onClearFilters: { })
}
