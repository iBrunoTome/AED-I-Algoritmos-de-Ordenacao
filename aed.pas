//===== Nome: Bruno Tome     | Matheus Calixto     =====//
//===== Matricula: 0011254   | 0011233             =====//
//===== ibrunotome@gmail.com | calixtinn@gmail.com =====//

program AED1;
uses sysutils, crt; // para usar as funcoes DateTimeToTimeStamp, now e TimeStampToMSecs

type dynamic = array of longword;

var
	tam : longword;
	vetor : dynamic;

{
	Funcao Gerar: Gera um vetor Randomico para que seja testado em todos os algoritmos de ordenacao. A cada vez que e chamada, a funcao retorna
	um vetor de elementos diferentes. No entando, um mesmo vetor randomico e testado primeiramente em todos os 11 algoritmos, e a partir da
	segunda chamada, e que os elementos sao trocados.
}

function gerar(var qnt : longword):dynamic;
var
	i,temp:longword;
begin
    temp := qnt;
    setlength(gerar,temp);
    for i := 1 to temp do
    begin
        gerar[i] := random(temp) + 1;
    end;
end;

// Procedimento para particionar o vetor ao meio, do algoritmo QuickSort.

procedure Particao(var vet : array of longword; Esq, Dir : longword; var i, j : longword; var cont_ite : double);
var x, aux: longword;

begin
	i := Esq;
	j := Dir;
	x := vet[((j + i) div 2 )]; // Obtem o Pivo

	repeat
		while vet[i] < x do inc(i); cont_ite := cont_ite + 1;
		while x < vet[j] do dec(j); cont_ite := cont_ite + 1;
		if i <= j then
		begin
			aux := vet[i];
			vet[i] := vet[j];
			vet[j] := aux;
			cont_ite := cont_ite + 3;
			inc(i);
			dec(j);
		end;
	until i > j;
end;
// Procedimento para a ordenacao e re-arranjo dos elementos do vetor. algoritmo QuickSort (pivo ao meio).

procedure Ordena( var vet: array of longword; Esq, Dir : longword; var cont_ite : double);
var i, j : longword;

begin
	Particao(vet, Esq, Dir, i, j,cont_ite);
	if Esq < j then Ordena(vet, Esq, j, cont_ite);
	if i < Dir then Ordena(vet, i, Dir, cont_ite);
end;

// Procedimento para particionar o vetor, colocando como pivot o primeiro elemento do vetor.

procedure Particao2(var vet : array of longword; Esq, Dir : longword; var i, j : longword; var cont_ite : double);
var x,aux: longword;

begin
	i := Esq;
	j := Dir;
	x := vet[i]; // Obtem o Pivo como primeiro elemento

	repeat
		while vet[i] < x do inc(i); cont_ite := cont_ite + 1;
		while x < vet[j] do dec(j); cont_ite := cont_ite + 1;
		if   i <= j then
		begin
			aux:=vet[i];
			vet[i]:=vet[j];
			vet[j]:=aux;
			cont_ite:=cont_ite+3;
			i := i + 1;
			j := j - 1;
		end;
	until i > j;
end;

// Procedimento para a ordenacao e re-arranjo dos elementos do vetor. Algoritmo QuickSort (pivo no primeiro elemento).

procedure Ordena2( var vet: array of longword; Esq, Dir : longword;var cont_ite:double);
var i, j : longword;

begin
	Particao2(vet, Esq, Dir, i, j,cont_ite);
	if Esq < j then Ordena2(vet,Esq, j,cont_ite);
	if i < Dir then Ordena2(vet,i, Dir,cont_ite);
end;

// Procedimento para particionar o vetor, colocando como pivot o ultimo elemento do vetor.

procedure Particao3(var vet : array of longword; Esq, Dir: longword; var i, j: longword;var cont_ite:double);
var x,aux: longword;

begin
	i := Esq;
	j := Dir;
	x := vet[j]; // Obtem o Pivo como ultimo elemento

	repeat
		while vet[i] < x do inc(i); cont_ite := cont_ite + 1;
		while x < vet[j] do dec(j); cont_ite := cont_ite + 1;
		if   i <= j then
		begin
			aux := vet[i];
			vet[i] := vet[j];
			vet[j] := aux;
			cont_ite := cont_ite + 3;
			inc(i);
			dec(j);
		end;
	until i > j;
end;

// Procedimento para a ordenacao e re-arranjo dos elementos do vetor. Algoritmo QuickSort (pivo no ultimo elemento).

procedure Ordena3( var vet: array of longword; Esq, Dir : longword; var cont_ite:double);
var i, j : longword;

begin
	Particao3(vet, Esq, Dir, i, j, cont_ite);
	if Esq < j then Ordena3(vet, Esq, j, cont_ite);
	if i < Dir then Ordena3(vet, i, Dir, cont_ite);
end;

// Procedimento para particionar o vetor, onde escolhe-se o pivot a partir de um elemento de uma posicao randomica.

procedure Particao4(var vet:array of longword; Esq, Dir : longword; var i : longword; cont_ite : double);
var x, indice, aux, j : longword;
begin
    indice := Esq + random(Dir - Esq) + 1;
    x := vet[indice];
    aux := vet[indice];
    vet[indice] := vet[Dir];
    vet[Dir] := aux; // Pivo Randômico
    indice := Dir;
    i := Esq - 1;
    j := Esq ;
    while (j <= Dir - 1) do
  	begin
	  	if(vet[j] <= x)then
	    begin
	        i := i+1;
	        aux := vet[i];
	        vet[i] := vet[j];
	        vet[j] := aux;
			cont_ite := cont_ite + 2;
	    end;
	    j := j + 1;
  	end;
    aux := vet[i + 1];
    vet[i+1] := vet[indice];
    vet[indice] := aux;
    i := i + 1;
	cont_ite := cont_ite + 2;
end;

// Procedimento para a ordenacao e re-arranjo dos elementos do vetor. Algoritmo QuickSort (pivot randomico).

procedure Ordena4(var vet:array of longword; Esq, Dir : longword; var cont_ite : double);
var i:longword;
begin
    if (Esq < Dir) then
    begin
        cont_ite := cont_ite + 1;
        particao4(vet, Esq, Dir, i, cont_ite);
        Ordena4(vet, Esq, i - 1, cont_ite);
        Ordena4(vet, i + 1, Dir, cont_ite);
    end;
end;

{
	Procedimento para particionar o vetor, onde escolhe-se o pivot a partir da mediana dos 3. 
	Esse processo resume-se em: Escolher o primeiro, ultimo, e o elemento central do vetor, 
	ordena-los, e escolher como pivot o elemento central desse novo vetor ordenado.
}

procedure Particao5(var vet : array of longword; Esq, Dir: longword; var i, j: longword; var cont_ite:double);
var x, aux, l, k: longword;
    vet2 : array of longword;

