use seminar3;
/*
id	firstname	lastname	post	seniority	salary	age
*/
CREATE TABLE staff
(
id int primary key auto_increment not null,
firstname varchar(40) not null,
lastname varchar(40) not null,
post varchar(40) not null,
seniority int,
salary int,
age int not null
);
select * from staff;
insert into staff 
values (null, 'Вася', 'Петров', 'Начальник', '40', 100000, 60),
(null,'Петр', 'Власов', 'Начальник', '8', 70000, 30),
(null,'Катя', 'Катина', 'Инженер', '2', 70000, 19),
(null,'Саша', 'Сасин', 'Инженер', '12', 50000, 35),
(null,'Иван', 'Иванов', 'Рабочий', '40', 30000, 59),
(null,'Петр', 'Петров', 'Рабочий', '20', 25000, 40),
(null,'Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
(null,'Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
(null,'Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
(null,'Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
(null,'Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
(null,'Людмила', 'Маркина', 'Уборщик', '10', 10000, 49);

/*
.Выведите все записи, отсортированные по полю "age" по возрастанию
2.Выведите все записи, отсортированные по полю “firstname"
3.Выведите записи полей "firstname ", “lastname", "age", отсортированные по полю "firstname " в алфавитном порядке по убыванию
4.Выполните сортировку по полям " firstname " и "age" по убыванию
Выведите уникальные (неповторяющиеся) значения полей "firstname"
*/
select * from staff
order by age;

select * from staff
order by firstname;

select firstname, lastname, age from staff
order by firstname DESC;

select firstname, lastname, age from staff
order by firstname DESC, age DESC;

select distinct firstname from staff;
/*
Отсортируйте записи по возрастанию значений поля "id". Выведите первые две записи данной выборки
Отсортируйте записи по возрастанию значений поля "id". Пропустите первые 4 строки данной выборки и извлеките следующие 3
Отсортируйте записи по убыванию поля "id". Пропустите две строки данной выборки и извлеките следующие за ними 3 строки
Найдите количество сотрудников с должностью «Рабочий»
Посчитайте ежемесячную зарплату начальников
Выведите средний возраст сотрудников, у которых заработная плата больше 30000
Выведите максимальную и минимальную заработные платы
*/
select * from staff limit 2;

select * from staff limit 4,3;

select * from staff 
order by id DESC
limit 2,3;

select count(*) from staff
where post ="рабочий";

select sum(salary) from staff
where post ="начальник";

select avg(age) from staff
where salary > 30000;

select min(salary) AS минимальная, max(salary) AS максимальная from staff;

/*
id	staff_id	date_activity	count_page
*/
CREATE TABLE activity_staff
(
id int primary key auto_increment not null,
staff_id int not null,
date_activity date,
count_page int,
FOREIGN KEY (staff_id) REFERENCES staff (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO activity_staff (staff_id, date_activity, count_page)
VALUES
(1, '2022-01-01', 250),
(2, '2022-01-01', 220),
(3, '2022-01-01', 170),
(1, '2022-01-02', 100),
(2, '2022-01-02', 220),
(3, '2022-01-02', 300),
(7, '2022-01-02', 350),
(1, '2022-01-03', 168),
(2, '2022-01-03', 62),
(3, '2022-01-03', 84);

select * from activity_staff;
/*
Выведите общее количество напечатанных страниц каждым сотрудником
Посчитайте количество страниц за каждый день
Найдите среднее арифметическое по количеству страниц, напечатанных сотрудниками за каждый день
Сгруппируйте данные о сотрудниках по возрасту: 1 группа – младше 20 лет 2 группа – от 20 до 40 лет 3 группа – старше 40 лет Для каждой группы найдите суммарную зарплату
Выведите id сотрудников, которые напечатали более 500 страниц за все дни
*/
select staff_id, sum(count_page) from activity_staff
group by staff_id;

select date_activity, sum(count_page) from activity_staff
group by date_activity;

select date_activity, avg(count_page) AS среднее_колличество_страниц from activity_staff
group by date_activity;

select 
CASE
	when age < 20 then "1 группа"
	when age between 20 AND 40 THEN "2 группа"      # WHEN age between 20 AND 40 THEN 'от 20 до 40 лет'
	when age > 40 then "3 группа"
    else "не определено"
    end AS Name_age,
SUM(salary) from staff   
group by Name_age;

select staff_id, sum(count_page) as sum_str from activity_staff
group by staff_id
having sum_str>500;
-- вариант 2
select staff_id, sum(count_page) as sum_str from activity_staff
group by staff_id
having sum(count_page) > 500;
/*
Выведите дни, когда работало более 3 сотрудников Также укажите кол-во сотрудников, которые работали в выбранные дни.
Выведите должности, у которых средняя заработная плата составляет более 30000*/

select date_activity, count(staff_id) as количество_сотрудников from activity_staff
group by date_activity
having количество_сотрудников > 3;

select post from staff
GROUP by post 
having avg(salary) >30000;

