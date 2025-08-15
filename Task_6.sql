use EcommerceDB;

select * from emp;

select * from dept;

/* 
-- Sub-Query/inner query
     Query inside query called Sub-Query
     - select statement placed inside another query.
     - One query called inner query.
     - other query called outer query.
	 - where condition based on unknown value use Sub-Query.
*/
-- Non co-related sub-query
-- Display Employees earning more than blake?
select * from emp where sal>=(select sal from emp where ename='blake');


-- Display Employees who are senior to king ?
select * from emp where hiredate<(select Hiredate from emp where ename='King');

-- Display Employee name earning max salary ? 
select * from emp where sal=(select max(sal) from emp) ;

-- Display Employee having max experience ?
select * from emp where hiredate=(select min(hiredate) from emp);

-- Write query for Who is having max, min experience ? 
select ename, hiredate from emp where hiredate=(select min(hiredate) from emp) OR hiredate=(select max(hiredate) from emp);

-- Display 2nd max salary from emp ? 
select max(sal) from emp where sal!=(select max(sal) from emp);

--  display Name of the employee earning 2nd max sal ?
select ename, sal from emp where sal=(select max(sal) from emp where sal!=(select max(sal) from emp));

-- Employees working at NEW YORK,CHICAGO locations ?
select * from emp where deptno in (select deptno from dept where loc in ('New York', 'Chicago'));

-- Employees working not at NEW YORK,CHICAGO locations ?
select * from emp where deptno not in (select deptno from dept where loc in ('New York', 'Chicago'));

-- Display Employees name and salary earning more than all managers ?
select ename, sal from emp where sal > all(select sal from emp where job='Manager');

/*co-related sub query
  - inner query depends on the outer query and outer query depends on the inner query for its value called co-related sub query.
  (OR)
  - If inner query referenes values of outer query then it is called co-related sub-query.
*/

-- display employees earning more than avg sal of their dept ? 
select * from emp as e where sal>(select avg(sal) from emp where deptno=e.deptno);

-- Employees earning max salary in their dept ? 
select * from emp as e where sal=(select max(sal) from emp where deptno=e.deptno);

/*Derived Table
 - sub queries in FROM clause are called derived tables.
*/

--  To display top 3 max salaries ?
select distinct sal from (select *, dense_rank() over (order by sal desc) as rnk from emp) as E where rnk<=3;

-- Display the employee record whose rank is greater than 5 based on highest salary?
select * from (select *, dense_rank() over(order by sal desc) as rnk from emp) as E where rnk>5;


/* Scalar sub-queries
---
-> Sub-queries in SELECT clause are called scalar sub-queries
*/
-- Display dept wise total salary ?
select deptno, sum(sal) from emp where deptno is not null group by deptno;

-- Display DEPTNO, DEPT_TOTSAL, TOTSAL ?
select deptno, sum(sal)as dept_totsal, (select sum(sal) from emp) as TotalSal from emp group by deptno;

-- Display ranks of the employees based on sal and highest paid should get 1st rank ?	
select empno, ename, sal, dense_rank() over (order by sal desc) as rnk from emp;

-- displays ranks of all the employees but to display top 3 employees?
select * FROM (SELECT Empno,Ename,Sal,DENSE_RANK() OVER(ORDER BY Sal DESC) as Rnk FROM Emp) as E WHERE Rnk<=3;

-- To display top 3 max salaries ? 
select DISTINCT Sal FROM (SELECT Sal,DENSE_RANK() OVER(ORDER BY Sal DESC) as Rnk FROM Emp) as E WHERE Rnk<=3 ORDER BY Sal DESC;