begin
	i := Esq;
	j := Dir;
	setlength(vet2, j);
	vet2[2] := vet[((j+i) div 2)];
	vet2[1] := vet[i];
	vet2[3] := vet[j]; // Pivo Mediana

	for l := 1 to 2 do
	begin
    	for k := (l + 1) to 3 do
    	begin
        	if (vet2[k] < vet2[l]) then
            begin
            	aux := vet2[l];
                vet2[l] := vet2[k];
                vet2[k] := aux;
                cont_ite := cont_ite + 1;
            end;
       	end;
    end;

	x:=vet2[2];

	repeat
		while vet[i] < x do inc(i); cont_ite := cont_ite + 1;
		while x < vet[j] do dec(j); cont_ite := cont_ite + 1;
		if   i <= j then
		begin
			aux := vet[i];
			vet[i] := vet[j];
			vet[j] := aux;
			inc(i);
			dec(j);
			cont_ite := cont_ite + 3;
		end;
	until i > j;

end;

//Procedimento para a ordenacao e re-arranjo dos elementos do vetor. Algoritmo QuickSort (pivot Mediana dos 3).

procedure Ordena5(var vet: array of longword; Esq, Dir : longword; var cont_ite:double);
var i, j : longword;

begin
	Particao5(vet, Esq, Dir, i, j, cont_ite);
	if Esq < j then Ordena5(vet, Esq, j, cont_ite);
	if i < Dir then Ordena5(vet, i, Dir, cont_ite);
end;

// Inicio da Função do algoritmo de ordenação BubbleSort! 

function bubblesort (vet: array of longword; qnt : longword; var cont_ite : double): double;
var
	tempoinicio, tempofim, tempototal : double;
	ts, ts2 : TTimeStamp; // TTimeStamp e um tipo de dado definido na unit sysutils.
	i, j, k : longword;
	aux : longword;

begin
	TS := DateTimeToTimeStamp(now); // armazenda em TS o tempo atual
	tempoinicio := TimeStampToMSecs(TS); // converte o tempo atual para milisegundos
	k := qnt - 1;
	for	i := k downto 1 do
	begin
		for j := 1 to i do
		begin
			if (vet[j] > vet[j+1]) then
			begin
				aux := vet[j];
				vet[j] := vet[j+1];
				vet[j+1] := aux;
				cont_ite := cont_ite + 1;
			end;
		end;
		k := k - 1;
	end;

	TS2 := DateTimeToTimeStamp(now);
	tempofim := TimeStampToMSecs(TS2);
	tempototal := tempofim - tempoinicio; // calcula o tempo gasto na execucao da funcao
	bubblesort := tempototal; // Salva o valor do tempo total na função BubbleSort
end;

// Inicio da Funcao do algoritmo de ordenacao SelectionSort!

function selectionsort (vet: array of longword; qnt :longword; var cont_ite:double): double;
var
	tempoinicio, tempofim, tempototal : double;
	ts, ts2 : TTimeStamp;
	i, j,pos : longword;
	aux : longword;

begin
	TS := DateTimeToTimeStamp(now); // armazenda em TS o tempo atual
	tempoinicio := TimeStampToMSecs(TS); // converte o tempo atual para milisegundos

	for i:=0 to qnt-1 do
	begin
		pos:=i;
		for j:= i+1 to qnt do
		begin
			if (vet[j] < vet[pos]) then
			begin
				pos:=j;
			end;
		end;
		aux:=vet[pos];
		vet[pos]:=vet[i];
		vet[i]:=aux;
		cont_ite:=cont_ite + 1;
	end;

	TS2 := DateTimeToTimeStamp(now);
	tempofim := TimeStampToMSecs(TS2);
	tempototal := tempofim - tempoinicio; // calcula o tempo gasto na execucao da funcao
	selectionsort := tempototal; // Salva o resultado do tempo total na função selectionsort
end;

// Inicio da Funcao do algoritmo de ordenação InsertionSort! 

function insertionsort(vet: array of longword; qnt :longword; var cont_ite:double): double;
var
	tempoinicio, tempofim, tempototal : double;
	ts, ts2 : TTimeStamp;
	i, j: longword;
	aux : longword;

begin
	TS := DateTimeToTimeStamp(now); // armazenda em TS o tempo atual
	tempoinicio := TimeStampToMSecs(TS); // converte o tempo atual para milisegundos

	for i := 2 to qnt do
	begin
		aux := vet[i];
		j := (i - 1);
		vet[0] := aux;
		cont_ite := cont_ite + 1;

		while (aux < vet[ j ]) do
		begin
			vet[j + 1] := vet[j];
			dec(j);
			cont_ite := cont_ite + 2;
		end;
		vet[j + 1] := aux;
		cont_ite := cont_ite + 1;
	end;

	TS2 := DateTimeToTimeStamp(now);
	tempofim := TimeStampToMSecs(TS2);
	tempototal := tempofim - tempoinicio; // calcula o tempo gasto na execução da funcao
	insertionsort := tempototal;
end;

// Inicio da Funcao do algoritmo de ordenacao ShellSort!

function shellsort(vet: array of longword; qnt :longword; var cont_ite:double): double;
var
	tempoinicio, tempofim, tempototal : double;
	ts, ts2 : TTimeStamp;
	i, j, h,x: longword;

begin
	TS := DateTimeToTimeStamp(now); // armazenda em TS o tempo atual
	tempoinicio := TimeStampToMSecs(TS); // converte o tempo atual para milisegundos
	
	h := 1;
	repeat
		h := 3 * h + 1;
		cont_ite := cont_ite+1;
	until h > qnt;
	repeat
		h := h div 3;
		cont_ite := cont_ite + 1;
		for i := h + 1 to qnt do
		begin
			x := vet[i];
			j := i;
			cont_ite := cont_ite+2;
			while (j > h) and (vet[j - h] > x) do
			begin
				vet[j] := vet[j - h];
				j := j - h;
				cont_ite:=cont_ite+2;
			end;
			vet[j] := x;
			cont_ite := cont_ite+1;
		end;
	until h = 1;

	TS2 := DateTimeToTimeStamp(now);
	tempofim := TimeStampToMSecs(TS2);
	tempototal := tempofim - tempoinicio; // calcula o tempo gasto na execucao da função
	shellsort := tempototal;
end;

//Início da Funcao do algoritmo de ordenacao HeapSort!

function heapsort (vet: array of longword; qnt :longword; var cont_ite:double): double;
var
	tempoinicio, tempofim, tempototal : double;
	ts, ts2 : TTimeStamp;
	i, j, x, aux: longword;
	Esq, Dir : longword;

begin
	TS := DateTimeToTimeStamp(now); // armazenda em TS o tempo atual
	tempoinicio := TimeStampToMSecs(TS); // converte o tempo atual para milisegundos

	Esq := (qnt div 2) + 1;
	cont_ite := cont_ite + 1;
	Dir := qnt;
	cont_ite := cont_ite + 1;
	while Esq > 1 do
	begin
		Esq := Esq - 1;
		i := Esq; j := 2 * i;
		x := vet[i];
		cont_ite := cont_ite + 3;
		while j <= Dir do
		begin
			if (j < Dir) and (vet[j] < vet[j + 1]) then inc(j); cont_ite := cont_ite + 1;
			if   x >= vet[j] then break;
			vet[i] := vet[j];
			i := j; j := 2 * i;
			cont_ite := cont_ite + 3;
		end;
		vet[i] := x;
		cont_ite := cont_ite + 1;
	end;

	while Dir > 1 do
	begin
		aux := vet[1];
		vet[1] := vet[Dir];
		vet[Dir] := aux;
		Dir := Dir - 1;
		i := Esq; j := 2 * i;
		x := vet[i];
		cont_ite := cont_ite + 2;
		while j <= Dir do
		begin
			if (j < Dir) and (vet[j] < vet[j + 1]) then inc(j); cont_ite := cont_ite + 1;
			if x >= vet[j] then break;
			vet[i] := vet[j];
			i := j; j := 2 * i;
			cont_ite := cont_ite + 2;
		end;
		vet[i] := x;
		cont_ite := cont_ite + 1;
	end;

	TS2 := DateTimeToTimeStamp(now);
	tempofim := TimeStampToMSecs(TS2);
	tempototal := tempofim - tempoinicio; // calcula o tempo gasto na execucao da funcao
	heapsort := tempototal;
