/* 
Este é um banco de dados, criado utilizando MySQL, para armazenar o cadastro e consulta de matérias. Os dados foram 
baseados na ementa do curso de Química da USP de São Carlos 
Acesso a ementa - https://uspdigital.usp.br/jupiterweb/listarGradeCurricular?codcg=75&codcur=75014&codhab=200&tipo=N

Procedures
consulta -> Projeta o id e a matéria (o parâmetro pode ser '' para conusltar todas as matérias ou 'nome da matéria' 
			para consultar as matérias que contenham o nome em comum)

add_materia -> Adiciona matérias a grade curricular (os parametros são 'nome da matéria', créditos_aula, créditos_trabalho,
				ID_pré_requisito_1, ID_pré_requisito_2)

grade -> Projeta todas as matérias, créditos de aula, créditos de trabalho e os pré requisitos 1 e 2, caso possuam
*/
create database curso_quimica;

use curso_quimica;

create table materias (
	ID_materia int primary key auto_increment,
	Materia varchar(100) not null,
	Crédito_aula int,
	Crédito_trabalho int,
	ID_prereq_1 int,
	ID_prereq_2 int
);

alter table materias add constraint fk_prereq_1
foreign key (ID_prereq_1) references materias(ID_materia);

alter table materias add constraint fk_prereq_2
foreign key (ID_prereq_2) references materias(ID_materia);

delimiter #
create procedure consulta (p_consulta varchar(30))
begin
	select id_materia id, materia from materias
	where materia like (concat('%',p_consulta,'%')) or ('%%')
	order by materia;
end#

Create procedure add_materia(p_materia varchar(100), 
	p_cred_aula int, 
	p_cred_trab int, 
	p_id_req1 int, 
	p_id_req2 int)
begin
	insert into materias values (null, p_materia, p_cred_aula, p_cred_trab, p_id_req1, p_id_req2);
end#

create procedure grade()
	begin 
		select m.materia, m.Crédito_aula, m.Crédito_trabalho, ifnull(p1.materia, 'Sem requisito') pre_1, ifnull(p2.materia, 'Sem requisito') pre_2
		from materias m
	left join materias p1
	on p1.id_materia = m.ID_prereq_1
	left join materias p2
	on p2.id_materia = m.ID_prereq_2;
	end# 
delimiter ;

-- Semestre 1
call add_materia('Acompanhamento Profissional e Pessoal I', 1, 0, null, null);
call add_materia('Laboratório de Química Geral', 6, 1, null, null);
call add_materia('Introdução à Química', 4, 1, null, null);
call add_materia('Comunicação e Expressão em linguagem Científica I', 2, 1, null, null);
call add_materia('Geometria Analítica', 4, 0, null, null);
call add_materia('Cálculo I', 4, 0, null, null);

-- Semestre 2
call add_materia('Acompanhamento Profissional e Pessoal II', 1, 0, 1, null);
call add_materia('Comunicação e Expressão em Linguagem Científica II', 2, 1, 4, null);
call add_materia('Química Analítica Qualitativa', 4, 0, null, null);
call add_materia('Laboratório de Química Analítica Qualitativa', 4, 0, 2, null);
call add_materia('Fundamentos de Estrutura Atômica Molecular', 3, 1, null, null);
call add_materia('Física I', 5, 0, null, null);
call add_materia('Cálculo II', 4, 0, 6, null);

-- Semestre 3
call add_materia('Estatística e Quimiometria', 4, 2, null, null);
call add_materia('Química Orgânica I', 4, 2, 3, 11);
call add_materia('Análises Quantitativas: Teoria', 4, 0, 9, null);
call add_materia('Análises Quantitativas: Prática', 6, 0, 10, null);
call add_materia('Química Inorgânica I', 3, 1, 11, null);
call add_materia('Física II para Químicos', 2, 1, 12, null);
call add_materia('Cálculo III', 4, 0, 13, null);

-- Semestre 4
call add_materia('Matemática Aplicada à Química', 4, 0, 13, null);
call add_materia('Análise de Compostos Orgânicos', 4, 0, 15, null);
call add_materia('Físico-Química I', 4, 0, 13, null);
call add_materia('Química Orgânica II', 6, 1, 15, null);
call add_materia('Bioquímica I', 4, 0, 15, null);
call add_materia('Química Inorgânica II', 2, 1, 11, null);
call add_materia('Física Aplicada para Químicos', 4, 2, 19, null);

-- Semestre 5
call add_materia('Físico-Química II', 4, 0, 23, null);
call add_materia('Laboratório de Química Orgânica', 8, 2, 15, null);
call add_materia('Análise Instrumental I', 5, 2, 21, 27);
call add_materia('Química Inorgânica III', 3, 1, 18, null);
call add_materia('Química Orgânica III', 4, 0, 24, null);
call add_materia('Bioquímica II', 4, 0, 25, null);
call add_materia('Laboratório de Física Aplicada para Químicos', 2, 1, 27, null);

-- Semestre 6
call add_materia('Laboratório de Físico-Química', 5, 0, 28, null);
call add_materia('Cinética Química e Fotoquímica', 4, 1, 3, null);
call add_materia('Laboratório de Bioquímica', 5, 0, 25, null);
call add_materia('Análise Instrumental II', 4, 1, 27, null);
call add_materia('Laboratório de Química Inorgânica', 5, 1, 31, null);
call add_materia('Química Inorgânica IV', 2, 1, 31, null);

-- Semestre 7
call add_materia('História da Química', 2, 0, null, null);
call add_materia('Cristalografia', 3, 1, null, null);
call add_materia('Química Quântica', 3, 0, 21, 27);
call add_materia('Análise Instrumental III', 4, 2, 28, 27);
