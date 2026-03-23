import SwiftUI

struct FilterSheet<Content: View>: View {
    @Environment(\.dismiss) private var dismiss
    
    let title: String
    let onApply: () -> Void
    let onClear: () -> Void
    @ViewBuilder let content: Content
    
    private let darkNavy = Color(red: 10/255, green: 25/255, blue: 48/255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                darkNavy.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 25) {
                        
                        content
                        
                        HStack(spacing: 15) {
                            Button("Temizle", role: .destructive) {
                                onClear()
                                dismiss()
                            }
                            .buttonStyle(.bordered)
                            .cornerRadius(10)
                            
                            Spacer()
                            
                            Button("Uygula") {
                                onApply()
                                dismiss()
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.cyan)
                            .cornerRadius(10)
                        }
                        .padding(.top, 20)
                    }
                    .padding()
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Kapat") { dismiss() }.foregroundColor(.white)
                }
            }
        }
    }
}

struct FilterSectionView<Content: View>: View {
    let title: String
    @ViewBuilder let content: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.cyan)
            content()
        }
    }
}



struct FilterOptionsGrid<T: RawRepresentable & CaseIterable & Identifiable & Hashable>: View where T.RawValue == String {
    let options: T.AllCases
    @Binding var selectedOption: T?
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
            
            ForEach(Array(options)) { option in
                Button(action: {
                    if selectedOption == option {
                        selectedOption = nil
                    } else {
                        selectedOption = option
                    }
                }) {
                    
                    Text(option.rawValue.capitalized)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .background(selectedOption == option ? Color.cyan : Color.white.opacity(0.1))
                        .foregroundColor(selectedOption == option ? .black : .white)
                        .cornerRadius(8)
                }
            }
        }
    }
}