end;

// Inicio da Funcao do algoritmo de ordenação QuickSort (elemento Meio)

function quick_meio(vet: array of longword; qnt : longword; var cont_ite : double): double;
var
	tempoinicio, tempofim, tempototal : double;
	ts, ts2 : TTimeStamp;

begin
	TS := DateTimeToTimeStamp(now); // armazenda em TS o tempo atual
	tempoinicio := TimeStampToMSecs(TS); // converte o tempo atual para milisegundos

	Ordena(vet,1,qnt,cont_ite);
	
	
	TS2 := DateTimeToTimeStamp(now);
	tempofim := TimeStampToMSecs(TS2);
	tempototal := tempofim - tempoinicio; // calcula o tempo gasto na execução da funcao
	quick_meio := tempototal;
end;

// Início da Funcao do algoritmo de ordenação QuickSort (elemento Primeiro)

function quick_primeiro(vet: array of longword; qnt :longword; var cont_ite : double): double;
var
	tempoinicio, tempofim, tempototal : double;
	ts, ts2 : TTimeStamp;

begin
	TS := DateTimeToTimeStamp(now); // armazenda em TS o tempo atual
	tempoinicio := TimeStampToMSecs(TS); // converte o tempo atual para milisegundos

	Ordena2(vet, 1, qnt, cont_ite);
	
	
	TS2 := DateTimeToTimeStamp(now);
	tempofim := TimeStampToMSecs(TS2);
	tempototal := tempofim - tempoinicio; // calcula o tempo gasto na execucao da funcao
	quick_primeiro := tempototal;
end;

// Inicio da Funcao do algoritmo de ordenação QuickSort (elemento Ultimo)

function quick_ultimo(vet: array of longword; qnt :longword; var cont_ite : double): double;
var
	tempoinicio, tempofim, tempototal : double;
	ts, ts2 : TTimeStamp;

begin
	TS := DateTimeToTimeStamp(now); // armazenda em TS o tempo atual
	tempoinicio := TimeStampToMSecs(TS); // converte o tempo atual para milisegundos
	Ordena3(vet, 1, qnt, cont_ite);
	TS2 := DateTimeToTimeStamp(now);
	tempofim := TimeStampToMSecs(TS2);
	tempototal := tempofim - tempoinicio; // calcula o tempo gasto na execução da função
	quick_ultimo := tempototal;
end;

// Inicio da Funcao do algoritmo de ordenação QuickSort (elemento randomico)

function quick_random(vet: array of longword; qnt :longword;var cont_ite:double): double;
var
	tempoinicio, tempofim, tempototal : double;
	ts, ts2 : TTimeStamp;

begin
	TS := DateTimeToTimeStamp(now); // armazenda em TS o tempo atual
	tempoinicio := TimeStampToMSecs(TS); // converte o tempo atual para milisegundos
	Ordena4(vet, 1, qnt, cont_ite);	
	TS2 := DateTimeToTimeStamp(now);
	tempofim := TimeStampToMSecs(TS2);
	tempototal := tempofim - tempoinicio; // calcula o tempo gasto na execução da função
	quick_random := tempototal;
end;

// Inicio da Funcao do algoritmo de ordenação QuickSort (elemento Mediana)

function quick_mediana(vet: array of longword; qnt :longword;var cont_ite:double): double;
var
	tempoinicio, tempofim, tempototal : double;
	ts, ts2 : TTimeStamp;

begin
	TS := DateTimeToTimeStamp(now); // armazenda em TS o tempo atual
	tempoinicio := TimeStampToMSecs(TS); // converte o tempo atual para milisegundos
	Ordena5(vet, 1, qnt, cont_ite);
	TS2 := DateTimeToTimeStamp(now);
	tempofim := TimeStampToMSecs(TS2);
	tempototal := tempofim - tempoinicio; // calcula o tempo gasto na execução da função
	quick_mediana := tempototal;
end;

// Inicio da Funcao do algoritmo de ordenacao QuickSort (Combo com Insertion Sort}

function IntroSort(vet:array of longword; tam:longword; var cont_ite:double): double;

	procedure Insercao(var vet:array of longword; tam:longword; var cont_ite: double);
	var
	    i, j, value:longword;

	begin
	    i:=1;
	    while(i < tam) do
       	begin
        	value := vet[i];
        	cont_ite := cont_ite + 1;
            j := i - 1;
            while ((j >= 0) and (vet[j] > value))do
            begin
                vet[j + 1] := vet[j];
                vet[j] := value;
                dec(j);
            end;
            inc(i);
       end;
	end;

	procedure OrdenaIntro(inicio, fim:longword; var cont_ite: double);
	var i, j, aux, pivo : longword;
	begin
		i := inicio;
		j := fim;
		if (i >= j) then aux := 0
        else
        begin
	    	if ((fim - inicio) < (30)) then Insercao(vet[inicio], (fim-inicio) + 1, cont_ite);
	    	// 30 foi o valor escolhido para M (chamar o InsertionSort)
	     	pivo := vet[(inicio+fim)div 2];
		    while (i < j) do
           	begin
	            while ((i < j) and (vet[i] < pivo)) do inc(i);
	            while ((i < j) and (vet[j] > pivo)) do dec(j);
		            if (i < j) then
	                begin
	                	cont_ite := cont_ite + 1;
		                aux := vet[i];
		                vet[i] := vet[j];
		                vet[j] := aux;
		                inc(i);
		                dec(j);
	               	end;
	        end;
		    if (j < i) then
            begin
	            aux := j;
	            j := i;
	            i := aux;
        	end;
         	OrdenaIntro(inicio, i, cont_ite);
     		if (i = inicio) then
        	begin
                OrdenaIntro(i + 1, fim, cont_ite);
            end
            else
            begin
                OrdenaIntro(i, fim, cont_ite);
            end;
    	end;
	end;

var tempoinicio, tempofim, tempototal : double;
    ts, ts2 : TTimeStamp;

begin
	TS := DateTimeToTimeStamp(now); // armazenda em TS o tempo atual
	tempoinicio := TimeStampToMSecs(TS); // converte o tempo atual para milisegundos
    OrdenaIntro(1, tam, cont_ite);
	TS2 := DateTimeToTimeStamp(now);
    tempofim := TimeStampToMSecs(TS2);
   	tempototal := tempofim - tempoinicio; // calcula o tempo gasto na execução da funcao
    IntroSort := tempototal;
