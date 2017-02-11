# Petrovich
Simple iOS/macOS library for russian names declension written in swift. Original idea and many features was taken from popular [Ruby repository](https://github.com/petrovich/petrovich-ruby).

#Installation
Petrovich is available through CocoaPods. Just add in your podfile:
``` ruby
	pod 'petrovich'
```
and import the module in .swift-file:
``` swift
	import petrovich
```

#Usage
``` swift
    let petrovich = Petrovich.shared
    let firstname = petrovich.firstname("Иван", gender: .male, declension: .dative) // Ивану
    let lastname = petrovich.lastname("Григорьев-Апполонов", gender: .male: declension: .instrumental) // Григорьевым-Апполоновым
```

### Maintainers
- [Daniyar Salakhutdinov](https://github.com/sdanny)

## License
Petrovich is available under the MIT license. See the LICENSE file for more info.