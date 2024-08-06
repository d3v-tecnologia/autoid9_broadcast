# autoid9_broadcast

Exemplo para utilizar broadcast junto com o coletor compex autoid9. É necessário selecionar broadcast no scanner send mode.

## Getting Started

Responsável por gerenciar o broadcast:
flutter_broadcasts: ^0.4.0

Necessário API LVL >= 24
android/app/build.gradle
```
  defaultConfig {
        applicationId = "com.example.autoid9_broadcast"
        minSdk = 24 //essa linha aqui
  }
```