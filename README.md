## App para o desafio


*Especificações técnicas do app Arquitetura*: Foi utilizado a arquitetura MVVM-C ou Model-View-ViewModel com Coordinators, mesmo sendo um app simples com uma tela, essa arquitetura foi escolhida pensando que poderia ser acrescentado novas features, e quando fosse feito, seria de uma maneira mais fácil, pois o app está respeitando bastante princípios de SOLID, caso o app crescesse em fluxo e features, poderia colocar o VIP acoplando o MVVM nele facilmente, de qualquer forma decidi pelo caminho de ver a necessidade atual e implementar uma solução adequada com um espaço para mudança, do que de cara colocar uma arquitetura complexa como um VIPER ou mesmo o VIP para um app que é basicamente uma tela, ou seja não fui pelo lado do over-engineering, prezando pelos conceitos de YAGNI e ao mesmo tempo SOLID.

![Captura de Tela 2023-07-17 às 22 16 32](https://github.com/andrediasgustavo/desafioiOS/assets/13838573/2cb60c81-d0f3-4c2e-b612-5fae9f91f5b8)

---

*Linguagem*: Foi utilizado swift 5.

*Suporte de versão*: O app suporta a partir do iOS 13.

*Gerenciador de dependência*: Foi utilizado Swift Package Manager (SPM).

*Pods*: Foi utilizado apenas, Snapkit e Kingfisher, o restante foi feito de forma nativa, deixando o app mais leve e rápido para buildar.

*Sobre a UI*: Removi o storyboard e refiz tudo com view code, usando snapkit para as constraints, kingfisher para as imagens, fiz a view de erro usando swiftUI para mostrar esse conhecimento, fiz algumas mudanças na UI que podem ser vistas a abaixo.

1             |  2
:---------------------:|:---------------------:
<img src=https://github.com/andrediasgustavo/desafioiOS/assets/13838573/2d9a0655-0de0-4f0c-b8cf-a489b16622a3 width=400 /> |  <img src=https://github.com/andrediasgustavo/desafioiOS/assets/13838573/144d8cc5-02b9-4508-9ea1-be1446a7d8fe width=400 />
<img src=https://github.com/andrediasgustavo/desafioiOS/assets/13838573/893a61b8-0092-4840-9dbc-13044ebb1b21 width=400 /> |  <img src=https://github.com/andrediasgustavo/desafioiOS/assets/13838573/6a4bcd49-9605-4ffd-a580-97d70926a55b width=400 />

---

*Quanto a camada de network* mais especificamente em relação aos parâmetros de URL, como apikey, timestamp e hash, coloquei em um arquivo de xcconfig, como primeiro passo para melhor a segurança e não deixar expostos essas chaves importantes, claro que teria que ser tomado outras medidas, como deixar esse arquivo xcconfig em um local externo seguro, outra opção é ofuscação do plist, ou ainda o que seria a melhor solução possível, deixar essas chaves do lado do backend e buscar essas chaves toda vez que for necessário no uso do app pelo usuário.

![Captura de Tela 2023-07-17 às 22 30 31](https://github.com/andrediasgustavo/desafioiOS/assets/13838573/23dc525b-88b0-4514-990f-e842d9717143)

---

*Testes*: Implementei testes unitários, de integração e algo de UI, procurei fazer um pouco de cada, não fiz uma cobertura mais completa pela questão do tempo, mas acredito que cobre as principais áreas como viewcontroller, viewmodel, networking, deixei com uma cobertura de quase 80%, poderia colocar testes de snapshot também como uma melhora futura e aumentar um pouco mais a cobertura geral.

![Captura de Tela 2023-07-17 às 22 33 04](https://github.com/andrediasgustavo/desafioiOS/assets/13838573/73a0d0ed-c1f6-4ad7-9417-ffd06b6981cf)

---

*Outras melhorias*: Poderia ser implementado como melhorias futuras, fastlane, danger, swiftlint para melhorar a qualidade do código, algum serviço de automação para CI/CD como bitrise ou mesmo local com Jenkins, caso a estrutura exigisse ou a questão de orçamento também. A camada de networking poderia estar em um módulo à parte já que o core dela está bem genérico, poderia ser utilizado em outros casos, até de repente caso crescesse o app deixando tudo em um monorepo.















