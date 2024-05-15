import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Time]
    
    @State private var isAddingItem = false
    @State private var gamertag = ""
    @State private var circuit = ""
    @State private var time = ""
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.gamertag).fontWeight(.semibold).lineLimit(1)
                            Text(item.time).font(.system(size: 14)).foregroundColor(.gray).lineLimit(1)
                        }
                        Spacer()
                        Text(item.circuit)
                    }
                }
                .onDelete(perform: deleteItems)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: {
                        isAddingItem = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .sheet(isPresented: $isAddingItem) {
            VStack {
                TextField("Gamertag", text: $gamertag)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Circuit", text: $circuit)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Time", text: $time)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: addItem) {
                    Text("Add Item")
                }
            }
            .padding()
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Time(gamertag: gamertag, circuit: circuit, time: time)
            modelContext.insert(newItem)
            isAddingItem = false
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    private var groupedItems: [(key: String, count: Int)] {
        let grouped = Dictionary(grouping: items, by: { $0.gamertag })
        return grouped.map { (key: $0.key, count: $0.value.count) }.sorted(by: { $0.count > $1.count })
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .modelContainer(for: Time.self, inMemory: true)
    }
}
#endif