end;

var opcao: byte;
	i:longword;
	soma_bolha, soma_selection, soma_insertion, soma_shell, soma_heap, soma_quick_meio,
	soma_quick_primeiro, soma_quick_ultimo, soma_quick_random, soma_quick_mediana, cont_bolha,
	cont_selection, cont_insertion, cont_shell, cont_heap, cont_quick_m, cont_quick_p,
	cont_quick_u, cont_quick_r, cont_quick_med, cont_introsort, soma_introsort : double;
begin
	
	// Escolha da massa de entradas para a realizacao dos testes de cada algoritmo de ordenacao
	
	clrscr;
	writeln('Escolha uma massa de entrada: ');
	writeln;
	writeln('1 = 500');
	writeln('2 = 2000');
	writeln('3 = 10000');
	writeln('4 = 30000');
	writeln('5 = 50000');
	writeln('6 = 100000');
	writeln('7 = 150000');
	writeln('8 = 200000');
	writeln('9 = 250000');
	writeln('10 = 300000');
	writeln;
	write('Opção: ');
	read(opcao);
	writeln;
	write('Ordenando');
	delay(500);
	write('.');
	delay(500);
	write('.');
	delay(500);
	write('.');
	writeln;

	{
		Em cada case ha uma massa de entrada diferente.
		Primeiramente 500, 2000, 10000,30000,50000,100000,150000,200000,250000 e 300000 elementos.
		Sao inicializadas todas as variaveis : Tempo de execucao de cada algoritmo e contadores de iteracoes.
		Apos inicializadas as variaveis, e executado um For que vai de 1 a 100, 
		testando os algoritmos com diferentes elementos, sendo que em cada passagem
		o vetor e o mesmo para cada algoritmo. Apos rodados todos os algoritmos 100 vezes,
		e feita uma media de tempo de cada algoritmo e do numero de iteracoes.
	}
	
	case opcao of
		1 : begin
				soma_bolha := 0;
				soma_selection := 0;
				soma_insertion := 0;
				soma_shell := 0;
				soma_heap := 0;
				soma_quick_meio := 0;
				soma_quick_primeiro := 0;
				soma_quick_ultimo := 0;
				soma_quick_random := 0;
				soma_quick_mediana := 0;
				soma_quick_mediana := 0;
				soma_introsort := 0;
				cont_bolha := 0;
				cont_selection := 0;
				cont_insertion := 0;
				cont_shell := 0;
				cont_heap := 0;
				cont_quick_m := 0;
				cont_quick_p := 0;
				cont_quick_u := 0;
				cont_quick_r := 0;
				cont_quick_med := 0;
				cont_introsort := 0;
				tam := 500;

				for i:=1 to 100 do
				begin
					vetor := gerar(tam);
					soma_bolha := soma_bolha + bubblesort(vetor, tam, cont_bolha);
					soma_selection := soma_selection + selectionsort(vetor, tam, cont_selection);
					soma_insertion := soma_insertion + insertionsort(vetor, tam, cont_insertion);
					soma_shell := soma_shell + shellsort(vetor, tam, cont_shell);
					soma_heap := soma_heap + heapsort(vetor, tam, cont_heap);
					soma_quick_meio := soma_quick_meio + quick_meio(vetor, tam, cont_quick_m);
					soma_quick_primeiro:=soma_quick_primeiro + quick_primeiro(vetor, tam, cont_quick_p);
					soma_quick_ultimo:=soma_quick_ultimo + quick_ultimo(vetor, tam, cont_quick_u);
					soma_quick_random:=soma_quick_random + quick_random(vetor, tam, cont_quick_r);
					soma_quick_mediana:=soma_quick_mediana + quick_mediana(vetor, tam, cont_quick_med);
					soma_introsort := soma_introsort + IntroSort(vetor, tam, cont_introsort);
				end;
		
				writeln('Media BubbleSort: ',(soma_bolha/100):0:3,' milisegundos || Iteracoes medias : ',(cont_bolha/100):0:0);
				writeln('Media SelectionSort: ',(soma_selection/100):0:3,' milisegundos || Iteracoes medias : ',(cont_selection/100):0:0);
				writeln('Media InsertionSort: ',(soma_insertion/100):0:3,' milisegundos || Iteracoes medias : ',(cont_insertion/100):0:0);
				writeln('Media ShellSort: ',(soma_shell/100):0:3,' milisegundos || Iteracoes medias : ',(cont_shell/100):0:0);
				writeln('Media HeapSort: ',(soma_heap/100):0:3,' milisegundos || Iteracoes medias : ',(cont_heap/100):0:0);
				writeln('Media QuickSort (meio): ',(soma_quick_meio/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_m/100):0:0);
				writeln('Media QuickSort (primeiro elemento): ',(soma_quick_primeiro/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_p/100):0:0);
				writeln('Media QuickSort (ultimo elemento): ',(soma_quick_ultimo/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_u/100):0:0);
				writeln('Media QuickSort (elemento randomico): ',(soma_quick_random/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_r/100):0:0);
				writeln('Media QuickSort (mediana): ',(soma_quick_mediana/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_med/100):0:0);
				writeln('Media IntroSort: ',(soma_introsort/100):0:3,' milisegundos || Iteracoes medias : ',(cont_introsort/100):0:0);
				readln;
			end;

		2 : begin
				soma_bolha := 0;
				soma_selection := 0;
				soma_insertion := 0;
				soma_shell := 0;
				soma_heap := 0;
				soma_quick_meio := 0;
				soma_quick_primeiro := 0;
				soma_quick_ultimo := 0;
				soma_quick_random := 0;
				soma_quick_mediana := 0;
				soma_quick_mediana := 0;
				soma_introsort := 0;
				cont_bolha := 0;
				cont_selection := 0;
				cont_insertion := 0;
				cont_shell := 0;
				cont_heap := 0;
				cont_quick_m := 0;
				cont_quick_p := 0;
				cont_quick_u := 0;
				cont_quick_r := 0;
				cont_quick_med := 0;
				cont_introsort := 0;
				tam := 2000;

				for i:=1 to 100 do
				begin
					vetor := gerar(tam);
					soma_bolha := soma_bolha + bubblesort(vetor, tam, cont_bolha);
					soma_selection := soma_selection + selectionsort(vetor, tam, cont_selection);
					soma_insertion := soma_insertion + insertionsort(vetor, tam, cont_insertion);
					soma_shell := soma_shell + shellsort(vetor, tam, cont_shell);
					soma_heap := soma_heap + heapsort(vetor, tam, cont_heap);
					soma_quick_meio := soma_quick_meio + quick_meio(vetor, tam, cont_quick_m);
					soma_quick_primeiro:=soma_quick_primeiro + quick_primeiro(vetor, tam, cont_quick_p);
					soma_quick_ultimo:=soma_quick_ultimo + quick_ultimo(vetor, tam, cont_quick_u);
					soma_quick_random:=soma_quick_random + quick_random(vetor, tam, cont_quick_r);
					soma_quick_mediana:=soma_quick_mediana + quick_mediana(vetor, tam, cont_quick_med);
					soma_introsort := soma_introsort + IntroSort(vetor, tam, cont_introsort);
				end;
		
				writeln('Media BubbleSort: ',(soma_bolha/100):0:3,' milisegundos || Iteracoes medias : ',(cont_bolha/100):0:0);
				writeln('Media SelectionSort: ',(soma_selection/100):0:3,' milisegundos || Iteracoes medias : ',(cont_selection/100):0:0);
				writeln('Media InsertionSort: ',(soma_insertion/100):0:3,' milisegundos || Iteracoes medias : ',(cont_insertion/100):0:0);
				writeln('Media ShellSort: ',(soma_shell/100):0:3,' milisegundos || Iteracoes medias : ',(cont_shell/100):0:0);
				writeln('Media HeapSort: ',(soma_heap/100):0:3,' milisegundos || Iteracoes medias : ',(cont_heap/100):0:0);
				writeln('Media QuickSort (meio): ',(soma_quick_meio/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_m/100):0:0);
				writeln('Media QuickSort (primeiro elemento): ',(soma_quick_primeiro/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_p/100):0:0);
				writeln('Media QuickSort (ultimo elemento): ',(soma_quick_ultimo/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_u/100):0:0);
				writeln('Media QuickSort (elemento randomico): ',(soma_quick_random/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_r/100):0:0);
				writeln('Media QuickSort (mediana): ',(soma_quick_mediana/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_med/100):0:0);
				writeln('Media IntroSort: ',(soma_introsort/100):0:3,' milisegundos || Iteracoes medias : ',(cont_introsort/100):0:0);
				readln;
			end;

		3 : begin
				soma_bolha := 0;
				soma_selection := 0;
				soma_insertion := 0;
				soma_shell := 0;
				soma_heap := 0;
				soma_quick_meio := 0;
				soma_quick_primeiro := 0;
				soma_quick_ultimo := 0;
				soma_quick_random := 0;
				soma_quick_mediana := 0;
				soma_quick_mediana := 0;
				soma_introsort := 0;
				cont_bolha := 0;
				cont_selection := 0;
				cont_insertion := 0;
				cont_shell := 0;
				cont_heap := 0;
				cont_quick_m := 0;
				cont_quick_p := 0;
				cont_quick_u := 0;
				cont_quick_r := 0;
				cont_quick_med := 0;
				cont_introsort := 0;
				tam := 10000;

				for i:=1 to 100 do
				begin
					vetor := gerar(tam);
					soma_bolha := soma_bolha + bubblesort(vetor, tam, cont_bolha);
					soma_selection := soma_selection + selectionsort(vetor, tam, cont_selection);
					soma_insertion := soma_insertion + insertionsort(vetor, tam, cont_insertion);
					soma_shell := soma_shell + shellsort(vetor, tam, cont_shell);
					soma_heap := soma_heap + heapsort(vetor, tam, cont_heap);
					soma_quick_meio := soma_quick_meio + quick_meio(vetor, tam, cont_quick_m);
					soma_quick_primeiro:=soma_quick_primeiro + quick_primeiro(vetor, tam, cont_quick_p);
					soma_quick_ultimo:=soma_quick_ultimo + quick_ultimo(vetor, tam, cont_quick_u);
					soma_quick_random:=soma_quick_random + quick_random(vetor, tam, cont_quick_r);
					soma_quick_mediana:=soma_quick_mediana + quick_mediana(vetor, tam, cont_quick_med);
					soma_introsort := soma_introsort + IntroSort(vetor, tam, cont_introsort);
				end;
		
				writeln('Media BubbleSort: ',(soma_bolha/100):0:3,' milisegundos || Iteracoes medias : ',(cont_bolha/100):0:0);
				writeln('Media SelectionSort: ',(soma_selection/100):0:3,' milisegundos || Iteracoes medias : ',(cont_selection/100):0:0);
				writeln('Media InsertionSort: ',(soma_insertion/100):0:3,' milisegundos || Iteracoes medias : ',(cont_insertion/100):0:0);
				writeln('Media ShellSort: ',(soma_shell/100):0:3,' milisegundos || Iteracoes medias : ',(cont_shell/100):0:0);
				writeln('Media HeapSort: ',(soma_heap/100):0:3,' milisegundos || Iteracoes medias : ',(cont_heap/100):0:0);
				writeln('Media QuickSort (meio): ',(soma_quick_meio/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_m/100):0:0);
				writeln('Media QuickSort (primeiro elemento): ',(soma_quick_primeiro/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_p/100):0:0);
				writeln('Media QuickSort (ultimo elemento): ',(soma_quick_ultimo/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_u/100):0:0);
				writeln('Media QuickSort (elemento randomico): ',(soma_quick_random/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_r/100):0:0);
				writeln('Media QuickSort (mediana): ',(soma_quick_mediana/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_med/100):0:0);
				writeln('Media IntroSort: ',(soma_introsort/100):0:3,' milisegundos || Iteracoes medias : ',(cont_introsort/100):0:0);
				readln;
			end;

		4 : begin
				soma_bolha := 0;
				soma_selection := 0;
				soma_insertion := 0;
				soma_shell := 0;
				soma_heap := 0;
				soma_quick_meio := 0;
				soma_quick_primeiro := 0;
				soma_quick_ultimo := 0;
				soma_quick_random := 0;
				soma_quick_mediana := 0;
				soma_quick_mediana := 0;
				soma_introsort := 0;
				cont_bolha := 0;
				cont_selection := 0;
				cont_insertion := 0;
				cont_shell := 0;
				cont_heap := 0;
				cont_quick_m := 0;
				cont_quick_p := 0;
				cont_quick_u := 0;
				cont_quick_r := 0;
				cont_quick_med := 0;
				cont_introsort := 0;
				tam := 30000;

				for i:=1 to 100 do
				begin
					vetor := gerar(tam);
					soma_bolha := soma_bolha + bubblesort(vetor, tam, cont_bolha);
					soma_selection := soma_selection + selectionsort(vetor, tam, cont_selection);
					soma_insertion := soma_insertion + insertionsort(vetor, tam, cont_insertion);
					soma_shell := soma_shell + shellsort(vetor, tam, cont_shell);
					soma_heap := soma_heap + heapsort(vetor, tam, cont_heap);
					soma_quick_meio := soma_quick_meio + quick_meio(vetor, tam, cont_quick_m);
					soma_quick_primeiro:=soma_quick_primeiro + quick_primeiro(vetor, tam, cont_quick_p);
					soma_quick_ultimo:=soma_quick_ultimo + quick_ultimo(vetor, tam, cont_quick_u);
					soma_quick_random:=soma_quick_random + quick_random(vetor, tam, cont_quick_r);
					soma_quick_mediana:=soma_quick_mediana + quick_mediana(vetor, tam, cont_quick_med);
					soma_introsort := soma_introsort + IntroSort(vetor, tam, cont_introsort);
				end;
		
				writeln('Media BubbleSort: ',(soma_bolha/100):0:3,' milisegundos || Iteracoes medias : ',(cont_bolha/100):0:0);
				writeln('Media SelectionSort: ',(soma_selection/100):0:3,' milisegundos || Iteracoes medias : ',(cont_selection/100):0:0);
				writeln('Media InsertionSort: ',(soma_insertion/100):0:3,' milisegundos || Iteracoes medias : ',(cont_insertion/100):0:0);
				writeln('Media ShellSort: ',(soma_shell/100):0:3,' milisegundos || Iteracoes medias : ',(cont_shell/100):0:0);
				writeln('Media HeapSort: ',(soma_heap/100):0:3,' milisegundos || Iteracoes medias : ',(cont_heap/100):0:0);
				writeln('Media QuickSort (meio): ',(soma_quick_meio/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_m/100):0:0);
				writeln('Media QuickSort (primeiro elemento): ',(soma_quick_primeiro/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_p/100):0:0);
				writeln('Media QuickSort (ultimo elemento): ',(soma_quick_ultimo/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_u/100):0:0);
				writeln('Media QuickSort (elemento randomico): ',(soma_quick_random/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_r/100):0:0);
				writeln('Media QuickSort (mediana): ',(soma_quick_mediana/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_med/100):0:0);
				writeln('Media IntroSort: ',(soma_introsort/100):0:3,' milisegundos || Iteracoes medias : ',(cont_introsort/100):0:0);
				readln;
			end;

		5 : begin
				soma_bolha := 0;
				soma_selection := 0;
				soma_insertion := 0;
				soma_shell := 0;
				soma_heap := 0;
				soma_quick_meio := 0;
				soma_quick_primeiro := 0;
				soma_quick_ultimo := 0;
				soma_quick_random := 0;
				soma_quick_mediana := 0;
				soma_quick_mediana := 0;
				soma_introsort := 0;
				cont_bolha := 0;
				cont_selection := 0;
				cont_insertion := 0;
				cont_shell := 0;
				cont_heap := 0;
				cont_quick_m := 0;
				cont_quick_p := 0;
				cont_quick_u := 0;
				cont_quick_r := 0;
				cont_quick_med := 0;
				cont_introsort := 0;
				tam := 50000;

				for i:=1 to 100 do
				begin
					vetor := gerar(tam);
					soma_bolha := soma_bolha + bubblesort(vetor, tam, cont_bolha);
					soma_selection := soma_selection + selectionsort(vetor, tam, cont_selection);
					soma_insertion := soma_insertion + insertionsort(vetor, tam, cont_insertion);
					soma_shell := soma_shell + shellsort(vetor, tam, cont_shell);
					soma_heap := soma_heap + heapsort(vetor, tam, cont_heap);
					soma_quick_meio := soma_quick_meio + quick_meio(vetor, tam, cont_quick_m);
					soma_quick_primeiro:=soma_quick_primeiro + quick_primeiro(vetor, tam, cont_quick_p);
					soma_quick_ultimo:=soma_quick_ultimo + quick_ultimo(vetor, tam, cont_quick_u);
					soma_quick_random:=soma_quick_random + quick_random(vetor, tam, cont_quick_r);
					soma_quick_mediana:=soma_quick_mediana + quick_mediana(vetor, tam, cont_quick_med);
					soma_introsort := soma_introsort + IntroSort(vetor, tam, cont_introsort);
				end;
		
				writeln('Media BubbleSort: ',(soma_bolha/100):0:3,' milisegundos || Iteracoes medias : ',(cont_bolha/100):0:0);
				writeln('Media SelectionSort: ',(soma_selection/100):0:3,' milisegundos || Iteracoes medias : ',(cont_selection/100):0:0);
				writeln('Media InsertionSort: ',(soma_insertion/100):0:3,' milisegundos || Iteracoes medias : ',(cont_insertion/100):0:0);
				writeln('Media ShellSort: ',(soma_shell/100):0:3,' milisegundos || Iteracoes medias : ',(cont_shell/100):0:0);
				writeln('Media HeapSort: ',(soma_heap/100):0:3,' milisegundos || Iteracoes medias : ',(cont_heap/100):0:0);
				writeln('Media QuickSort (meio): ',(soma_quick_meio/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_m/100):0:0);
				writeln('Media QuickSort (primeiro elemento): ',(soma_quick_primeiro/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_p/100):0:0);
				writeln('Media QuickSort (ultimo elemento): ',(soma_quick_ultimo/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_u/100):0:0);
				writeln('Media QuickSort (elemento randomico): ',(soma_quick_random/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_r/100):0:0);
				writeln('Media QuickSort (mediana): ',(soma_quick_mediana/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_med/100):0:0);
				writeln('Media IntroSort: ',(soma_introsort/100):0:3,' milisegundos || Iteracoes medias : ',(cont_introsort/100):0:0);
				readln;
			end;

		6 : begin
				soma_bolha := 0;
				soma_selection := 0;
				soma_insertion := 0;
				soma_shell := 0;
				soma_heap := 0;
				soma_quick_meio := 0;
				soma_quick_primeiro := 0;
				soma_quick_ultimo := 0;
				soma_quick_random := 0;
				soma_quick_mediana := 0;
				soma_quick_mediana := 0;
				soma_introsort := 0;
				cont_bolha := 0;
				cont_selection := 0;
				cont_insertion := 0;
				cont_shell := 0;
				cont_heap := 0;
				cont_quick_m := 0;
				cont_quick_p := 0;
				cont_quick_u := 0;
				cont_quick_r := 0;
				cont_quick_med := 0;
				cont_introsort := 0;
				tam := 100000;

				for i:=1 to 100 do
				begin
					vetor := gerar(tam);
					soma_bolha := soma_bolha + bubblesort(vetor, tam, cont_bolha);
					soma_selection := soma_selection + selectionsort(vetor, tam, cont_selection);
					soma_insertion := soma_insertion + insertionsort(vetor, tam, cont_insertion);
					soma_shell := soma_shell + shellsort(vetor, tam, cont_shell);
					soma_heap := soma_heap + heapsort(vetor, tam, cont_heap);
					soma_quick_meio := soma_quick_meio + quick_meio(vetor, tam, cont_quick_m);
					soma_quick_primeiro:=soma_quick_primeiro + quick_primeiro(vetor, tam, cont_quick_p);
					soma_quick_ultimo:=soma_quick_ultimo + quick_ultimo(vetor, tam, cont_quick_u);
					soma_quick_random:=soma_quick_random + quick_random(vetor, tam, cont_quick_r);
					soma_quick_mediana:=soma_quick_mediana + quick_mediana(vetor, tam, cont_quick_med);
					soma_introsort := soma_introsort + IntroSort(vetor, tam, cont_introsort);
				end;
		
				writeln('Media BubbleSort: ',(soma_bolha/100):0:3,' milisegundos || Iteracoes medias : ',(cont_bolha/100):0:0);
				writeln('Media SelectionSort: ',(soma_selection/100):0:3,' milisegundos || Iteracoes medias : ',(cont_selection/100):0:0);
				writeln('Media InsertionSort: ',(soma_insertion/100):0:3,' milisegundos || Iteracoes medias : ',(cont_insertion/100):0:0);
				writeln('Media ShellSort: ',(soma_shell/100):0:3,' milisegundos || Iteracoes medias : ',(cont_shell/100):0:0);
				writeln('Media HeapSort: ',(soma_heap/100):0:3,' milisegundos || Iteracoes medias : ',(cont_heap/100):0:0);
				writeln('Media QuickSort (meio): ',(soma_quick_meio/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_m/100):0:0);
				writeln('Media QuickSort (primeiro elemento): ',(soma_quick_primeiro/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_p/100):0:0);
				writeln('Media QuickSort (ultimo elemento): ',(soma_quick_ultimo/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_u/100):0:0);
				writeln('Media QuickSort (elemento randomico): ',(soma_quick_random/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_r/100):0:0);
				writeln('Media QuickSort (mediana): ',(soma_quick_mediana/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_med/100):0:0);
				writeln('Media IntroSort: ',(soma_introsort/100):0:3,' milisegundos || Iteracoes medias : ',(cont_introsort/100):0:0);
				readln;
			end;

		7 : begin
				soma_bolha := 0;
				soma_selection := 0;
				soma_insertion := 0;
				soma_shell := 0;
				soma_heap := 0;
				soma_quick_meio := 0;
				soma_quick_primeiro := 0;
				soma_quick_ultimo := 0;
				soma_quick_random := 0;
				soma_quick_mediana := 0;
				soma_quick_mediana := 0;
				soma_introsort := 0;
				cont_bolha := 0;
				cont_selection := 0;
				cont_insertion := 0;
				cont_shell := 0;
				cont_heap := 0;
				cont_quick_m := 0;
				cont_quick_p := 0;
				cont_quick_u := 0;
				cont_quick_r := 0;
				cont_quick_med := 0;
				cont_introsort := 0;
				tam := 150000;

				for i:=1 to 100 do
				begin
					vetor := gerar(tam);
					soma_bolha := soma_bolha + bubblesort(vetor, tam, cont_bolha);
					soma_selection := soma_selection + selectionsort(vetor, tam, cont_selection);
					soma_insertion := soma_insertion + insertionsort(vetor, tam, cont_insertion);
					soma_shell := soma_shell + shellsort(vetor, tam, cont_shell);
					soma_heap := soma_heap + heapsort(vetor, tam, cont_heap);
					soma_quick_meio := soma_quick_meio + quick_meio(vetor, tam, cont_quick_m);
					soma_quick_primeiro:=soma_quick_primeiro + quick_primeiro(vetor, tam, cont_quick_p);
					soma_quick_ultimo:=soma_quick_ultimo + quick_ultimo(vetor, tam, cont_quick_u);
					soma_quick_random:=soma_quick_random + quick_random(vetor, tam, cont_quick_r);
					soma_quick_mediana:=soma_quick_mediana + quick_mediana(vetor, tam, cont_quick_med);
					soma_introsort := soma_introsort + IntroSort(vetor, tam, cont_introsort);
				end;
		
				writeln('Media BubbleSort: ',(soma_bolha/100):0:3,' milisegundos || Iteracoes medias : ',(cont_bolha/100):0:0);
				writeln('Media SelectionSort: ',(soma_selection/100):0:3,' milisegundos || Iteracoes medias : ',(cont_selection/100):0:0);
				writeln('Media InsertionSort: ',(soma_insertion/100):0:3,' milisegundos || Iteracoes medias : ',(cont_insertion/100):0:0);
				writeln('Media ShellSort: ',(soma_shell/100):0:3,' milisegundos || Iteracoes medias : ',(cont_shell/100):0:0);
				writeln('Media HeapSort: ',(soma_heap/100):0:3,' milisegundos || Iteracoes medias : ',(cont_heap/100):0:0);
				writeln('Media QuickSort (meio): ',(soma_quick_meio/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_m/100):0:0);
				writeln('Media QuickSort (primeiro elemento): ',(soma_quick_primeiro/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_p/100):0:0);
				writeln('Media QuickSort (ultimo elemento): ',(soma_quick_ultimo/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_u/100):0:0);
				writeln('Media QuickSort (elemento randomico): ',(soma_quick_random/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_r/100):0:0);
				writeln('Media QuickSort (mediana): ',(soma_quick_mediana/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_med/100):0:0);
				writeln('Media IntroSort: ',(soma_introsort/100):0:3,' milisegundos || Iteracoes medias : ',(cont_introsort/100):0:0);
				readln;
			end;

		8 : begin
				soma_bolha := 0;
				soma_selection := 0;
				soma_insertion := 0;
				soma_shell := 0;
				soma_heap := 0;
				soma_quick_meio := 0;
				soma_quick_primeiro := 0;
				soma_quick_ultimo := 0;
				soma_quick_random := 0;
				soma_quick_mediana := 0;
				soma_quick_mediana := 0;
				soma_introsort := 0;
				cont_bolha := 0;
				cont_selection := 0;
				cont_insertion := 0;
				cont_shell := 0;
				cont_heap := 0;
				cont_quick_m := 0;
				cont_quick_p := 0;
				cont_quick_u := 0;
				cont_quick_r := 0;
				cont_quick_med := 0;
				cont_introsort := 0;
				tam := 200000;

				for i:=1 to 100 do
				begin
					vetor := gerar(tam);
					soma_bolha := soma_bolha + bubblesort(vetor, tam, cont_bolha);
					soma_selection := soma_selection + selectionsort(vetor, tam, cont_selection);
					soma_insertion := soma_insertion + insertionsort(vetor, tam, cont_insertion);
					soma_shell := soma_shell + shellsort(vetor, tam, cont_shell);
					soma_heap := soma_heap + heapsort(vetor, tam, cont_heap);
					soma_quick_meio := soma_quick_meio + quick_meio(vetor, tam, cont_quick_m);
					soma_quick_primeiro:=soma_quick_primeiro + quick_primeiro(vetor, tam, cont_quick_p);
					soma_quick_ultimo:=soma_quick_ultimo + quick_ultimo(vetor, tam, cont_quick_u);
					soma_quick_random:=soma_quick_random + quick_random(vetor, tam, cont_quick_r);
					soma_quick_mediana:=soma_quick_mediana + quick_mediana(vetor, tam, cont_quick_med);
					soma_introsort := soma_introsort + IntroSort(vetor, tam, cont_introsort);
				end;
		
				writeln('Media BubbleSort: ',(soma_bolha/100):0:3,' milisegundos || Iteracoes medias : ',(cont_bolha/100):0:0);
				writeln('Media SelectionSort: ',(soma_selection/100):0:3,' milisegundos || Iteracoes medias : ',(cont_selection/100):0:0);
				writeln('Media InsertionSort: ',(soma_insertion/100):0:3,' milisegundos || Iteracoes medias : ',(cont_insertion/100):0:0);
				writeln('Media ShellSort: ',(soma_shell/100):0:3,' milisegundos || Iteracoes medias : ',(cont_shell/100):0:0);
				writeln('Media HeapSort: ',(soma_heap/100):0:3,' milisegundos || Iteracoes medias : ',(cont_heap/100):0:0);
				writeln('Media QuickSort (meio): ',(soma_quick_meio/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_m/100):0:0);
				writeln('Media QuickSort (primeiro elemento): ',(soma_quick_primeiro/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_p/100):0:0);
				writeln('Media QuickSort (ultimo elemento): ',(soma_quick_ultimo/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_u/100):0:0);
				writeln('Media QuickSort (elemento randomico): ',(soma_quick_random/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_r/100):0:0);
				writeln('Media QuickSort (mediana): ',(soma_quick_mediana/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_med/100):0:0);
				writeln('Media IntroSort: ',(soma_introsort/100):0:3,' milisegundos || Iteracoes medias : ',(cont_introsort/100):0:0);
				readln;
			end;

		9 : begin
				soma_bolha := 0;
				soma_selection := 0;
				soma_insertion := 0;
				soma_shell := 0;
				soma_heap := 0;
				soma_quick_meio := 0;
				soma_quick_primeiro := 0;
				soma_quick_ultimo := 0;
				soma_quick_random := 0;
				soma_quick_mediana := 0;
				soma_quick_mediana := 0;
				soma_introsort := 0;
				cont_bolha := 0;
				cont_selection := 0;
				cont_insertion := 0;
				cont_shell := 0;
				cont_heap := 0;
				cont_quick_m := 0;
				cont_quick_p := 0;
				cont_quick_u := 0;
				cont_quick_r := 0;
				cont_quick_med := 0;
				cont_introsort := 0;
				tam := 250000;

				for i:=1 to 100 do
				begin
					vetor := gerar(tam);
					soma_bolha := soma_bolha + bubblesort(vetor, tam, cont_bolha);
					soma_selection := soma_selection + selectionsort(vetor, tam, cont_selection);
					soma_insertion := soma_insertion + insertionsort(vetor, tam, cont_insertion);
					soma_shell := soma_shell + shellsort(vetor, tam, cont_shell);
					soma_heap := soma_heap + heapsort(vetor, tam, cont_heap);
					soma_quick_meio := soma_quick_meio + quick_meio(vetor, tam, cont_quick_m);
					soma_quick_primeiro:=soma_quick_primeiro + quick_primeiro(vetor, tam, cont_quick_p);
					soma_quick_ultimo:=soma_quick_ultimo + quick_ultimo(vetor, tam, cont_quick_u);
					soma_quick_random:=soma_quick_random + quick_random(vetor, tam, cont_quick_r);
					soma_quick_mediana:=soma_quick_mediana + quick_mediana(vetor, tam, cont_quick_med);
					soma_introsort := soma_introsort + IntroSort(vetor, tam, cont_introsort);
				end;
		
				writeln('Media BubbleSort: ',(soma_bolha/100):0:3,' milisegundos || Iteracoes medias : ',(cont_bolha/100):0:0);
				writeln('Media SelectionSort: ',(soma_selection/100):0:3,' milisegundos || Iteracoes medias : ',(cont_selection/100):0:0);
				writeln('Media InsertionSort: ',(soma_insertion/100):0:3,' milisegundos || Iteracoes medias : ',(cont_insertion/100):0:0);
				writeln('Media ShellSort: ',(soma_shell/100):0:3,' milisegundos || Iteracoes medias : ',(cont_shell/100):0:0);
				writeln('Media HeapSort: ',(soma_heap/100):0:3,' milisegundos || Iteracoes medias : ',(cont_heap/100):0:0);
				writeln('Media QuickSort (meio): ',(soma_quick_meio/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_m/100):0:0);
				writeln('Media QuickSort (primeiro elemento): ',(soma_quick_primeiro/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_p/100):0:0);
				writeln('Media QuickSort (ultimo elemento): ',(soma_quick_ultimo/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_u/100):0:0);
				writeln('Media QuickSort (elemento randomico): ',(soma_quick_random/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_r/100):0:0);
				writeln('Media QuickSort (mediana): ',(soma_quick_mediana/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_med/100):0:0);
				writeln('Media IntroSort: ',(soma_introsort/100):0:3,' milisegundos || Iteracoes medias : ',(cont_introsort/100):0:0);
				readln;
			end;

		10 : begin
				soma_bolha := 0;
				soma_selection := 0;
				soma_insertion := 0;
				soma_shell := 0;
				soma_heap := 0;
				soma_quick_meio := 0;
				soma_quick_primeiro := 0;
				soma_quick_ultimo := 0;
				soma_quick_random := 0;
				soma_quick_mediana := 0;
				soma_quick_mediana := 0;
				soma_introsort := 0;
				cont_bolha := 0;
				cont_selection := 0;
				cont_insertion := 0;
				cont_shell := 0;
				cont_heap := 0;
				cont_quick_m := 0;
				cont_quick_p := 0;
				cont_quick_u := 0;
				cont_quick_r := 0;
				cont_quick_med := 0;
				cont_introsort := 0;
				tam := 300000;

				for i:=1 to 100 do
				begin
					vetor := gerar(tam);
					soma_bolha := soma_bolha + bubblesort(vetor, tam, cont_bolha);
					soma_selection := soma_selection + selectionsort(vetor, tam, cont_selection);
					soma_insertion := soma_insertion + insertionsort(vetor, tam, cont_insertion);
					soma_shell := soma_shell + shellsort(vetor, tam, cont_shell);
					soma_heap := soma_heap + heapsort(vetor, tam, cont_heap);
					soma_quick_meio := soma_quick_meio + quick_meio(vetor, tam, cont_quick_m);
					soma_quick_primeiro:=soma_quick_primeiro + quick_primeiro(vetor, tam, cont_quick_p);
					soma_quick_ultimo:=soma_quick_ultimo + quick_ultimo(vetor, tam, cont_quick_u);
					soma_quick_random:=soma_quick_random + quick_random(vetor, tam, cont_quick_r);
					soma_quick_mediana:=soma_quick_mediana + quick_mediana(vetor, tam, cont_quick_med);
					soma_introsort := soma_introsort + IntroSort(vetor, tam, cont_introsort);
				end;
		
				writeln('Media BubbleSort: ',(soma_bolha/100):0:3,' milisegundos || Iteracoes medias : ',(cont_bolha/100):0:0);
				writeln('Media SelectionSort: ',(soma_selection/100):0:3,' milisegundos || Iteracoes medias : ',(cont_selection/100):0:0);
				writeln('Media InsertionSort: ',(soma_insertion/100):0:3,' milisegundos || Iteracoes medias : ',(cont_insertion/100):0:0);
				writeln('Media ShellSort: ',(soma_shell/100):0:3,' milisegundos || Iteracoes medias : ',(cont_shell/100):0:0);
				writeln('Media HeapSort: ',(soma_heap/100):0:3,' milisegundos || Iteracoes medias : ',(cont_heap/100):0:0);
				writeln('Media QuickSort (meio): ',(soma_quick_meio/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_m/100):0:0);
				writeln('Media QuickSort (primeiro elemento): ',(soma_quick_primeiro/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_p/100):0:0);
				writeln('Media QuickSort (ultimo elemento): ',(soma_quick_ultimo/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_u/100):0:0);
				writeln('Media QuickSort (elemento randomico): ',(soma_quick_random/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_r/100):0:0);
				writeln('Media QuickSort (mediana): ',(soma_quick_mediana/100):0:3,' milisegundos || Iteracoes medias : ',(cont_quick_med/100):0:0);
				writeln('Media IntroSort: ',(soma_introsort/100):0:3,' milisegundos || Iteracoes medias : ',(cont_introsort/100):0:0);
				readln;
			end;
	end;
readln;
end.