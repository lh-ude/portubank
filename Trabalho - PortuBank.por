
programa
{	
	inclua biblioteca Util
	
	inteiro qntClientes=0, contas[100], cliente=0
	cadeia loginCliente[100], senhacliente[100]
	real saldo[100]

	funcao inicio(){
		menu()
	}

	funcao menu() {
		inteiro op = -1
		enquanto(op!=0) {
			escreva("\n\n\t\t****************************************************************")
			escreva("\n\t\t\tBem-vindo ao PortuBank, seu banco digital.\n\t\t\tSomos ", qntClientes," portubankers! Venha fazer parte.")
			escreva("\n\t\t****************************************************************")
			escreva("\n\n\nEscolha uma opção: ")
			escreva("\n\n1 - Cadastrar cliente")
			escreva("\n2 - Consultar saldo")
			escreva("\n3 - Realizar saque")
			escreva("\n4 - Realizar Depósito")
			escreva("\n5 - Listar clientes")
			escreva("\n0 - Sair\n")
			leia(op)
			limpa()
	
			escolha (op){
				caso 1:
					cadastro_cliente()
				pare
				caso 2:
					consulta_saldo()
				pare
				caso 3:
					realizar_saque()
				pare
				caso 4:
					realizar_deposito()
				pare
				caso 5:
					listar_clientes()
				pare
				caso 0:
					escreva("\nSaindo, obrigado por usar o PortuBank\n")
				pare
				caso contrario:
					escreva("\nOpção inválida, tente novamente!")
			}
		}
	}

	funcao cadastro_cliente() {
		cadeia loginClienteCadastro = "", senhaClienteCadastro = ""
		real saldoCadastro = -1.0
		caracter choice
		inteiro numeroContaCadastro = -1, numeroRandomico, existeConta
	
		enquanto (loginClienteCadastro == ""){
			escreva ("\nInsira o seu nome:\n")
			leia (loginClienteCadastro)			
		}
		enquanto (senhaClienteCadastro == ""){
			escreva ("Insira a senha desejada:\n")
			leia (senhaClienteCadastro)
		}
		enquanto (saldoCadastro < 0){
			escreva ("Informe o saldo inicial da conta:\nR$")
			leia (saldoCadastro)
		}
		escreva ("\n\t\tCliente: ", loginClienteCadastro, "\n\t\tSenha: ", senhaClienteCadastro, "\n\t\tSaldo inicial: R$", saldoCadastro)
		escreva ("\n\nOs dados estão corretos? ( s- Sim / n - Não)\n")
		leia (choice)
		se (choice == 's') {
			enquanto (numeroContaCadastro == -1) {
				numeroRandomico = Util.sorteia(1,101)
				existeConta = pesquisa_conta(numeroRandomico)
				se(existeConta == -1) {
					numeroContaCadastro = numeroRandomico
				}
			}
		
			escreva ("\nCliente cadastrado! O número da sua conta é o ", numeroContaCadastro, "\n")
			
			contas[qntClientes] = numeroContaCadastro
			loginCliente[qntClientes] = loginClienteCadastro
			senhacliente[qntClientes] = senhaClienteCadastro
			saldo[qntClientes] = saldoCadastro

			qntClientes += 1
		}
		senao {
			escreva ("\n OK, tente novamente.\n")
		}

		continuar()
	}
	funcao consulta_saldo() {

		inteiro numContaPesquisar, numContaEncontrada
		numContaPesquisar = solicitar_conta()
		escreva ("\n\t*** Consulta de saldo ***\t\n")
		numContaEncontrada = pesquisa_conta(numContaPesquisar)
		se(numContaEncontrada != -1){
			escreva ("\nO saldo da conta é R$ ", saldo[numContaEncontrada],".\n")
		}
		senao {
			escreva ("\n Conta não encontrada, tente novamente.\n")
		}
		continuar()
	}
	funcao realizar_saque() {
		inteiro numContaPesquisar, numContaEncontrada
		real saque

		escreva ("\n\t*** Saque de valores ***\t\n")
		numContaPesquisar = solicitar_conta()
		numContaEncontrada = pesquisa_conta(numContaPesquisar)
		se(numContaEncontrada != -1){
			escreva ("\n Insira o valor que deseja sacar: ")
			leia (saque)
			se (saldo[numContaEncontrada] > saque) {
				saldo[numContaEncontrada] = saldo[numContaEncontrada] - saque
				escreva ("\n Saque realizado com sucesso! Saldo remanescente: R$", saldo[numContaEncontrada], "\n")
			} senao {
				escreva("\n Saldo insuficiente.\n")
			}
		}
		senao {
			escreva ("\n Conta não encontrada, tente novamente.\n")
		}
		continuar()
	}
	funcao realizar_deposito() {
		inteiro numContaPesquisar, numContaEncontrada
		real deposito

		escreva ("\n\t*** Depósito de valores ***\t\n")
		numContaPesquisar = solicitar_conta()
		numContaEncontrada = pesquisa_conta(numContaPesquisar)
		se(numContaEncontrada != -1){
			escreva ("\n Insira o valor que deseja depositar: ")
			leia (deposito)
			se (deposito > 0) {
				saldo[numContaEncontrada] = saldo[numContaEncontrada] + deposito
				escreva ("\n Depósito realizado com sucesso! Saldo atual: R$", saldo[numContaEncontrada], "\n")
			} senao {
				escreva("\n Informe um valor válido, tente novamente.\n")
			}
		}
		senao {
			escreva ("\n Conta não encontrada, tente novamente.\n")
		}
		continuar()
		}
	funcao listar_clientes() {
		inteiro contador
		escreva("\n\t\t\t\tNUM Conta\t - \tNome\n")
		escreva("\t\t****************************************************************\n")
		para(contador = 0; contador < qntClientes; contador++) {
			escreva("\t\t\t\t", contas[contador], "\t - \t", loginCliente[contador], "\n")
		}
		continuar()
	}

	funcao inteiro solicitar_conta() {
		inteiro numContaPesquisar = 0
		enquanto (numContaPesquisar <= 0) {
			escreva ("\nInforme o número da conta desejada:\n")
			leia(numContaPesquisar)
		}
		retorne numContaPesquisar
	}
	funcao inteiro pesquisa_conta(inteiro numeroContaProcurado) {
		inteiro posicaoConta = -1, contador
		para(contador = 0; contador <= qntClientes; contador++) {
			se(contas[contador] == numeroContaProcurado) {
				posicaoConta = contador
				pare
			}
		}
		retorne posicaoConta
	}
	funcao continuar(){
		cadeia op
		escreva("\nPressione qualquer tecla para continuar...\n")
		leia(op)
		limpa()
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 398; 
 * @DOBRAMENTO-CODIGO = [29];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */