# Simulador de Investimentos: Comparação de Rendimentos

Este projeto é um aplicativo mobile desenvolvido em Flutter para a disciplina de Programação para Dispositivos Móveis. O objetivo principal é simular e comparar o rendimento de dois investimentos distintos ao longo do tempo, utilizando cálculos de juros compostos e apresentando os resultados de forma visual e intuitiva.

## Demonstração
[Assistir ao vídeo de demonstração do aplicativo](https://drive.google.com/file/d/1581BuW9oDl0A17jQfyBYe4FyjWazQqlg/view?usp=drive_link)

## Tecnologias Utilizadas
* **Linguagem:** Dart
* **Framework:** Flutter

### Dependências
* [`fl_chart`](https://pub.dev/packages/fl_chart): Utilizada para renderizar o gráfico de linhas comparativo na tela de resultados, permitindo uma visualização clara da evolução dos rendimentos.

## Estrutura do Projeto
O código foi organizado seguindo os princípios de *Clean Code*, separando a interface gráfica (UI) das regras de negócio e dados:

* `lib/models/`: Contém as classes que estruturam os dados da aplicação (`InvestmentData` e `SimulationResult`).
* `lib/utils/`: Armazena a lógica de negócio e cálculos isolados (`InterestCalculator`), facilitando testes e manutenção.
* `lib/screens/`: Contém as telas interativas do aplicativo (`InputScreen` para os formulários e `ResultsScreen` para exibição de dados e gráficos).
* `lib/main.dart`: Ponto de entrada e configuração do tema da aplicação.

## Como Executar o Projeto

1. Certifique-se de ter o ambiente do [Flutter](https://flutter.dev/docs/get-started/install) devidamente configurado na sua máquina.
2. Clone este repositório para o seu ambiente local:
   ```bash
   git clone https://github.com/Ray-Campos/flutter-interest-calculator
   ```
3. Navegue até o diretório do projeto e instale as dependências necessárias:
   ```bash
   flutter pub get
   ```
4. Execute o aplicativo (certifique-se de ter um emulador aberto ou um dispositivo físico conectado):
   ```bash
   flutter run
   ```
