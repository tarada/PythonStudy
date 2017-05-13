-- 3-1.把peoples表中school不是GDUFS的人全部找出来？（包括school为NULL的人）写出MySQL语句。
select * from peoples where school !='GDUFS' or school is null or school = '';

-- 3-2.查找计算机系每次考试学生的平均成绩(最终显示学生姓名, 考试名称, 平均分)。
select exam_name,average(grade)
from (
	select student_ID,grade,exam_name
    from exam
    ) as T2 
left join (
	select  ID
    from student
) as T1 
on T2.ID = T1.student_ID 
where student.dept_name='comp'
group by exam_name;

-- 3-3.查找女学霸（考试平均分达到80分或80分以上的女生的姓名, 分数
select name,avg(exam.grade) 
from student,exam 
where student.ID = exam.student_ID and sex = 'f' 
group by name 
having avg(exam.grade) >= 80;

-- 3-4.找出人数最少的院系以及其年度预算。
select  dept_name , budget from
student,department 
where student.dept_name = department.dept_name 
group by student.dept_name 
order by count(*) asc limit 0,1;


-- 3-5.计算机系改名了，改成计算机科学系
update department set dept_name = 'comp.sci.' where dept_name = 'comp';

-- 3-6.修改每个系的年度预算，给系的每个学生发2000元奖金
update department set budget = budget+2000*(select count(*) from student  group by dept_name);

-- 3-7.向department表中插入一条数据, dept_name属性的值为avg_budget, building为空, 年度预算为所有院系的年度预算平均值
insert into department (dept_name,building,budget) values ( 'avg_budget',null,sum(budget)/count(budget) from department);

-- 3-8.删除计算机系中考试成绩平均分低于70的学生.
delete from student
where student.ID in (
    select ID
    from (
        select student.ID
        from student, exam
        where student.ID = exam.student_ID
        and student.dept_name = 'computer'
        group by exam.student_ID
        having avg(exam.grade) < 70
    ) 
);

-- 3-9.找出所有正在谈恋爱,但是学习成绩不佳(考试平均分低于75)的学生,强制将其情感状态改为单身.
update student 
set emotion_state = 'single'
where emotion_state = 'loving' 
and name in (
    select name 
    from student, exam 
    where ID = student_ID 
    group by name 
    having avg(exam.grade) < 75
);

-- 