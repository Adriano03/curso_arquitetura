//
abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs {
  // Variáveis e funções que serão usadas em qualquer viewModel;
}

abstract class BaseViewModelInputs {
  // Chamado durante a inicialização do modelo de exibição
  void start();
  // Chamado quando o viewModel fechar;
  void dispose();
}

abstract class BaseViewModelOutputs {}
