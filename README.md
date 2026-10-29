# DebtTracker

App iOS en SwiftUI para llevar el control de tus deudas pendientes.

## Funcionalidades
- Añade una deuda con título y total a pagar.
- Cada deuda se muestra con una barra de progreso (pagado / total), su título y el porcentaje en la parte inferior.
- Al pulsar sobre la barra puedes registrar una cantidad amortizada.
- Los datos se guardan en el dispositivo (UserDefaults).

## Requisitos
- Xcode 15 o superior
- iOS 17 o superior

## Cómo abrirlo
1. En Xcode: File → New → Project → iOS → App (Interface: SwiftUI, Language: Swift), con el nombre `DebtTracker`.
2. Elimina el `ContentView.swift` y el archivo `@main` que genera Xcode.
3. Arrastra la carpeta `DebtTracker/` de este repositorio al proyecto.

## Estructura
```
DebtTracker/
├── DebtTrackerApp.swift
├── Models/
│   ├── Debt.swift
│   └── DebtStore.swift
└── Views/
    ├── ContentView.swift
    ├── DebtRowView.swift
    ├── AddDebtView.swift
    └── AmortizeView.swift
```
